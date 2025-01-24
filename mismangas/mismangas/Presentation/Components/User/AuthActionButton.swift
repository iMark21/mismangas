//
//  AuthButton.swift
//  mismangas
//
//  Created by Michel Marques on 24/1/25.
//

import SwiftUI

struct AuthActionButton: View {
    let title: String
    let isLoading: Bool
    let action: (() async -> Void)?

    var body: some View {
        Button {
            if let action = action {
                Task {
                    await action()
                }
            }
        } label: {
            if isLoading {
                HStack {
                    ProgressView()
                    Text(title)
                }
                .frame(maxWidth: .infinity)
            } else {
                Text(title)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(isLoading ? Color.gray : Color.accentColor)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}

// MARK: - Preview

#Preview {
    AuthActionButton(title: "Log In", isLoading: false, action: {})
}
