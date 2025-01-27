//
//  RegisterUserView.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import SwiftUI

struct RegisterUserView: View {
    
    // MARK: - Properties
    
    @State var viewModel: RegisterUserViewModel = RegisterUserViewModel()
    @Binding var isUserAuthenticated: Bool
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()

                // Header
                AuthHeaderView(emoji: "📚✨",
                               title: "Create Account",
                               subtitle: "Sign up to manage your manga collection!")

                // Form
                AuthCredentialsFormView(email: $viewModel.email,
                                        password: $viewModel.password)

                // Register Button
                AuthActionButton(title: viewModel.state == .loading ? "Registering..." : "Register",
                                  isLoading: (viewModel.state == .loading)) {
                    await viewModel.registerUser()
                    isUserAuthenticated = (viewModel.state == .authenticated)
                }
                .buttonStyle(PlatformButtonStyle())

                // MARK: - Status Message
                if let message = viewModel.stateMessage, viewModel.state != .authenticated {
                    Text(message)
                        .font(.callout)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("")
        }
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var isUserAuthenticated = false
    
    return RegisterUserView(viewModel: .preview,
                            isUserAuthenticated: $isUserAuthenticated)
}
