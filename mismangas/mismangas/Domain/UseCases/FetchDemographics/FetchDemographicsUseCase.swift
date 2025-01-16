//
//  FetchDemographicsUseCase.swift
//  mismangas
//
//  Created by Michel Marques on 16/1/25.
//


import Foundation

struct FetchDemographicsUseCase: FetchDemographicsUseCaseProtocol {
    
    let repository: DemographicRepositoryProtocol = DemographicRepository()

    func execute(query: String? = nil, page: Int? = nil, perPage: Int? = nil) async throws -> [Demographic] {
        return try await repository.fetchDemographics()
    }
}