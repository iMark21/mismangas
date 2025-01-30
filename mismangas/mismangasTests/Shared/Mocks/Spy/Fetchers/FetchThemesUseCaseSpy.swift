//
//  FetchThemesUseCaseSpy.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
@testable import mismangas

actor FetchThemesUseCaseSpy: FetchThemesUseCaseProtocol {
    
    var mockResult: [Theme]?
    var mockError: Error?
    
    // MARK: - Mock Setter
    
    func setMockResult(_ result: [Theme]?) {
        mockResult = result
    }
    
    func setMockError(_ error: Error?) {
        mockError = error
    }
    
    // MARK: - Protocol Method
    
    func execute() async throws -> [Theme] {
        if let error = mockError {
            throw error
        }
        return mockResult ?? []
    }
}
