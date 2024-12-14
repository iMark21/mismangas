//
//  BackgroundImageView.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//


import SwiftUI

struct BackgroundImageView: View {
    let imageUrl: String
    let height: CGFloat

    var body: some View {
        ZStack(alignment: .bottom) {
            // Background Image
            AsyncImage(url: URL(string: imageUrl.replacingOccurrences(of: "\"", with: ""))) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(height: height)
            .clipped()
            .overlay(content: {
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            })
        }
        .frame(height: height)
        .clipped()
        .background(Color.black)
    }
}

#Preview {
    BackgroundImageView(imageUrl: Manga.preview.mainPicture, height: 180)
}
