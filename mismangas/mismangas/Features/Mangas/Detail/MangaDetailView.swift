//
//  MangaDetailView.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//

import SwiftUI
import SwiftData

struct MangaDetailView: View {
    @State var viewModel: MangaDetailViewModel
    @Query private var collections: [MangaCollection]
    @Environment(\.modelContext) private var modelContext

    // MARK: - Computed Properties
    
    private var collection: MangaCollection? {
        guard case .content(let manga) = viewModel.state else { return nil }
        return collections.first(where: { $0.mangaID == manga.id })
    }

    private var collectionManager: MangaCollectionManager {
        MangaCollectionManager(modelContext: modelContext)
    }

    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 0) {
            switch viewModel.state {
            case .loading:
                ProgressMeView(message: "Loading ...")

            case .content(let manga):
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        MangaHeaderView(manga: manga)
                        MangaTagsView(
                            genres: manga.genres.map { $0.genre },
                            demographics: manga.demographics.map { $0.demographic },
                            themes: manga.themes.map { $0.name }
                        )
                        .padding(.horizontal)
                        MangaSynopsisView(synopsis: manga.synopsis)
                            .padding()
                    }
                }
                MangaDetailBottomBar(isInCollection: collection != nil,
                                     toggleCollection: toggleCollection,
                                     showManagement: {
                    viewModel.showingCollectionManagement = true
                })
                
            case .error(let message):
                ErrorView(message: message) {
                    if let mangaID = viewModel.mangaID {
                        viewModel.fetchMangaDetails(for: mangaID)
                    }
                }
            }
        }
        .navigationTitle("Manga Details")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $viewModel.showingCollectionManagement) {
            if case .content(let manga) = viewModel.state {
                MyCollectionManagementSection(completeCollection: $viewModel.completeCollection,
                                            volumesOwned: $viewModel.volumesOwned,
                                            readingVolume: $viewModel.readingVolume,
                                            totalVolumes: manga.volumes,
                                            manga: manga)
                .presentationDetents([.height(200), .medium])
                .presentationDragIndicator(.visible)
            }
        }
    }

    // MARK: - Actions
    
    private func toggleCollection() {
        guard case .content(let manga) = viewModel.state else { return }

        if collection != nil {
            collectionManager.removeFromCollection(mangaID: manga.id)
            viewModel.reset()
        } else {
            collectionManager.saveToMyCollection(manga: manga,
                                                 completeCollection: viewModel.completeCollection,
                                                 volumesOwned: viewModel.volumesOwned,
                                                 readingVolume: viewModel.readingVolume)
        }
    }
}

// MARK: - Preview

#Preview {
    MangaDetailView(viewModel: .preview)
}
