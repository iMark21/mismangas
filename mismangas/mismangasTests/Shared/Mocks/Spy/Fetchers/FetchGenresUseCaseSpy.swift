//
//  FetchGenresUseCaseSpy.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
@testable import mismangas

actor FetchGenresUseCaseSpy: FetchGenresUseCaseProtocol {
    
    var mockResult: [Genre]?
    var mockError: Error?
    
    // MARK: - Mock Setter
    
    func setMockResult(_ result: [Genre]?) {
        mockResult = result
    }
    
    func setMockError(_ error: Error?) {
        mockError = error
    }
    
    // MARK: - Protocol Method
    
    func execute() async throws -> [Genre] {
        if let error = mockError {
            throw error
        }
        return mockResult ?? []
    }
}
