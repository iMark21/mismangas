//
//  MangaCardView.swift
//  mismangas
//
//  Created by Michel Marques on 20/1/25.
//

import SwiftUI
import SwiftData

struct MangaCardView: View {
    let manga: Manga
    
    // Query
    @Query private var collections: [MangaCollectionDB]
    
    private var isInCollection: Bool {
        collections.contains { $0.mangaID == manga.id }
    }
    
    // MARK: - Body

    var body: some View {
        VStack {
            // Manga cover image
            MangaCoverImageView(imageUrl: manga.mainPicture)

            // Manga in collection, title and rating
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    
                    if isInCollection {
                        FavoriteIndicatorView(size: .small)
                    }

                    Text(manga.title)
                        .font(.headline)
                        .bold()
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.primary)
                }
                
                StarRatingView(score: manga.score ?? 0.0)
            }
            .padding(8)
        }
        .frame(width: 140)
        #if os(iOS)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        #endif
    }
}

// MARK: - Preview

#Preview {
    MangaCardView(manga: .preview)
}
