//
//  HighlightedCarousel.swift
//  mismangas
//
//  Created by Michel Marques on 21/1/25.
//


import SwiftUI

struct HighlightedCarousel: View {
    let mangas: [Manga]
    @Binding var isLoading: Bool
    let onSelect: (Manga) -> Void

    var body: some View {
        AutomaticMangaCarousel(mangas: mangas, isLoading: isLoading, onSelect: onSelect)
    }
}

// MARK: - Preview


#Preview {
    HighlightedCarousel(mangas: Manga.previewData,
                        isLoading: .constant(false),
                        onSelect: { _ in })
}
