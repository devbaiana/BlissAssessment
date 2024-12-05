//
//  AvatarListView.swift
//  Bliss Assessment
//
//  Created by nathalia karine on 03/12/2024.
//

import SwiftUI

struct AvatarListView: View {
    @StateObject private var viewModel = AvatarViewModel(username: "")
    @State private var avatars: [UserAvatar] = []

    var body: some View {
        ScrollView {
//            ZStack
            LazyVStack(spacing: 20) {
                ForEach(avatars, id: \.self) { avatar in
                    HStack {
                        if let imageData = avatar.imageData, let image = UIImage(data: imageData) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        }
                        Text(avatar.username ?? "Unknown User")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: {
                            deleteAvatar(avatar)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        .padding(.leading, 10)
                    }
                    .padding()
                }
            }
        }.background(Color("Cinza-bliss"))
        .onAppear {
            avatars = viewModel.fetchAllAvatars()
        }
    }
    private func deleteAvatar(_ avatar: UserAvatar) {
            viewModel.deleteAvatar(avatar)
            avatars = viewModel.fetchAllAvatars() 
        }
}


#Preview {
    AvatarListView()
}
