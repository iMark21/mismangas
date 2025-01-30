//
//  MockDemographicRepository.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//


import Foundation
@testable import mismangas

actor MockDemographicRepository: DemographicRepositoryProtocol {
    
    // MARK: - Mock Properties
    
    var mockFetchDemographicsResult: [Demographic]?
    var mockFetchDemographicsError: Error?
    
    // MARK: - Mock Setters
    
    func setMockFetchDemographicsResult(_ result: [Demographic]?) {
        mockFetchDemographicsResult = result
    }
    
    func setMockFetchDemographicsError(_ error: APIError?) {
        mockFetchDemographicsError = error
    }
    
    // MARK: - Protocol Method
    
    func fetchDemographics() async throws -> [Demographic] {
        if let error = mockFetchDemographicsError {
            throw error
        }
        return mockFetchDemographicsResult ?? []
    }
}
