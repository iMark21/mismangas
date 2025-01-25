//
//  WelcomeView.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(\.modelContext) private var modelContext
    @State var viewModel = WelcomeViewModel()
    @Binding var isUserAuthenticated: Bool

    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .idle, .unauthenticated:
                    welcomeContent
                case .checking:
                    loadingContent
                case .authenticated:
                    EmptyView()
                }
            }
            .onAppear {
                Task {
                    await viewModel.checkAuthentication(using: modelContext)
                    isUserAuthenticated = viewModel.state == .authenticated
                }
            }
        }
    }

    // MARK: - Welcome Content
    private var welcomeContent: some View {
        VStack(spacing: 32) {
            Spacer()

            AuthHeaderView(emoji: "📖✨",
                           title: "Welcome to Mis Mangas",
                           subtitle: "Your ultimate manga collection manager!")

            VStack(spacing: 16) {
                NavigationLink(destination: RegisterUserView(isUserAuthenticated: $isUserAuthenticated)) {
                    AuthButtonView(title: "Create Account")
                }

                NavigationLink(destination: LoginUserView(isUserAuthenticated: $isUserAuthenticated)) {
                    AuthButtonView(title: "Log In")
                }
            }
            .padding(.horizontal, 24)
            
            Spacer()
        }
        .padding()
    }

    // MARK: - Loading Content
    private var loadingContent: some View {
        VStack {
            Spacer()

            ProgressView("Checking authentication...")
                .progressViewStyle(CircularProgressViewStyle())
                .padding()

            Spacer()
        }
        .padding()
    }
}

// MARK:- Preview

#Preview {
    @Previewable @State var isUserAuthenticated = false
    
    WelcomeView(isUserAuthenticated: $isUserAuthenticated)
}
