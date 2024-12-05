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
                Spacer()
                NavigationLink("RANDOM EMOJI", destination: RandomEmoji(emojiName: "", emojiURL: ""))
                    .padding(8)
                    .background(Color("Cinza-bliss"))
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(8)
                
                NavigationLink("EMOJI LIST", destination: EmojiListView())
                    .padding(8)
                    .background(Color("Cinza-bliss"))
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(8)
                
                HStack{
                    TextField("Search Username", text: $username) .textFieldStyle(RoundedBorderTextFieldStyle())
                    NavigationLink(destination: AvatarDetailView(username: username)) {
                        Text("Search")
                    }.padding(8)
                        .background(Color("Cinza-bliss"))
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(8)
                        
                }
                
                NavigationLink("AVATAR LIST", destination: AvatarListView())
                    .padding(8)
                    .background(Color("Cinza-bliss"))
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(8)
                
                NavigationLink("APPLE REPOS", destination: RepositoriesView())
                    .padding(8)
                    .background(Color("Cinza-bliss"))
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(8)
                Spacer()
            }
            .padding(.horizontal, 20.0)
            .background(Color("Blue-bliss"))
            
        }
    }
    

}
#Preview {
    ContentView()
}
