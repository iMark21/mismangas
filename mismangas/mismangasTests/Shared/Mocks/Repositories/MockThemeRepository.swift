//
//  MockThemeRepository.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
@testable import mismangas

actor MockThemeRepository: ThemeRepositoryProtocol {
    
    // MARK: - Mock Properties
    
    var mockFetchThemesResult: [Theme]?
    var mockFetchThemesError: Error?
    
    // MARK: - Mock Setters
    
    func setMockFetchThemesResult(_ result: [Theme]?) {
        mockFetchThemesResult = result
    }
    
    func setMockFetchThemesError(_ error: APIError?) {
        mockFetchThemesError = error
    }
    
    // MARK: - Protocol Method
    
    func fetchThemes() async throws -> [Theme] {
        if let error = mockFetchThemesError {
            throw error
        }
        return mockFetchThemesResult ?? []
    }
}
