//
//  MockAPIClient.swift
//  mismangasTests
//
//  Created by Michel Marques on 29/01/25.
//

import Foundation
@testable import mismangas

actor MockAPIClient: APIClient {
    
    var mockResult: Any?
    var mockError: APIError?
    
    func setMockResult<T>(_ result: T) async {
        mockResult = result
    }
    
    func setMockError(_ error: APIError) async {
        mockError = error
    }
    
    func perform<T>(_ request: URLRequest) async throws -> T {
        if let error = mockError {
            throw error
        }
        
        guard let result = mockResult as? T else {
            fatalError("MockAPIClient was not configured with a result of type \(T.self)")
        }
        
        return result
    }
}
