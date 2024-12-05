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
//    @StateObject private var viewModelAvatar = AvatarViewModel(username: "")
    @State private var username: String = ""
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                
                NavigationLink("RANDOM EMOJI", destination: RandomEmoji(emojiName: "", emojiURL: ""))
                
                NavigationLink("EMOJI LIST", destination: EmojiListView())
                HStack{
                    TextField("Search Username", text: $username) .textFieldStyle(RoundedBorderTextFieldStyle())
                    NavigationLink(destination: AvatarDetailView(username: username)) {
                        Text("Search")
                    }
                }
                
                NavigationLink("AVATAR LIST", destination: AvatarListView())
                
                NavigationLink("APPLE REPOS", destination: RepositoriesView())
            }.padding()
            
        }
    }
    
}

#Preview {
    ContentView()
}
