//
//  MangaImageDetailPadView.swift
//  mismangas
//
//  Created by Michel Marques on 19/1/25.
//

import SwiftUI

struct MangaImageDetailPadView: View {
    // MARK: - Properties

    let imageUrl: String?
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat

    // MARK: - Body

    var body: some View {
        AsyncImage(url: URL(string: imageUrl ?? "")) { image in
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(cornerRadius)
        } placeholder: {
            ProgressView()
        }
        .shadow(radius: shadowRadius)
    }
}

// MARK: - Preview

#Preview {
    MangaImageDetailPadView(imageUrl: Manga.preview.mainPicture!,
                            cornerRadius: 12,
                            shadowRadius: 10)
}
