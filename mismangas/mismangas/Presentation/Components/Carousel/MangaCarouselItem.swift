//
//  MangaCarouselItem.swift
//  mismangas
//
//  Created by Michel Marques on 21/1/25.
//

import SwiftUI

struct MangaCarouselItem: View {
    let manga: Manga
    var height: CGFloat

    var body: some View {
        ZStack(alignment: .top) {
            // Manga image
            AsyncImage(url: URL(string: manga.mainPicture ?? "")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: height)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                default:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: height)
                        .foregroundColor(.gray)
                }
            }


            // Manga information
            MangaBasicInfoView(title: manga.title,
                               titleJapanese: manga.titleJapanese,
                               score: manga.score,
                               volumes: manga.volumes,
                               mangaID: manga.id)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.black, Color.clear]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(
                RoundedCornerShape(radius: 20, corners: [.topLeft, .topRight])
            )
        }
        .cornerRadius(20)
    }
}

// MARK: - Preview

#Preview {
    MangaCarouselItem(manga: .preview, height: 300)
}
