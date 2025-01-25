//
//  UserRepository.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import Foundation

struct UserRepository: UserRepositoryProtocol {
    
    let client: APIClient = MisMangasAPIClient()
    
    // MARK: - Register User
    
    func registerUser(email: String, password: String) async throws {
        let url: URL = .registerUser
        let body = UserCredentialsRequest(email: email, password: password)

        try await client.perform(.post(url: url, body: body)) as Void
    }

    // MARK: - Login User
    
    func loginUser(email: String, password: String) async throws -> String {
        let url: URL = .loginUser

        let body = UserCredentialsRequest(email: email, password: password)
        let credentials = "\(email):\(password)"
        
        guard let encodedCredentials = credentials.data(using: .utf8)?.base64EncodedString() else {
            throw APIError.custom(message: "Failed to encode credentials.")
        }

        let request: URLRequest = .post(
            url: url,
            body: body,
            headers: ["Authorization": "Basic \(encodedCredentials)"]
        )

        let response: String = try await client.perform(request)
        return response
    }
    
    // MARK: - Renew Token
    
    func renewToken(_ token: String) async throws -> String {
        let url: URL = .renewToken
        let request: URLRequest = .post(
            url: url,
            headers: [
                "Authorization": "Bearer \(token)"
            ]
        )

        let response: String = try await client.perform(request)
        return response
    }
}
