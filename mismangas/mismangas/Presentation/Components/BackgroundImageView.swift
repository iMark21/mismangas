//
//  BackgroundImageView.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//


import SwiftUI

struct BackgroundImageView: View {
    let imageUrl: String?
    let height: CGFloat

    var body: some View {
        ZStack(alignment: .bottom) {
            // Background Image or Placeholder
            if let urlString = imageUrl,
               let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
            } else {
                // Placeholder if URL is nil or invalid
                ZStack {
                    Color.gray.opacity(0.3)
                    Image(systemName: "photo.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                }
            }
            
            // Gradient Overlay
            LinearGradient(
                gradient: Gradient(colors: [.clear, .black]),
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .frame(height: height)
        .clipped()
        .background(Color.black)
    }
}

#Preview {
    BackgroundImageView(imageUrl: nil, height: 180)
}
