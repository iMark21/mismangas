//
//  MockAuthorRepository.swift
//  mismangasTests
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
@testable import mismangas

actor MockAuthorRepository: AuthorRepositoryProtocol {
    
    var mockAuthorsResult: [Author]?
    var mockError: Error?
    
    // MARK: - Mock Setters
    
    func setMockAuthorsResult(_ result: [Author]?) {
        mockAuthorsResult = result
    }
    
    func setMockError(_ error: APIError?) {
        mockError = error
    }
    
    // MARK: - Protocol method
    
    func fetchAuthors() async throws -> [Author] {
        if let error = mockError {
            throw error
        }
        return mockAuthorsResult ?? []
    }
}
