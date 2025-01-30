//
//  GenreRepositoryTests.swift
//  mismangas
//
//  Created by Michel Marques on 29/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite
struct GenreRepositoryTests {
    
    // MARK: - Properties
    
    private var sut: GenreRepository
    private var mockAPIClient: MockAPIClient
    
    // MARK: - Initialization
    
    init() {
        mockAPIClient = MockAPIClient()
        sut = GenreRepository(client: mockAPIClient)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenValidJSONWhenFetchingGenresThenReturnsExpectedList() async throws {
        // GIVEN
        let jsonData = try JSONLoader.load("genres_mock")
        let expectedGenresDTO = try JSONDecoder().decode([GenreDTO].self, from: jsonData)

        await mockAPIClient.setMockResult(expectedGenresDTO)

        // WHEN
        let genres = try await sut.fetchGenres()

        // THEN
        #expect(genres == expectedGenresDTO.map { $0.toDomain() })
    }
    
    @Test
    func testGivenEmptyJSONWhenFetchingGenresThenReturnsEmptyList() async throws {
        // GIVEN
        await mockAPIClient.setMockResult([GenreDTO]())

        // WHEN
        let genres = try await sut.fetchGenres()

        // THEN
        #expect(genres.isEmpty)
    }
    
    @Test
    func testGivenAPIClientThrowsErrorWhenFetchingGenresThenPropagatesError() async {
        // GIVEN
        await mockAPIClient.setMockError(APIError.invalidResponse)

        // WHEN / THEN
        await #expect(throws: APIError.invalidResponse) {
            let _ = try await sut.fetchGenres()
        }
    }
}
