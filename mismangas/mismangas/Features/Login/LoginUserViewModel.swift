//
//  LoginUserViewModel.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import SwiftUI

@Observable
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

    // MARK: - Initializer

    init(loginUserUseCase: LoginUserUseCaseProtocol = LoginUserUseCase()) {
        self.loginUserUseCase = loginUserUseCase
    }

    // MARK: - Public Methods

    @MainActor
    func login() async {
        guard validateInputs() else { return }

        state = .loading
        do {
            try await loginUserUseCase.execute(email: email, password: password)
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
