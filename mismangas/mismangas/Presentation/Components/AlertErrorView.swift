//
//  ErrorView.swift
//  mismangas
//
//  Created by Michel Marques on 17/12/24.
//

import SwiftUI

struct AlertErrorView<Content: View>: View {
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
                primaryButton: .default(Text("Retry"), action: {
                    retryAction()
                }), secondaryButton: .cancel({})
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
    AlertErrorView(
        message: "Something went wrong",
        retryAction: { Logger.log("Retry pressed") }
    ) {
        Text("Fallback Content Here")
    }
}
