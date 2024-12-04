//
//  EmojiListView.swift
//  Bliss Assessment
//
//  Created by nathalia karine on 03/12/2024.
//

import SwiftUI

struct EmojiListView: View {
    @StateObject private var viewModel = EmojiViewModel()
    @State private var visibleEmojis: [String] = []
    @State private var tappedEmojis: Set<String> = []
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(visibleEmojis, id: \.self) { key in
                    VStack {
                        ZStack{
                            if let urlString = viewModel.emojis[key],
                               let imageUrl = URL(string: urlString) {
                                AsyncImage(url: imageUrl) { image in
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 85, height: 85)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.blue)
                                        )
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            if tappedEmojis.contains(key) {
                                Text("X")
                                    .font(.system(size: 90))
                                    .foregroundColor(.red)
                                
                                
                            }
                        }
                    }
                    .onTapGesture {
                        handleTap(key: key)
                    }
                }
            }
            .padding()
            .refreshable {
                visibleEmojis = Array(viewModel.emojis.keys.sorted())
                tappedEmojis.removeAll()
                restoreEmojiList()
            }
            
        }
        
        .navigationTitle("Emoji List")
        .onAppear {
            viewModel.fetchEmojis()
        }
        .onChange(of: viewModel.emojis) { newEmojis in
            visibleEmojis = Array(newEmojis.keys.sorted())
        }    }
    private func removeEmoji(key: String) {
        tappedEmojis.remove(key)
        if let index = visibleEmojis.firstIndex(of: key) {
            visibleEmojis.remove(at: index)
        }
    }
    private func toggleTappedState(for key: String) {
        if tappedEmojis.contains(key) {
            tappedEmojis.remove(key)
        } else {
            tappedEmojis.insert(key)
        }
    }
    private func restoreEmojiList() {
        visibleEmojis = Array(viewModel.emojis.keys.sorted())
        tappedEmojis.removeAll()
    }
    private func handleTap(key: String) {
        if tappedEmojis.contains(key) {
            removeEmoji(key: key)
        } else {
            toggleTappedState(for: key)
        }
    }
}

#Preview {
    EmojiListView()
}
