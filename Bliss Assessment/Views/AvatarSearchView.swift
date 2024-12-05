////
////  AvatarSearchView.swift
////  Bliss Assessment
////
////  Created by nathalia karine on 05/12/2024.
////
//
//import SwiftUI
//
//struct AvatarSearchView: View {
//    @StateObject private var viewModel = AvatarViewModel(username: "")
//    @State private var username: String = ""
//    
//    var body: some View {
//        VStack {
//            TextField("Digite o nome de usuário do GitHub", text: $viewModel.username)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            
//            Button("Search") {
//                viewModel.search()
//            }
//            .padding()
//            
//            if viewModel.isLoading {
//                ProgressView()
//                    .padding()
//            } else if let image = viewModel.avatarImage {
//                Image(uiImage: image)
//                    .resizable()
//                    .frame(width: 100, height: 100)
//                    .clipShape(Circle())
//                    .padding()
//            } else {
//                Text("Nenhuma imagem para exibir")
//                    .padding()
//            }
//            
//            Spacer()
//        }
//    }
//}
//
//
//
//#Preview {
//    AvatarSearchView()
//}
