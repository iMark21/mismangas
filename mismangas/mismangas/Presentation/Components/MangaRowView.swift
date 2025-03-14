//
//  MangaRowView.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import SwiftUI

struct MangaRowView: View {
    let manga: Manga
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background Image with Gradient
            BackgroundImageView(imageUrl: manga.mainPicture,
                                height: 180)
            
            // Title, Author, and Details
            VStack(alignment: .leading) {
                MangaBasicInfoView(title: manga.title,
                                   titleJapanese: nil,
                                   score: manga.score,
                                   volumes: manga.volumes,
                                   mangaID: manga.id)
            }
            .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .primary.opacity(0.3), radius: 6, x: 0, y: 4)
    }
}

// MARK: - Preview

#Preview {
    MangaRowView(manga: .preview)
}
