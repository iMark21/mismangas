//
//  LoginUserUseCaseSpy.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
@testable import mismangas

actor LoginUserUseCaseSpy: LoginUserUseCaseProtocol {
    
    var mockResult: Void?
    var mockError: APIError?
    
    // MARK: - Mock Setter
    
    func setMockResult(_ result: Void?) {
        mockResult = result
    }
    
    func setMockError(_ error: APIError?) {
        mockError = error
    }
    
    // MARK: - Protocol Method
    
    func execute(email: String, password: String) async throws {
        if let error = mockError {
            throw error
        }
        if let result = mockResult {
            return result
        }
    }
}
