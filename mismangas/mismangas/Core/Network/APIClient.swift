//
//  APIClient.swift
//  mismangas
//
//  Created by Michel Marques on 10/12/24.
//

import Foundation

protocol APIClient: Sendable {
    func perform<T>(_ request: URLRequest) async throws -> T
}

struct MisMangasAPIClient: APIClient {
    private let session: URLSession
    private let jsonDecoder: JSONDecoder

    // MARK: - Init
    
    init(session: URLSession = .shared, jsonDecoder: JSONDecoder = .init()) {
        self.session = session
        self.jsonDecoder = jsonDecoder
    }

    // MARK: - Public Methods
    
    func perform<T>(_ request: URLRequest) async throws -> T {
        Logger.logRequest(request) // Log the request details

        do {
            // 1. Execute the request and validate the response
            let (data, response) = try await session.data(for: request)
            Logger.logResponse(response, data: data) // Log the response details

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            try validate(httpResponse)

            // 2. Decode the response based on the type of T
            switch T.self {
            case is String.Type:
                guard let string = String(data: data, encoding: .utf8) as? T else {
                    throw APIError.decodingError(NSError(domain: "PlainText", code: 0))
                }
                return string

            case is Void.Type:
                guard data.isEmpty else {
                    throw APIError.custom(message: "Expected empty response but received data")
                }
                return () as! T

            default:
                guard let decodableType = T.self as? Decodable.Type else {
                    throw APIError.custom(message: "Type \(T.self) is not Decodable")
                }
                return try jsonDecoder.decode(decodableType, from: data) as! T
            }
        } catch {
            Logger.logError(error) // Log the error details
            throw error
        }
    }

    // MARK: - Private Methods
    private func validate(_ httpResponse: HTTPURLResponse) throws {
        guard (200..<300).contains(httpResponse.statusCode) else {
            Logger.logErrorMessage("Invalid response: \(httpResponse.statusCode)")
            throw APIError.statusCode(httpResponse.statusCode)
        }
    }
}
