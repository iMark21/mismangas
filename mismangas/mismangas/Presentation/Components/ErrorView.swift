//
//  ErrorView.swift
//  mismangas
//
//  Created by Michel Marques on 17/12/24.
//

import SwiftUI

struct ErrorView<Content: View>: View {
    let message: String
    let retryAction: () -> Void
    let fallbackContent: () -> Content
    
    init(
        message: String,
        retryAction: @escaping () -> Void,
        @ViewBuilder fallbackContent: @escaping () -> Content
    ) {
        self.message = message
        self.retryAction = retryAction
        self.fallbackContent = fallbackContent
    }
    
    var body: some View {
        VStack {
            if isFallbackContentEmpty() {
                VStack(spacing: 12) {
                    Text(message)
                        .multilineTextAlignment(.center)
                    Button("Retry") {
                        retryAction()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                fallbackContent()
            }
        }
        .alert(isPresented: .constant(true)) {
            Alert(
                title: Text("Error"),
                message: Text(message),
                dismissButton: .default(Text("OK")) {
                    retryAction()
                }
            )
        }
    }
    
    private func isFallbackContentEmpty() -> Bool {
        // Logic to check if fallbackContent is empty can be customized
        false
    }
}

// MARK: - Preview

#Preview {
    ErrorView(
        message: "Something went wrong",
        retryAction: { print("Retry pressed") }
    ) {
        Text("Fallback Content Here")
    }
}
