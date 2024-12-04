//
//  EmojiListView.swift
//  Bliss Assessment
//
//  Created by nathalia karine on 03/12/2024.
//

import SwiftUI

struct EmojiListView: View {
    @StateObject private var viewModel = EmojiViewModel()
    
    //    var body: some View {
    //        if viewModel.emojis.isEmpty {
    //            Button(action: {
    //                viewModel.fetchEmojis()
    //            }) {
    //                Text("Get Emojis")
    //            }
    //        } else {
    //            List(viewModel.emojis.keys.sorted(), id: \.self) { key in
    //                HStack {
    //                    if let url = viewModel.emojis[key],
    //                       let imageUrl = URL(string: url) {
    //                        AsyncImage(url: imageUrl) { image in
    //                            image.resizable()
    //                        } placeholder: {
    //                            ProgressView()
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //
    //        if let errorMessage = viewModel.errorMessage {
    //            Text("Error: \(errorMessage)")
    //        }
    //    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.emojis.isEmpty {
                    Button(action: {
                        viewModel.fetchEmojis()
                    }) {
                        Text("Get Emojis")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                } else {
                    List(viewModel.emojis.keys.sorted(), id: \.self) { key in
                        HStack {
                            if let url = viewModel.emojis[key],
                               let imageUrl = URL(string: url) {
                                AsyncImage(url: imageUrl) { image in
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            Text(key)
                        }
                    }
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                }
                
            }
            //                .navigationBarBackButtonHidden(false)
            .onAppear {
                viewModel.fetchEmojis()
            }
            .onChange(of: viewModel.emojis) { _ in
                viewModel.salvarEmojisCoreData()
            }
        }
    }
}



#Preview {
    EmojiListView()
}
