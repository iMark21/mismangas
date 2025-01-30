//
//  FetchDemographicsUseCaseSpy.swift
//  mismangasTests
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
@testable import mismangas

final class FetchDemographicsUseCaseSpy: FetchDemographicsUseCaseProtocol {
    
    var mockResult: [Demographic]?
    var mockError: Error?
    
    // MARK: - Mock Setter
    
    func setMockResult(_ result: [Demographic]?) {
        mockResult = result
    }
    
    func setMockError(_ error: Error?) {
        mockError = error
    }
    
    // MARK: - Protocol Method
    
    func execute() async throws -> [Demographic] {
        if let error = mockError {
            throw error
        }
        return mockResult ?? []
    }
}