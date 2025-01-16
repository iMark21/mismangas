//
//  GenreRepository.swift
//  mismangas
//
//  Created by Michel Marques on 13/1/25.
//


import Foundation

struct GenreRepository: GenreRepositoryProtocol {
    
    let client: APIClient = MisMangasAPIClient()

    func fetchGenres() async throws -> [Genre] {
        let url: URL = .genres

        let result: [GenreDTO] = try await client.perform(.get(url))
        
        // Map the response to domain models
        return result.compactMap { $0.toDomain() }
    }
}
