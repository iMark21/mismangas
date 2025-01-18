//
//  MangaBasicInfoView.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//


import SwiftUI
import SwiftData

struct MangaBasicInfoView: View {
    let title: String
    let titleJapanese: String?
    let score: Double?
    let volumes: Int?
    let mangaID: Int
    
    // Query
    @Query private var collections: [MangaCollection]

    private var isInCollection: Bool {
        collections.contains { $0.mangaID == mangaID }
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 4) {
                
                HStack {
                    // Favorite Indicator
                    if isInCollection {
                        FavoriteIndicatorView()
                    }
                    // Title
                    Text(title)
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .shadow(radius: 4)
                }
                

                // Title Japanese
                if let titleJapanese, titleJapanese.lowercased() != title.lowercased() {
                    Text(titleJapanese)
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .shadow(radius: 4)
                }

                // Score and Volumes
                VStack(alignment: .leading, spacing: 8) {
                    if let score = score {
                        StarRatingView(score: score)
                    }

                    if let volumes = volumes {
                        VolumesView(volumes: volumes)
                    }
                }
            }
        }
    }
}

#Preview {
    MangaBasicInfoView(title: Manga.preview.title,
                       titleJapanese: Manga.preview.titleJapanese,
                       score: Manga.preview.score,
                       volumes: Manga.preview.volumes,
                       mangaID: Manga.preview.id)
}
