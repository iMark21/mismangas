//
//  WelcomeViewModel.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import Foundation

@Observable
final class WelcomeViewModel {

    // MARK: - State

    enum State: Equatable {
        case idle
        case checking
        case authenticated
        case unauthenticated
    }

    // MARK: - Properties

    var state: State = .idle
    private let renewTokenUseCase: RenewTokenUseCaseProtocol

    // MARK: - Init

    init(renewTokenUseCase: RenewTokenUseCaseProtocol = RenewTokenUseCase()) {
        self.renewTokenUseCase = renewTokenUseCase
    }

    // MARK: - Methods

    @MainActor
    func checkAuthentication() async {
        state = .checking
        do {
            let isAuthenticated = try await renewTokenUseCase.execute()
            state = isAuthenticated ? .authenticated : .unauthenticated
        } catch {
            Logger.logErrorMessage("Failed to check authentication: \(error.localizedDescription)")
            state = .unauthenticated
        }
    }
}
