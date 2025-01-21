//
//  HorizontalScrollSection.swift
//  mismangas
//
//  Created by Michel Marques on 20/1/25.
//

import SwiftUI

struct HorizontalScrollSection: View {
    let title: String
    let mangas: [Manga]
    let isLoading: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .bold()
                .padding(.horizontal)

            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 16) {
                        ForEach(mangas) { manga in
                            MangaCardView(manga: manga)
                                .padding(.vertical)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    HorizontalScrollSection(title: "Section", mangas: Manga.previewData, isLoading: false)
}
