//
//  ContentView.swift
//  mismangas
//
//  Created by Michel Marques on 10/12/24.
//

import SwiftUI

struct MangaListView: View {
    @State var viewModel: MangaListViewModel

    var body: some View {
        NavigationView {
            List(viewModel.mangas) { manga in
                HStack {
                    // Imagen principal
                    AsyncImage(url: URL(string: manga.mainPicture.replacingOccurrences(of: "\"", with: ""))) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                    } placeholder: {
                        ProgressView()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                    // Título y Puntaje
                    VStack(alignment: .leading) {
                        Text(manga.title)
                            .font(.headline)
                        if let score = manga.score {
                            Text("Score: \(score, specifier: "%.2f")")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Mangas")
            .onAppear {
                viewModel.fetchMangas()
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage ?? "Unknown Error")
            }
        }
    }
}

#Preview {
    MangaListView(viewModel: .preview)
}
