//
//  FetchDemographicsUseCase.swift
//  mismangas
//
//  Created by Michel Marques on 16/1/25.
//


import Foundation

struct FetchDemographicsUseCase: FetchDemographicsUseCaseProtocol {
    
    var repository: DemographicRepositoryProtocol = DemographicRepository()

    func execute() async throws -> [Demographic] {
        return try await repository.fetchDemographics()
    }
}
