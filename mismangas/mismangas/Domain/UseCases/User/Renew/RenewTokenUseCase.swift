//
//  RenewTokenUseCase.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import Foundation

struct RenewTokenUseCase: RenewTokenUseCaseProtocol {
    private let repository: UserRepositoryProtocol
    private let tokenStorage: KeyChainItemManager

    init(repository: UserRepositoryProtocol = UserRepository(),
         tokenStorage: KeyChainItemManager = KeyChainTokenStorage()) {
        self.repository = repository
        self.tokenStorage = tokenStorage
    }

    func execute() async throws -> Bool {
        guard let currentToken = try? tokenStorage.load() else {
            throw APIError.custom(message: "No token available")
        }

        do {
            let newToken = try await repository.renewToken(currentToken)
            try tokenStorage.save(item: newToken)
            return true
        } catch {
            Logger.logErrorMessage("Failed to renew token: \(error.localizedDescription)")
            return false
        }
    }
}
