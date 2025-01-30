//
//  APIError.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

enum APIError: LocalizedError, Sendable, Equatable {
    
    case invalidResponse
    case statusCode(Int)
    case decodingError(Error)
    case networkError(URLError)
    case unauthorized
    case forbidden
    case tokenExpired
    case badRequest
    case custom(message: String)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The response is invalid."
        case .statusCode(let code):
            return "Error response with status code: \(code)."
        case .decodingError(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .unauthorized:
            return "Unauthorized user. Please check your credentials."
        case .forbidden:
            return "Access denied. You don't have permission for this action."
        case .tokenExpired:
            return "Your session has expired. Please log in again."
        case .badRequest:
            return "Bad request. Please check your input."
        case .custom(let message):
            return message
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        return lhs.errorDescription == rhs.errorDescription
    }
}
