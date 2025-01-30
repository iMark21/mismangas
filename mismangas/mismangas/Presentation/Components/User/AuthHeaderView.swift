//
//  AuthHeaderView.swift
//  mismangas
//
//  Created by Michel Marques on 24/1/25.
//


import SwiftUI

struct AuthHeaderView: View {
    let emoji: String
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(emoji)
                .font(.system(size: currentDeviceType == .iPad ? 180 : 90))
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - Preview

#Preview {
    AuthHeaderView(emoji: "📚✨",
                         title: "Create Account",
                         subtitle: "Sign up to manage your manga collection!")
}
