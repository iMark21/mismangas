//
//  MangaCardView.swift
//  mismangas
//
//  Created by Michel Marques on 20/1/25.
//

import SwiftUI

struct MangaCardView: View {
    let manga: Manga
    
    // MARK: - Body

    var body: some View {
        VStack {
            // Manga cover image
            MangaCoverImageView(imageUrl: manga.mainPicture)

            // Manga title and rating
            VStack(alignment: .leading, spacing: 4) {
                Text(manga.title)
                    .font(.headline)
                    .bold()
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)

                StarRatingView(score: manga.score ?? 0.0)
            }
            .padding(8)
        }
        .frame(width: 140)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.secondarySystemBackground))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
    }
}

// MARK: - Preview

#Preview {
    MangaCardView(manga: .preview)
}
