//
//  MangaDetailPadView.swift
//  mismangas
//
//  Created by Michel Marques on 18/1/25.
//

import SwiftUI
import SwiftData

struct MangaDetailPadView: View {
    // MARK: - Properties
    
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
                GeometryReader { geometry in
                    HStack {
                        leftColumn(for: manga, geometry: geometry)
                        rightColumn(for: manga, geometry: geometry)
                    }
                }
                .padding()

            case .error(let message):
                ErrorView(message: message) {
                    if let mangaID = viewModel.mangaID {
                        viewModel.fetchMangaDetails(for: mangaID)
                    }
                }
            }
        }
        .padding()
        .navigationBarHidden(true)
    }

    // MARK: - Columns
    
    private func leftColumn(for manga: Manga, geometry: GeometryProxy) -> some View {
        VStack {
            MangaImageDetailPadView(imageUrl: manga.mainPicture, cornerRadius: 12, shadowRadius: 10)
                .padding()

            MangaDetailBottomBar(
                isInCollection: collection != nil,
                toggleCollection: toggleCollection,
                showManagement: nil,
                showManageButton: false
            )

            MyCollectionManagementSection(
                completeCollection: $viewModel.completeCollection,
                volumesOwned: $viewModel.volumesOwned,
                readingVolume: $viewModel.readingVolume,
                totalVolumes: manga.volumes,
                manga: manga
            )
        }
        .frame(width: geometry.size.width * 0.33)
    }

    private func rightColumn(for manga: Manga, geometry: GeometryProxy) -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(manga.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                MangaTagsView(
                    genres: manga.genres.map { $0.genre },
                    demographics: manga.demographics.map { $0.demographic },
                    themes: manga.themes.map { $0.name }
                )
                .padding(.horizontal)

                MangaSynopsisView(synopsis: manga.synopsis)
                    .padding(.horizontal)
            }
        }
        .frame(width: geometry.size.width * 0.67)
    }

    // MARK: - Actions
    
    private func toggleCollection() {
        guard case .content(let manga) = viewModel.state else { return }

        if collection != nil {
            collectionManager.removeFromCollection(mangaID: manga.id)
            viewModel.reset()
        } else {
            collectionManager.saveToMyCollection(
                manga: manga,
                completeCollection: viewModel.completeCollection,
                volumesOwned: viewModel.volumesOwned,
                readingVolume: viewModel.readingVolume
            )
        }
    }
}

// MARK: - Preview

#Preview {
    MangaDetailPadView(viewModel: .preview)
}
