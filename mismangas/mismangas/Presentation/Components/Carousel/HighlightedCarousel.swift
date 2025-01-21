//
//  HighlightedCarousel.swift
//  mismangas
//
//  Created by Michel Marques on 21/1/25.
//


import SwiftUI

struct HighlightedCarousel: View {
    let mangas: [Manga]
    let isLoading: Bool

    var body: some View {
        AutomaticMangaCarousel(mangas: mangas, isLoading: isLoading)
    }
}

// MARK: - Preview

#Preview {
    HighlightedCarousel(mangas: Manga.previewData, isLoading: true)
    HighlightedCarousel(mangas: Manga.previewData, isLoading: false)
}
