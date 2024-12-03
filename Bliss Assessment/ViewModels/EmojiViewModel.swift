//
//  EmojiViewModel.swift
//  Bliss Assessment
//
//  Created by nathalia karine on 03/12/2024.
//

import Foundation
import Combine



class EmojiViewModel: ObservableObject{
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
    }


