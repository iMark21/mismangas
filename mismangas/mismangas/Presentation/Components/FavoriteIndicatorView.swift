//
//  FavoriteIndicatorView.swift
//  mismangas
//
//  Created by Michel Marques on 18/1/25.
//


import SwiftUI

struct FavoriteIndicatorView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.pink)
                .frame(width: 30, height: 30)
            Image(systemName: "heart.fill")
                .foregroundColor(.white)
                .font(.title3)
        }
        .shadow(radius: 5)
    }
}

// MARK: - Preview

#Preview {
    FavoriteIndicatorView()
}
