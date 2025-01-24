//
//  LoginUserUseCase.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import Foundation

struct LoginUserUseCase: LoginUserUseCaseProtocol {
    var repository: UserRepositoryProtocol = UserRepository()
    var tokenStorage: KeyChainItemManager = KeyChainTokenStorage()

    func execute(email: String, password: String) async throws {
        let token = try await repository.loginUser(email: email, password: password)
        try tokenStorage.save(item: token)
    }
}
