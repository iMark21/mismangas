//
//  MangaRepository.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

struct MangaRepository: MangaRepositoryProtocol {
    
    let client: APIClient = MisMangasAPIClient()
    
    // MARK: - Public Methods
    
    func fetchMangasBy(filter: MangaFilter, page: Int, perPage: Int) async throws -> [Manga] {
        let url: URL
        switch filter.searchType {
        case .beginsWith:
            url = .searchMangasBeginsWith(filter.query)
        case .contains:
            url = .searchMangasContains(filter.query)
        case .author:
            url = .searchMangasByAuthor(filter.id ?? "")
        case .genre:
            url = .searchMangasByGenre(filter.id ?? "")
        case .theme:
            url = .searchMangasByTheme(filter.id ?? "")
        case .demographic:
            url = .searchMangasByDemographic(filter.id ?? "")
        default:
            url = .mangas
        }
        
        return try await performFetch(baseURL: url, page: page, perPage: perPage)
    }
    
    // MARK: - Private Helper Method
    
    private func performFetch(baseURL: URL, page: Int, perPage: Int) async throws -> [Manga] {
        // Append pagination query items
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            .page(page),
            .per(perPage)
        ]
        
        // Validate the final URL
        guard let finalURL = components?.url else {
            throw URLError(.badURL)
        }
        
        // Perform API request using the client
        let result: MangaResponseDTO = try await client.perform(.get(finalURL))
        
        // Map the response to domain models
        return result.items.compactMap { $0.toDomain() }
    }
}
