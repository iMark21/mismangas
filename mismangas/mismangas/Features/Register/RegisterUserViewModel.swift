//
//  RegisterUserViewModel.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import Foundation
import SwiftUI

@Observable
final class RegisterUserViewModel {

    // MARK: - View State
    
    enum ViewState: Equatable {
        case idle
        case loading
        case authenticated
        case registrationFailed(message: String)
        case loginFailed(message: String)
        
        var message: String? {
            switch self {
            case .registrationFailed(let message):
                return message
            case .loginFailed(let message):
                return message
            default:
                return nil
            }
        }
    }

    // MARK: - Public Properties
    
    var email: String = ""
    var password: String = ""
    var state: ViewState = .idle
    
    var stateMessage: String? {
        state.message
    }

    // MARK: - Private Properties
    
    private let registerUserUseCase: RegisterUserUseCaseProtocol
    private let loginUserUseCase: LoginUserUseCaseProtocol

    // MARK: - Initializer
    
    init(registerUserUseCase: RegisterUserUseCaseProtocol = RegisterUserUseCase(),
         loginUserUseCase: LoginUserUseCaseProtocol = LoginUserUseCase()) {
        self.registerUserUseCase = registerUserUseCase
        self.loginUserUseCase = loginUserUseCase
    }

    // MARK: - Public Methods
    
    @MainActor
    func registerUser() async {
        guard validateInputs() else { return }

        state = .loading
        do {
            // Perform Registration
            try await registerUserUseCase.execute(email: email, password: password)
            // Perform Login Automatically
            try await loginUserUseCase.execute(email: email, password: password)
            state = .authenticated
        } catch let error as APIError {
            state = .registrationFailed(message: error.errorDescription ?? "An unexpected error occurred.")
        } catch {
            state = .registrationFailed(message: "Unexpected error occurred during registration.")
        }
    }

    // MARK: - Private Methods

    private func validateInputs() -> Bool {
        guard !email.isEmpty, email.isValidEmail else {
            state = .registrationFailed(message: "Please enter a valid email.")
            return false
        }

        guard password.count >= 8 else {
            state = .registrationFailed(message: "Password must be at least 8 characters.")
            return false
        }

        return true
    }
}
