//
//  EmojiViewModel.swift
//  Bliss Assessment
//
//  Created by nathalia karine on 03/12/2024.
//

import Foundation
import Combine
import CoreData


class EmojiViewModel: ObservableObject{
    typealias EmojiMap = [String: String]
    
    @Published var emojis: EmojiMap = [:]
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchEmojis() {
        guard let url = URL(string: "https://api.github.com/emojis") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: EmojiMap.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] emojis in
                self?.emojis = emojis
            })
            .store(in: &cancellables)
    }
    
    
    func salvarEmojisCoreData() {
        let context = CoreDataManager.shared.context
        
        emojis.forEach { key, url in
            let emoji = Emoji(context: context)
            emoji.name = key
            emoji.url = url
        }
        
        CoreDataManager.shared.salvarContext()
        
    }
    func carregarEmojisCoreData() {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<Emoji> = Emoji.fetchRequest()
        
        do {
            let emojiEntities = try context.fetch(fetchRequest)
            emojis = emojiEntities.reduce(into: [String: String]()) { dict, emoji in
                if let name = emoji.name, let url = emoji.url {
                    dict[name] = url
                }
            }
        } catch {
            print("Failed to fetch emojis: \(error)")
        }
    }
    private func fetchEmojisFromAPI() {
        guard let url = URL(string: "https://api.github.com/emojis") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: EmojiMap.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] emojis in
                self?.emojis = emojis
                self?.salvarEmojisCoreData() 
            })
            .store(in: &cancellables)
    }
    func getRandomEmoji() -> (name: String, url: String)? {
        guard !emojis.isEmpty else { return nil }
        let randomKey = emojis.keys.randomElement()!
        return (name: randomKey, url: emojis[randomKey]) as! (name: String, url: String)
    }
}



