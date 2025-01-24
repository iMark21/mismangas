//
//  RegisterUserUseCase.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import Foundation

struct RegisterUserUseCase: RegisterUserUseCaseProtocol {
    var repository: UserRepositoryProtocol = UserRepository()

    func execute(email: String, password: String) async throws  {
        try await repository.registerUser(email: email, password: password)
    }
}
