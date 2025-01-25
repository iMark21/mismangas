//
//  LogoutUserUseCase.swift
//  mismangas
//
//  Created by Michel Marques on 25/1/25.
//

import Foundation

struct LogoutUserUseCase: LogoutUserUseCaseProtocol {
    var tokenStorage: KeyChainItemManager = KeyChainTokenStorage()

    func execute() throws {
        try tokenStorage.delete()
    }
}
