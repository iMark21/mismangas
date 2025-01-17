//
//  MangaDetailView.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//

import SwiftUI

struct MangaDetailView: View {
    let manga: Manga
    @State private var isInCollection = false
    @State private var volumesOwned: [Int] = []
    @State private var readingVolume: Int? = nil
    @State private var completeCollection = false
    @State private var showingCollectionManagement = false

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // HEADER
                    MangaHeaderView(manga: manga)
                    
                    // TAGS
                    MangaTagsView(
                        genres: manga.genres.map { $0.genre },
                        demographics: manga.demographics.map { $0.demographic },
                        themes: manga.themes.map { $0.name }
                    )
                    .padding(.horizontal)

                    // SYNOPSIS
                    MangaSynopsisView(synopsis: manga.synopsis)
                        .padding()
                }
            }

            // MANAGEMENT
            MangaDetailBottomBar(
                isInCollection: $isInCollection,
                toggleCollection: toggleCollection,
                showManagement: { showingCollectionManagement = true }
            )
        }
        .navigationTitle("Manga Details")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingCollectionManagement) {
            CollectionManagementSection(
                completeCollection: $completeCollection,
                volumesOwned: $volumesOwned,
                readingVolume: $readingVolume,
                totalVolumes: manga.volumes
            )
            .presentationDetents([.height(200), .medium])
            .presentationDragIndicator(.visible)
        }
    }

    private func toggleCollection() {
        isInCollection.toggle()
        if !isInCollection {
            volumesOwned = []
            readingVolume = nil
            completeCollection = false
        }
    }
}

// MARK: - Preview

#Preview {
    MangaDetailView(manga: .preview)
}
