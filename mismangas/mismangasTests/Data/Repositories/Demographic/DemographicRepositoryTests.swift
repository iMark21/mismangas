//
//  DemographicRepositoryTests.swift
//  mismangas
//
//  Created by Michel Marques on 29/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite
struct DemographicRepositoryTests {
    
    // MARK: - Properties
    
    private var sut: DemographicRepository
    private var mockAPIClient: MockAPIClient
    
    // MARK: - Initialization
    
    init() {
        mockAPIClient = MockAPIClient()
        sut = DemographicRepository(client: mockAPIClient)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenValidJSONWhenFetchingDemographicsThenReturnsExpectedList() async throws {
        // GIVEN
        let jsonData = try JSONLoader.load("demographics_mock")
        let expectedDemographicsDTO = try JSONDecoder().decode([DemographicDTO].self, from: jsonData)
        
        await mockAPIClient.setMockResult(expectedDemographicsDTO)

        // WHEN
        let demographics = try await sut.fetchDemographics()

        // THEN
        #expect(demographics == expectedDemographicsDTO.map { $0.toDomain() })
    }
    
    @Test
    func testGivenEmptyJSONWhenFetchingDemographicsThenReturnsEmptyList() async throws {
        // GIVEN
        await mockAPIClient.setMockResult([DemographicDTO]())

        // WHEN
        let demographics = try await sut.fetchDemographics()

        // THEN
        #expect(demographics.isEmpty)
    }
    
    @Test
    func testGivenAPIClientThrowsErrorWhenFetchingDemographicsThenPropagatesError() async {
        // GIVEN
        await mockAPIClient.setMockError(.invalidResponse)

        // WHEN / THEN
        await #expect(throws: APIError.invalidResponse) {
            let _ = try await sut.fetchDemographics()
        }
    }
}
