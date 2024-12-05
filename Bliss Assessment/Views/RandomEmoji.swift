//
//  RandomEmoji.swift
//  Bliss Assessment
//
//  Created by nathalia karine on 03/12/2024.
//

import SwiftUI

import SwiftUI

struct RandomEmoji: View {
    @State private var randomEmoji: (name: String, url: String?)?
    @StateObject private var viewModel = EmojiViewModel()
    
    
    let emojiName: String
    let emojiURL: String?

    var body: some View {
        ZStack{
            Color("Cinza-bliss")
                .ignoresSafeArea()
            VStack{
                Spacer()
                if let emoji = randomEmoji {
                    VStack {
                        if let urlString = emoji.url, let imageUrl = URL(string: urlString) {
                            AsyncImage(url: imageUrl) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                }
                Button(action: {
                    randomEmoji = viewModel.getRandomEmoji()
                }) {
                    Text("Get Emoji")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
            .onAppear {
                viewModel.fetchEmojis()
            }
        }
        }
    }


#Preview {
    RandomEmoji(emojiName: "", emojiURL: "")
}
