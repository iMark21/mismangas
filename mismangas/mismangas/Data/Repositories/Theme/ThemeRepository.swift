//
//  ThemeRepository.swift
//  mismangas
//
//  Created by Michel Marques on 16/1/25.
//

import Foundation

struct ThemeRepository: ThemeRepositoryProtocol {
    
    var client: APIClient = MisMangasAPIClient()

    func fetchThemes() async throws -> [Theme] {
        let url: URL = .themes

        let result: [ThemeDTO] = try await client.perform(.get(url))
        
        // Map the response to domain models
        return result.compactMap { $0.toDomain() }
    }
}
