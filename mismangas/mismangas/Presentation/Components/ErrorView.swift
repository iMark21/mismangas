//
//  ErrorMessageView.swift
//  mismangas
//
//  Created by Michel Marques on 12/1/25.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    var onRetry: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text(message)
                .foregroundColor(.red)
            Button("Retry", action: onRetry)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

// MARK: - Preview

#Preview {
    ErrorView(message: "An unexpected error occurred") {
        Logger.log("Retry tapped")
    }
}
