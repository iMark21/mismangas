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
    let onSelect: (Manga) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text(title.uppercased())
                .font(.headline)
                .bold()
                .padding(.bottom, 8)

            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(mangas) { manga in
                            MangaCardView(manga: manga)
                                .padding(8)
                                .onTapGesture {
                                    onSelect(manga)
                                }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    HorizontalScrollSection(title: "Section", mangas: Manga.previewData, isLoading: false, onSelect: { _ in })
}
