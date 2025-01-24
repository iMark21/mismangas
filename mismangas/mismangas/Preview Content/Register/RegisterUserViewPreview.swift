//
//  RegisterUserViewPreview.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import Foundation

extension RegisterUserViewModel {
    static var preview: RegisterUserViewModel {
        .init(registerUserUseCase: MockRegisterUseCase())
    }
}


// MARK: - Mock UseCase

final class MockRegisterUseCase: RegisterUserUseCaseProtocol {
    func execute(email: String, password: String) async throws {
        return
    }
}
