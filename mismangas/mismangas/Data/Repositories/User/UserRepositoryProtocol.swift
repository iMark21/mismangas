//
//  RegisterUserRepositoryProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import Foundation

protocol UserRepositoryProtocol: Sendable {
    func registerUser(email: String, password: String) async throws
    func loginUser(email: String, password: String) async throws -> String
    func renewToken(_ token: String) async throws -> String
}
