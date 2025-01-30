//
//  FetchGenresUseCaseTests.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//


import Foundation
import Testing
@testable import mismangas

@Suite
struct FetchGenresUseCaseTests {
    
    // MARK: - Properties
    
    private var sut: FetchGenresUseCase
    private var mockRepository: MockGenreRepository
    
    // MARK: - Initialization
    
    init() {
        mockRepository = MockGenreRepository()
        sut = FetchGenresUseCase(repository: mockRepository)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenGenresWhenExecuteThenReturnsGenres() async throws {
        // GIVEN
        let expectedGenres = Genre.previewData
        await mockRepository.setMockFetchGenresResult(expectedGenres)
        
        // WHEN
        let genres = try await sut.execute()
        
        // THEN
        #expect(genres == expectedGenres)
    }
    
    @Test
    func testGivenNoGenresWhenExecuteThenReturnsEmptyList() async throws {
        // GIVEN
        await mockRepository.setMockFetchGenresResult([])
        
        // WHEN
        let genres = try await sut.execute()
        
        // THEN
        #expect(genres.isEmpty)
    }
    
    @Test
    func testGivenRepositoryThrowsErrorWhenExecuteThenThrowsError() async {
        // GIVEN
        await mockRepository.setMockFetchGenresError(APIError.custom(message: "Repository error"))
        
        // WHEN / THEN
        await #expect(throws: APIError.custom(message: "Repository error")) {
            let _ = try await sut.execute()
        }
    }
}
