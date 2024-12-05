//
//  AvatarDetailView.swift
//  Bliss Assessment
//
//  Created by nathalia karine on 05/12/2024.
//

import SwiftUI

struct AvatarDetailView: View {
    @StateObject private var viewModel: AvatarViewModel
    
    init(username: String) {
        _viewModel = StateObject(wrappedValue: AvatarViewModel(username: username))
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            } else if let image = viewModel.avatarImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .padding()
            } else {
                Text("Nenhuma imagem para exibir")
                    .padding()
            }
            
            Spacer()
        }
        .onAppear {
            viewModel.search()
        }
        .navigationTitle(viewModel.username)
    }
}

#Preview {
    AvatarDetailView(username: "" )
}
