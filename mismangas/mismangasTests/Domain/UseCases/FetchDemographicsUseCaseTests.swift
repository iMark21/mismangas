//
//  FetchDemographicsUseCaseTests.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//


import Foundation
import Testing
@testable import mismangas

@Suite
struct FetchDemographicsUseCaseTests {
    
    // MARK: - Properties
    
    private var sut: FetchDemographicsUseCase
    private var mockRepository: MockDemographicRepository
    
    // MARK: - Initialization
    
    init() {
        mockRepository = MockDemographicRepository()
        sut = FetchDemographicsUseCase(repository: mockRepository)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenValidDemographicsWhenExecuteThenReturnsDemographics() async throws {
        // GIVEN
        let expectedDemographics = Demographic.previewData
        await mockRepository.setMockFetchDemographicsResult(expectedDemographics)
        
        // WHEN
        let demographics = try await sut.execute()
        
        // THEN
        #expect(demographics == expectedDemographics)
    }
    
    @Test
    func testGivenNoDemographicsWhenExecuteThenReturnsEmptyList() async throws {
        // GIVEN
        await mockRepository.setMockFetchDemographicsResult([])
        
        // WHEN
        let demographics = try await sut.execute()
        
        // THEN
        #expect(demographics.isEmpty)
    }
    
    @Test
    func testGivenRepositoryThrowsErrorWhenExecuteThenThrowsError() async {
        // GIVEN
        await mockRepository.setMockFetchDemographicsError(.custom(message: "Repository error"))
        
        // WHEN / THEN
        await #expect(throws: APIError.custom(message: "Repository error")) {
            let _ = try await sut.execute()
        }
    }
}
