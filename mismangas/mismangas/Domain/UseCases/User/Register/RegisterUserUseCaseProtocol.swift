//
//  RegisterUserUseCaseProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import Foundation

protocol RegisterUserUseCaseProtocol: Sendable {
    func execute(email: String, password: String) async throws
}
