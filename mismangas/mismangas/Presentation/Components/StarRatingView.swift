//
//  StarRatingView.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//


import SwiftUI

struct StarRatingView: View {
    let score: Double
    let maxStars: Int = 5

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<maxStars, id: \.self) { index in
                Image(systemName: starType(for: index))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                    .foregroundColor(.yellow)
            }
        }
    }

    private func starType(for index: Int) -> String {
        let starValue = score / 10 * Double(maxStars) // Convert to a 5-star scale
        if Double(index) + 0.5 <= starValue {
            return "star.fill" // Fully filled star
        } else if Double(index) < starValue {
            return "star.leadinghalf.filled" // Half-filled star
        } else {
            return "star" // Empty star
        }
    }
}