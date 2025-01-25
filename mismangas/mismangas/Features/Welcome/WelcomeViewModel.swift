//
//  WelcomeViewModel.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import Foundation
import SwiftData

@Observable @MainActor
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
    private let collectionManager: MangaCollectionManagerProtocol

    // MARK: - Init

    init(renewTokenUseCase: RenewTokenUseCaseProtocol = RenewTokenUseCase(),
         collectionManager: MangaCollectionManagerProtocol = MangaCollectionManager()) {
        self.renewTokenUseCase = renewTokenUseCase
        self.collectionManager = collectionManager
    }

    // MARK: - Methods

    func checkAuthentication(using context: ModelContext) async {
        state = .checking
        do {
            // Try to renew the token
            let isAuthenticated = try await renewTokenUseCase.execute()
            if isAuthenticated {
                // Sync collections if authenticated
                try await collectionManager.syncWithCloud(using: context)
                state = .authenticated
            } else {
                state = .unauthenticated
            }
        } catch {
            Logger.logErrorMessage("Failed to check authentication: \(error.localizedDescription)")
            state = .unauthenticated
        }
    }
}
