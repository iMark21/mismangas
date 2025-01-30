//
//  MockUserRepository.swift
//  mismangasTests
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
@testable import mismangas

actor MockUserRepository: UserRepositoryProtocol {
    
    var mockLoginUserResult: User?
    var mockLoginUserError: APIError?
    var mockRegisterUserResult: Void?
    var mockRegisterUserError: APIError?
    var mockRenewTokenResult: User?
    var mockRenewTokenError: APIError?
    
    // MARK: - Mock Setters
    
    func setMockLoginUserResult(_ result: User?) {
        mockLoginUserResult = result
    }
    
    func setMockLoginUserError(_ error: APIError?) {
        mockLoginUserError = error
    }
    
    func setMockRegisterUserResult(_ result: Void?) {
        mockRegisterUserResult = result
    }
    
    func setMockRegisterUserError(_ error: APIError?) {
        mockRegisterUserError = error
    }
    
    func setMockRenewTokenResult(_ result: User?) {
        mockRenewTokenResult = result
    }
    
    func setMockRenewTokenError(_ error: APIError?) {
        mockRenewTokenError = error
    }
    
    // MARK: - Protocol Methods
    
    func registerUser(email: String, password: String) async throws {
        if let error = mockRegisterUserError {
            throw error
        }
        if let result = mockRegisterUserResult {
            return result
        }
    }
    
    func loginUser(email: String, password: String) async throws -> User {
        if let error = mockLoginUserError {
            throw error
        }
        guard let result = mockLoginUserResult else {
            throw APIError.custom(message: "User not found")
        }
        return result
    }
    
    func renewToken(_ token: String) async throws -> User {
        if let error = mockRenewTokenError {
            throw error
        }
        guard let result = mockRenewTokenResult else {
            throw APIError.custom(message: "Token renewal failed")
        }
        return result
    }
}
