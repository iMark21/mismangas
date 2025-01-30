//
//  LoginUserViewModel.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import SwiftUI
import SwiftData

@Observable @MainActor
final class LoginUserViewModel {

    // MARK: - ViewState

    enum ViewState: Equatable {
        case idle
        case loading
        case success
        case error(message: String)
    }

    // MARK: - Properties

    var email: String = ""
    var password: String = ""
    var state: ViewState = .idle

    private let loginUserUseCase: LoginUserUseCaseProtocol
    private let collectionManager: MangaCollectionManagerProtocol

    // MARK: - Initializer

    init(loginUserUseCase: LoginUserUseCaseProtocol = LoginUserUseCase(),
         syncManager: MangaCollectionManagerProtocol = MangaCollectionManager()) {
        self.loginUserUseCase = loginUserUseCase
        self.collectionManager = syncManager
    }

    // MARK: - Public Methods

    func login(using context: ModelContextProtocol) async {
        guard validateInputs() else { return }

        state = .loading
        do {
            // Perform login
            try await loginUserUseCase.execute(email: email, password: password)

            // Sync collections after login
            try await collectionManager.syncWithCloud(using: context)

            // Mark login and sync as successful
            state = .success
        } catch {
            state = .error(message: error.localizedDescription)
        }
    }

    // MARK: - Private Methods

    private func validateInputs() -> Bool {
        if !email.isValidEmail {
            state = .error(message: "Invalid email format.")
            return false
        }

        if password.isEmpty {
            state = .error(message: "Password cannot be empty.")
            return false
        }

        return true
    }
}
