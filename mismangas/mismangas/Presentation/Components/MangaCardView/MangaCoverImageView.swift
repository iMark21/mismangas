//
//  MangaCoverImageView.swift
//  mismangas
//
//  Created by Michel Marques on 21/1/25.
//


import SwiftUI

struct MangaCoverImageView: View {
    
    // MARK: - Properties

    let imageUrl: String?

    // MARK: - Body

    var body: some View {
        ReusableMangaImageView(imageUrl: imageUrl,
                               width: 140,
                               height: 180,
                               cornerRadius: 12,
                               shadowRadius: 5,
                               contentMode: .fill,
                               placeholderScale: 1.2)
    }
}

// MARK: - Preview

#Preview {
    MangaCoverImageView(imageUrl: Manga.preview.mainPicture)
}
