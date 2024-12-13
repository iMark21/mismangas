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
            // MARK: - Background Image with Gradient
            BackgroundImageView(imageUrl: manga.mainPicture, height: 180)
            
            // MARK: - Title and Details
            MangaDetailsView(title: manga.title, score: manga.score, volumes: manga.volumes)
                .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 4)
    }
}

#Preview {
    MangaRowView(manga: .preview)
}
