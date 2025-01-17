//
//  MangaTagsView.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//


import SwiftUI

struct MangaTagsView: View {
    let genres: [String]
    let demographics: [String]
    let themes: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TagsView(title: "Genres", tags: genres)
            TagsView(title: "Demographics", tags: demographics)
            TagsView(title: "Themes", tags: themes)
        }
    }
}

// MARK: - Preview

#Preview {
    MangaTagsView(genres: Manga.preview.genres.map { $0.genre },
                  demographics: Manga.preview.demographics.map { $0.demographic },
                  themes: Manga.preview.themes.map { $0.name }
    )
}
