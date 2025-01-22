//
//  HomeView.swift
//  mismangas
//
//  Created by Michel Marques on 20/1/25.
//

import SwiftUI

struct HomeView: View {
    @State var viewModel = HomeViewModel()
    @State private var selectedFilter: MangaFilter?
    @State private var selectedManga: Manga?
    @State private var isNavigatingToFilter = false
    @State private var isNavigatingToDetail = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    // Highlighted Carousel Section
                    HighlightedCarousel(mangas: viewModel.bestMangas, isLoading: $viewModel.isLoadingMangas, height: iPad ? 600 : 300) { selectedManga in
                        navigateToMangaDetail(selectedManga)
                    }
                    .padding(.bottom)
                    
                    // Themes
                    PillsScrollView(
                        title: "🌐 Explore Themes",
                        items: PillItem.fromThemes(viewModel.themes),
                        isLoading: $viewModel.isLoadingThemes
                    ) { selectedItem in
                        navigateToMangaList(selectedItem, searchType: .theme)
                    }
                    .padding(.vertical)

                    // Horizontal Scroll Section
                    HorizontalScrollSection(
                        title: "🏆 Top 10 Mangas",
                        mangas: viewModel.bestMangas,
                        isLoading: viewModel.isLoadingMangas
                    ) { selectedManga in
                        navigateToMangaDetail(selectedManga)
                    }
                    .padding(.vertical)

                    // Demographics
                    PillsScrollView(
                        title: "👥 Explore Demographics",
                        items: PillItem.fromDemographics(viewModel.demographics),
                        isLoading: $viewModel.isLoadingDemographics
                    ) { selectedItem in
                        navigateToMangaList(selectedItem, searchType: .demographic)
                    }
                    .padding(.vertical)

                    // Genres
                    PillsScrollView(
                        title: "🎭 Explore Genres",
                        items: PillItem.fromGenres(viewModel.genres),
                        isLoading: $viewModel.isLoadingGenres
                    ) { selectedItem in
                        navigateToMangaList(selectedItem, searchType: .genre)
                    }
                    .padding(.vertical)
                }
                .padding()
            }
            
            // Navigation to MangaListView (Filter)
            .navigationDestination(isPresented: $isNavigatingToFilter) {
                if let filter = selectedFilter {
                    if iPad {
                        MangaListPadView(viewModel: MangaListViewModel(initialFilter: filter))
                    } else {
                        MangaListView(viewModel: MangaListViewModel(initialFilter: filter))
                    }
                }
            }
            
            // Navigation to MangaDetailView (Detail)
            .navigationDestination(isPresented: $isNavigatingToDetail) {
                if let manga = selectedManga {
                    if iPad {
                        MangaDetailPadView(viewModel: MangaDetailViewModel(manga: manga))
                    } else {
                        MangaDetailView(viewModel: MangaDetailViewModel(manga: manga))
                    }
                }
            }
        }
    }

    private func navigateToMangaList(_ selectedItem: PillItem, searchType: SearchType) {
        selectedFilter = MangaFilter(id: selectedItem.id, query: selectedItem.title, searchType: searchType)
        isNavigatingToFilter = true
    }
    
    private func navigateToMangaDetail(_ manga: Manga) {
        selectedManga = manga
        isNavigatingToDetail = true
    }
}

// MARK: - Preview

#Preview {
    HomeView(viewModel: .preview)
}
