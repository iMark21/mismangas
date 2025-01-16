//
//  DemographicRepository.swift
//  mismangas
//
//  Created by Michel Marques on 16/1/25.
//


import Foundation

struct DemographicRepository: DemographicRepositoryProtocol {
    
    let client: APIClient = MisMangasAPIClient()

    func fetchDemographics() async throws -> [Demographic] {
        let url: URL = .demographics

        let result: [DemographicDTO] = try await client.perform(.get(url))
        
        // Map the response to domain models
        return result.compactMap { $0.toDomain() }
    }
}