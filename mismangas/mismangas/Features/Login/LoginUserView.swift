//
//  LoginUserView.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import SwiftUI

struct LoginUserView: View {
    @Environment(\.modelContext) private var modelContext
    @State var viewModel = LoginUserViewModel()
    @Binding var isUserAuthenticated: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Spacer()
                
                // Header
                
                AuthHeaderView(emoji: "👋",
                               title: "Welcome Back!",
                               subtitle: "Log in to access your manga collection.")

                // Form
                
                AuthCredentialsFormView(email: $viewModel.email,
                                        password: $viewModel.password)

                // Login Button
                
                AuthActionButton(title: viewModel.state == .loading ? "Logging in..." : "Log In",
                                  isLoading: (viewModel.state == .loading)) {
                    await viewModel.login(using: modelContext)
                    isUserAuthenticated = (viewModel.state == .success)
                }
                .buttonStyle(PlatformButtonStyle())
                .padding(.horizontal, 24)

                // Message
                
                if case let .error(message) = viewModel.state {
                    Text(message)
                        .font(.callout)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var isUserAuthenticated = false
    return LoginUserView(isUserAuthenticated: $isUserAuthenticated)
}
