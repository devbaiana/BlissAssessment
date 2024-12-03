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
                    if viewModel.emojis.isEmpty {
                        Button(action: {
                            viewModel.fetchEmojis()
                        }) {
                            Text("Get Emojis")
                        }
                    } else {
                        List(viewModel.emojis.keys.sorted(), id: \.self) { key in
                            HStack {
                                if let url = viewModel.emojis[key],
                                   let imageUrl = URL(string: url) {
                                    AsyncImage(url: imageUrl) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            }
                        }
                    }
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text("Error: \(errorMessage)")
                    }
                }
            }
        }
    }



#Preview {
    ContentView()
}
