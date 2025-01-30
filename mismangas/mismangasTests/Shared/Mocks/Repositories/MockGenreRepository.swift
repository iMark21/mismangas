//
//  MockGenreRepository.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
@testable import mismangas

actor MockGenreRepository: GenreRepositoryProtocol {
    
    // MARK: - Mock Properties
    
    var mockFetchGenresResult: [Genre]?
    var mockFetchGenresError: Error?
    
    // MARK: - Mock Setters
    
    func setMockFetchGenresResult(_ result: [Genre]?) {
        mockFetchGenresResult = result
    }
    
    func setMockFetchGenresError(_ error: Error?) {
        mockFetchGenresError = error
    }
    
    // MARK: - Protocol Method
    
    func fetchGenres() async throws -> [Genre] {
        if let error = mockFetchGenresError {
            throw error
        }
        return mockFetchGenresResult ?? []
    }
}
