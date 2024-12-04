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
    var body: some View {
        NavigationView{
            
            
            VStack {
                NavigationLink("RANDOM EMOJI", destination: EmojiListView())
                NavigationLink("EMOJI LIST", destination: EmojiListView())
                HStack{
                    TextField("Digite o CEP", text: $search)
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
