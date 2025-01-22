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
    var height: CGFloat
    let onSelect: (Manga) -> Void


    var body: some View {
        AutomaticMangaCarousel(mangas: mangas,
                               isLoading: isLoading,
                               height: height,
                               onSelect: onSelect)
            .frame(height: height)
    }
}

// MARK: - Preview


#Preview {
    HighlightedCarousel(mangas: Manga.previewData,
                        isLoading: .constant(false),
                        height: 300,
                        onSelect: { _ in })
}
