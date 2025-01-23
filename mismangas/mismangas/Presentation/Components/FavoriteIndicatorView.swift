//
//  FavoriteIndicatorView.swift
//  mismangas
//
//  Created by Michel Marques on 18/1/25.
//


import SwiftUI

struct FavoriteIndicatorView: View {
    enum Size {
        case small, medium, big

        var dimensions: CGFloat {
            switch self {
            case .small: return 20
            case .medium: return 30
            case .big: return 50
            }
        }
    }

    var size: Size = .medium
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.pink)
                .frame(width: size.dimensions, height: size.dimensions)
            Image(systemName: "heart.fill")
                .foregroundColor(.white)
                .font(.system(size: size.dimensions / 2))
        }
        .shadow(radius: 5)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 20) {
        FavoriteIndicatorView(size: .small)
        FavoriteIndicatorView(size: .medium)
        FavoriteIndicatorView(size: .big)
    }
    .padding()
}
