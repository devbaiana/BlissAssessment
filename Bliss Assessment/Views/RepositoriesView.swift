//
//  RepositoriesView.swift
//  Bliss Assessment
//
//  Created by nathalia karine on 03/12/2024.
//

import SwiftUI

struct RepositoriesView: View {
    @StateObject private var viewModel = ReposViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading && viewModel.repositories.isEmpty {
                ProgressView("Loading...")
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 15) {
                        ForEach(viewModel.repositories) { repository in
                            VStack(alignment: .leading) {
                                Text(repository.name)
                            }
                            .foregroundColor(.white)
                            .padding()
                        }

                        if viewModel.isLoading {
                            ProgressView("Loading...")
                        } else {
                            Color.clear
                                .frame(height: 1)
                                .onAppear {
                                    viewModel.fetchRepositories()
                                }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Apple Repositories")
        .background(Color("Cinza-bliss"))
        .onAppear {
            if viewModel.repositories.isEmpty {
                viewModel.fetchRepositories()
            }
        }
        .alert(isPresented: Binding<Bool>(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.errorMessage = nil }
        )) {
            Alert(
                title: Text("Erro"),
                message: Text(viewModel.errorMessage ?? ""),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    RepositoriesView()
}
