//
//  AvatarViewModel.swift
//  Bliss Assessment
//
//  Created by nathalia karine on 05/12/2024.
//

import SwiftUI
import Combine
import CoreData

class AvatarViewModel: ObservableObject {
    @Published var username: String
    @Published var avatarImage: UIImage? = nil
    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()
    private let context = PersistenceController.shared.container.viewContext

    init(username: String) {
        self.username = username
    }

    func search() {
        guard !username.isEmpty else { return }

        isLoading = true

        let fetchRequest: NSFetchRequest<UserAvatar> = UserAvatar.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)

        if let result = try? context.fetch(fetchRequest).first, let imageData = result.imageData {
            self.avatarImage = UIImage(data: imageData)
            isLoading = false
            return
        }

        fetchAvatarImage(for: username)
    }

    private func fetchAvatarImage(for username: String) {
        let urlString = "https://api.github.com/users/\(username)"
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, _ -> URL in
                let decoder = JSONDecoder()
                let user = try decoder.decode(GitHubUser.self, from: data)
                guard let avatarUrl = URL(string: user.avatar_url) else {
                    throw URLError(.badURL)
                }
                return avatarUrl
            }
            .flatMap { avatarUrl in
                URLSession.shared.dataTaskPublisher(for: avatarUrl)
                    .map { $0.data }
                    .mapError { $0 as Error }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case let .failure(error) = completion {
                    print("Avatar not found: \(error)")
                }
            }, receiveValue: { data in
                self.avatarImage = UIImage(data: data)
                self.salvarAvatarImage(data: data)
                self.isLoading = false
            })
            .store(in: &cancellables)
    }

    private func salvarAvatarImage(data: Data) {
        let userAvatar = UserAvatar(context: context)
        userAvatar.username = username
        userAvatar.imageData = data
        do {
            try context.save()
        } catch {
            print("Something went wrong to save avatar: \(error)")
        }
    }
}
extension AvatarViewModel {
    func fetchAllAvatars() -> [UserAvatar] {
        let fetchRequest: NSFetchRequest<UserAvatar> = UserAvatar.fetchRequest()

        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            print("Failed to fetch avatars: \(error)")
            return []
        }
    }
    func deleteAvatar(_ avatar: UserAvatar) {
            context.delete(avatar)
            do {
                try context.save()
                print("Avatar deleted \(avatar.username ?? "Unknown")")
            } catch {
                print("Something went wrong to delete avatar: \(error)")
            }
        }
}


struct GitHubUser: Codable {
    let avatar_url: String
}
