//
//  AuthButtonView.swift
//  mismangas
//
//  Created by Michel Marques on 24/1/25.
//


import SwiftUI

struct AuthButtonView: View {
    var title: String
    var backgroundColor: Color = .accentColor

    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

// MARK: - Preview
#Preview {
    
    AuthButtonView(title: "Log In")
}
