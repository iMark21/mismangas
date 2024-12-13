//
//  MangaRepository.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

struct MangaRepository: MangaRepositoryProtocol {
    
    let client: APIClient = MisMangasAPIClient()
    
    func fetchMangas(page: Int, perPage: Int) async throws -> [Manga] {
        
        // Build URL
        var components = URLComponents(url: .mangas, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            .page(page),
            .per(perPage)
        ]
        
        // Check if URL is correct
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        // API request to Client
        let result: MangaResponseDTO = try await client.perform(.get(url))
        
        // Map response to domain
        return result.items.compactMap { $0.toDomain() }
    }
}
