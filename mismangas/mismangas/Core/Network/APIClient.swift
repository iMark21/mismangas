//
//  APIClient.swift
//  mismangas
//
//  Created by Michel Marques on 10/12/24.
//

import Foundation

protocol APIClient: Sendable {
    func perform<T: Decodable>(_ request: URLRequest) async throws -> T
}

struct MisMangasAPIClient: APIClient {
    let session: URLSession = .shared
    let decoder: JSONDecoder = .init()
    
    func perform<T: Decodable>(_ request: URLRequest) async throws -> T {
        
        // Log Request
        Logger.logRequest(request)
        
        do {
            let (data, response) = try await session.data(for: request)
            // Log Response
            Logger.logResponse(response, data: data)
            
            try validate(response: response)
            return try decode(data: data)
        } catch let urlError as URLError {
            // Log Error
            Logger.logError(urlError)
            throw APIError.networkError(urlError)
        } catch let decodingError as DecodingError {
            // Log Error
            Logger.logError(decodingError)
            throw APIError.decodingError(decodingError)
        } catch {
            // Log Error
            Logger.logError(error)
            throw APIError.unknown(error)
        }
    }
    
    // MARK: - Helpers
    
    private func validate(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        let validStatusCodes = 200..<300
        guard validStatusCodes.contains(httpResponse.statusCode) else {
            throw APIError.statusCode(httpResponse.statusCode)
        }
    }
    
    private func decode<T: Decodable>(data: Data) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            Logger.logError(error)
            throw APIError.decodingError(error)
        }
    }
}
