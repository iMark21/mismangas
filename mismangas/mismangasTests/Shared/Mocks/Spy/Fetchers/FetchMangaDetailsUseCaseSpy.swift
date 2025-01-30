//
//  FetchMangaDetailsUseCaseSpy.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
@testable import mismangas

actor FetchMangaDetailsUseCaseSpy: FetchMangaDetailsUseCaseProtocol {
    
    var mockResult: Manga?
    var mockError: APIError?
    
    // MARK: - Mock Setter
    
    func setMockResult(_ result: Manga?) async {
        mockResult = result
    }
    
    func setMockError(_ error: APIError?) async {
        mockError = error
    }
    
    // MARK: - Protocol Method
    
    func execute(id: Int) async throws -> Manga {
        if let error = mockError {
            throw error
        }
        if let result = mockResult {
            return result
        }
        throw APIError.custom(message: "Manga not found")
    }
}
