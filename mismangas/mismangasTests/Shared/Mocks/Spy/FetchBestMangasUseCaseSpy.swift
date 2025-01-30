//
//  FetchBestMangasUseCaseSpy.swift
//  mismangasTests
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
@testable import mismangas

final class FetchBestMangasUseCaseSpy: FetchBestMangasUseCaseProtocol {
    
    var mockResult: [Manga]?
    var mockError: Error?
    
    // MARK: - Mock Setter
    
    func setMockResult(_ result: [Manga]?) {
        mockResult = result
    }
    
    func setMockError(_ error: Error?) {
        mockError = error
    }
    
    // MARK: - Protocol Method
    
    func execute() async throws -> [Manga] {
        if let error = mockError {
            throw error
        }
        return mockResult ?? []
    }
}