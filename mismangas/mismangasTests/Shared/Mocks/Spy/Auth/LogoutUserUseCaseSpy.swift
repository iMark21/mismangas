//
//  LogoutUserUseCaseSpy.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//


import Foundation
@testable import mismangas

actor LogoutUserUseCaseSpy: LogoutUserUseCaseProtocol {
    
    var mockLogoutError: APIError?
    
    // MARK: - Mock Setter
    
    func setMockLogoutError(_ error: APIError?) {
        mockLogoutError = error
    }
    
    // MARK: - Protocol Method
    
    func execute() async throws {
        if let error = mockLogoutError {
            throw error
        }
    }
}
