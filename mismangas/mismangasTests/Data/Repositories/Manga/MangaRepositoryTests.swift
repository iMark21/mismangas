//
//  MangaRepositoryTests.swift
//  mismangas
//
//  Created by Michel Marques on 29/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite
struct MangaRepositoryTests {
    
    // MARK: - Properties
    
    private var sut: MangaRepository
    private var mockAPIClient: MockAPIClient
    
    // MARK: - Initialization
    
    init() {
        mockAPIClient = MockAPIClient()
        sut = MangaRepository(client: mockAPIClient)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenValidJSONWhenFetchingBestMangasThenReturnsExpectedList() async throws {
        // GIVEN
        let jsonData = try JSONLoader.load("best_mangas_mock")
        let expectedMangasDTO = try JSONDecoder().decode(MangaResponseDTO.self, from: jsonData)

        await mockAPIClient.setMockResult(expectedMangasDTO)

        // WHEN
        let mangas = try await sut.fetchBestMangas()

        // THEN
        #expect(mangas == expectedMangasDTO.items.map { $0.toDomain() })
    }
    
    @Test
    func testGivenValidFilterWhenFetchingMangasThenReturnsExpectedList() async throws {
        // GIVEN
        let jsonData = try JSONLoader.load("mangas_mock")
        let expectedMangasDTO = try JSONDecoder().decode(MangaResponseDTO.self, from: jsonData)

        await mockAPIClient.setMockResult(expectedMangasDTO)

        let filter = MangaFilter(query: "Naruto", searchType: .beginsWith)

        // WHEN
        let mangas = try await sut.fetchMangasBy(filter: filter, page: 1, perPage: 10)

        // THEN
        #expect(mangas == expectedMangasDTO.items.map { $0.toDomain() })
    }
    
    @Test
    func testGivenValidMangaIDWhenFetchingDetailsThenReturnsExpectedManga() async throws {
        // GIVEN
        let jsonData = try JSONLoader.load("manga_detail_mock")
        let expectedMangaDTO = try JSONDecoder().decode(MangaDTO.self, from: jsonData)

        await mockAPIClient.setMockResult(expectedMangaDTO)

        // WHEN
        let manga = try await sut.fetchMangaDetails(by: 42)

        // THEN
        #expect(manga == expectedMangaDTO.toDomain())
    }
    
    @Test
    func testGivenAPIClientThrowsErrorWhenFetchingMangasThenPropagatesError() async {
        // GIVEN
        await mockAPIClient.setMockError(APIError.invalidResponse)

        // WHEN / THEN
        await #expect(throws: APIError.invalidResponse) {
            let _ = try await sut.fetchMangasBy(filter: .init(query: "One Piece", searchType: .contains), page: 1, perPage: 10)
        }
    }
}
