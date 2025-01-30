//
//  MockFetchItemsUseCase.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
@testable import mismangas

actor MockFetchItemsUseCase<T>: FetchItemsUseCaseProtocol where T: Searchable {

    var mockItems: [T]?
    var mockError: APIError?
    
    // MARK: - Mock Setter
    
    func setMockItems(_ items: [T]?) {
        mockItems = items
    }
    
    func setMockError(_ error: APIError?) {
        mockError = error
    }
    
    // MARK: - Protocol Method
    
    func execute() async throws -> [T] {
        if let error = mockError {
            throw error
        }
        return mockItems ?? []
    }
}
