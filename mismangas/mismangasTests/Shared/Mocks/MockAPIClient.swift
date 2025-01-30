//
//  MockAPIClient.swift
//  mismangasTests
//
//  Created by Michel Marques on 29/01/25.
//

import Foundation
@testable import mismangas

final class MockAPIClient: APIClient {
    
    var mockResult: Any?
    var mockError: Error?
    
    func perform<T: Decodable>(_ request: APIRequest<T>) async throws -> T {
        if let error = mockError {
            throw error
        }
        
        guard let result = mockResult as? T else {
            fatalError("MockAPIClient was not configured with a result of type \(T.self)")
        }
        
        return result
    }
}