//
//  AuthorRepository.swift
//  mismangas
//
//  Created by Michel Marques on 6/1/25.
//

import Foundation

struct AuthorRepository: AuthorRepositoryProtocol {
    
    let client: APIClient = MisMangasAPIClient()

    func fetchAuthors() async throws -> [Author] {
        let url: URL = .authors
        
        let result: [AuthorDTO] = try await client.perform(.get(url))
        
        // Map the response to domain models
        return result.compactMap({ $0.toDomain() })
    }
}
