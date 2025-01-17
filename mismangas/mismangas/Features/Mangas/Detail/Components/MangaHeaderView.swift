//
//  MangaHeaderView.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//


import SwiftUI

struct MangaHeaderView: View {
    let manga: Manga
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            BackgroundImageView(imageUrl: manga.mainPicture, height: 300)
            MangaBasicInfoView(title: manga.title,
                               titleJapanese: manga.titleJapanese,
                               score: manga.score,
                               volumes: manga.volumes)
            .padding()
        }
    }
}

// MARK: - Preview

#Preview {
    MangaHeaderView(manga: .preview)
}
