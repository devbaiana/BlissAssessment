//
//  MainView.swift
//  Bliss Assessment
//
//  Created by nathalia karine on 03/12/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = EmojiViewModel()
    @State private var search = ""
    @State private var randomEmoji: (name: String, url: String?)?
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                NavigationLink("RANDOM EMOJI", destination: RandomEmoji(emojiName: "", emojiURL: ""))
                NavigationLink("EMOJI LIST", destination: EmojiListView())
                HStack{
                    TextField("Search Emoji", text: $search)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    NavigationLink("SEARCH", destination: EmojiListView())}
                NavigationLink("AVATAR LIST", destination: AvatarListView())
                NavigationLink("APPLE REPOS", destination: RepositoriesView())
            }.padding()
            
        }
    }
    
}

#Preview {
    ContentView()
}
