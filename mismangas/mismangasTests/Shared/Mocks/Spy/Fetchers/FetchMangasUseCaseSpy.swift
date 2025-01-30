//
//  FetchMangasUseCaseSpy.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
@testable import mismangas

actor FetchMangasUseCaseSpy: FetchMangasUseCaseProtocol {
    var mockResult: [Manga] = []
    var mockError: APIError?
    
    // MARK: - Mock Setters
    
    func setMockResult(_ result: [Manga]) {
        mockResult = result
    }
    
    func setMockError(_ error: APIError?) {
        mockError = error
    }

    // MARK: - Protocol Method
    
    func execute(filter: MangaFilter, page: Int, perPage: Int) async throws -> [Manga] {
        if let error = mockError {
            throw error
        }
        return mockResult
    }
}
