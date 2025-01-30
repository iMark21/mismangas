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
        ReusableMangaImageView(imageUrl: imageUrl,
                               width: nil,
                               height: nil,
                               cornerRadius: cornerRadius,
                               shadowRadius: shadowRadius,
                               contentMode: .fit,
                               placeholderScale: 1.0)
    }
}

// MARK: - Preview

#Preview {
    MangaImageDetailPadView(imageUrl: Manga.preview.mainPicture!,
                            cornerRadius: 12,
                            shadowRadius: 10)
}
