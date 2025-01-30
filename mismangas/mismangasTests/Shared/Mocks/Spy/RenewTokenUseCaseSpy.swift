//
//  RenewTokenUseCaseSpy.swift
//  mismangasTests
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
@testable import mismangas

final class RenewTokenUseCaseSpy: RenewTokenUseCaseProtocol {
    
    var mockResult: Bool?
    var mockError: Error?
    
    // MARK: - Mock Setter
    
    func setMockResult(_ result: Bool?) {
        mockResult = result
    }
    
    func setMockError(_ error: Error?) {
        mockError = error
    }
    
    // MARK: - Protocol Method
    
    func execute() async throws -> Bool {
        if let error = mockError {
            throw error
        }
        if let result = mockResult {
            return result
        }
        return false
    }
}