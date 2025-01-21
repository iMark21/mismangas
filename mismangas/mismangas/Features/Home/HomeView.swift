//
//  HomeView.swift
//  mismangas
//
//  Created by Michel Marques on 20/1/25.
//


import SwiftUI

struct HomeView: View {
    @State var viewModel = HomeViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Carrusel Principal
                HighlightedCarousel(mangas: viewModel.bestMangas,
                                    isLoading: viewModel.isLoadingBestMangas)
                    .frame(height: 300)
                    .padding(.top)
                
                // Best Mangas
                HorizontalScrollSection(
                    title: "🌟 Best Mangas",
                    mangas: viewModel.bestMangas,
                    isLoading: viewModel.isLoadingBestMangas
                )

                
                // Last added
                HorizontalScrollSection(
                    title: "🕒 Latest Additions",
                    mangas: viewModel.latestMangas,
                    isLoading: viewModel.isLoadingLatestMangas
                )

                
                // Genres section
                HorizontalScrollSection(
                    title: "🎨 Explore Genres",
                    mangas: viewModel.genres,
                    isLoading: viewModel.isLoadingGenres
                )

            }
            .padding()
        }
        .onAppear {
            viewModel.fetchData()
        }
        .navigationTitle("Home")
    }
}


// MARK: - Preview

#Preview {
    HomeView(viewModel: .preview)
}
