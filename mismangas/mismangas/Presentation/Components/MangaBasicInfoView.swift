//
//  MangaDetailsView.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//


import SwiftUI

struct MangaBasicInfoView: View {
    let title: String
    let titleJapanese: String?
    let score: Double?
    let volumes: Int?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            // Title
            Text(title)
                .font(.title2.bold())
                .foregroundColor(.white)
                .lineLimit(1)
                .shadow(radius: 2)
            
            
            // Title Japanese
            if let titleJapanese, titleJapanese.lowercased() != title.lowercased() {
                Text(titleJapanese)
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .shadow(radius: 2)
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

#Preview {
    MangaBasicInfoView(title: Manga.preview.title,
                       titleJapanese: Manga.preview.titleJapanese,
                       score: Manga.preview.score,
                       volumes: Manga.preview.volumes)
}
