//
//  AuthorRepository.swift
//  mismangas
//
//  Created by Michel Marques on 6/1/25.
//

import Foundation

struct AuthorRepository: AuthorRepositoryProtocol {
    
    let client: APIClient = MisMangasAPIClient()

    func fetchAuthors(query: String?, page: Int? = nil, perPage: Int? = nil) async throws -> [Author] {
        let url: URL
        if let query, !query.isEmpty {
            url = .searchAuthors(by: query)
        } else {
            url = .authors
        }

        // Append pagination query items
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        if let page,
            let perPage {
            components?.queryItems = [
                .page(page),
                .per(perPage)
            ]
        }

        // Validate the final URL
        guard let finalURL = components?.url else {
            throw URLError(.badURL)
        }

        let result: [AuthorDTO] = try await client.perform(.get(finalURL))
        
        // Map the response to domain models
        return result.compactMap({ $0.toDomain() })
    }
}
