//
//  ReposViewModel.swift
//  Bliss Assessment
//
//  Created by nathalia karine on 05/12/2024.
//

import Foundation
import Foundation
import Combine

class ReposViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1
    private let pageSize = 10
    private let username = "apple"

    func fetchRepositories() {
        guard !isLoading else { return } 

        isLoading = true
        let urlString = "https://api.github.com/users/\(username)/repos?page=\(currentPage)&per_page=\(pageSize)"
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Repository].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = "Failed to fetch repositories: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] newRepositories in
                self?.repositories.append(contentsOf: newRepositories)
                self?.currentPage += 1
            })
            .store(in: &cancellables)
    }
}

struct Repository: Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String?
}
