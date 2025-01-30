//
//  ReusableMangaImageView.swift
//  mismangas
//
//  Created by Michel Marques on 21/1/25.
//


import SwiftUI

struct ReusableMangaImageView: View {
    let imageUrl: String?
    let width: CGFloat?
    let height: CGFloat?
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    let contentMode: ContentMode
    let placeholderScale: CGFloat

    var body: some View {
        AsyncImage(url: URL(string: imageUrl ?? "")) { phase in
            Group {
                switch phase {
                case .empty:
                    ProgressView()
                        .scaleEffect(placeholderScale)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.secondary)
                        .background(Color.gray.opacity(0.3))
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: width, height: height)
            .clipped()
            .cornerRadius(cornerRadius)
            .shadow(radius: shadowRadius)
        }
    }
}

// MARK: - Preview

#Preview {
    ReusableMangaImageView(imageUrl: Manga.preview.mainPicture,
                           width: 140,
                           height: 180,
                           cornerRadius: 12,
                           shadowRadius: 5,
                           contentMode: .fill,
                           placeholderScale: 1.2)
}
