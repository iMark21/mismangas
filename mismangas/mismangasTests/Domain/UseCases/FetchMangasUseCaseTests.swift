//
//  FetchMangasUseCaseTests.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite
struct FetchMangasUseCaseTests {
    
    // MARK: - Properties
    
    private var sut: FetchMangasUseCase
    private var mockRepository: MockMangaRepository
    
    // MARK: - Initialization
    
    init() {
        mockRepository = MockMangaRepository()
        sut = FetchMangasUseCase(repository: mockRepository)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenValidFilterWhenExecuteThenReturnsMangas() async throws {
        // GIVEN
        let filter = MangaFilter(query: "Monster", searchType: .contains)
        let expectedMangas = [Manga.preview]
        await mockRepository.setMockFetchMangasByResult(expectedMangas)
        
        // WHEN
        let mangas = try await sut.execute(filter: filter, page: 1, perPage: 10)
        
        // THEN
        #expect(mangas == expectedMangas)
    }
    
    @Test
    func testGivenNoMangasWhenExecuteThenReturnsEmptyList() async throws {
        // GIVEN
        let filter = MangaFilter(query: "TheresNoItemsForThisQuery", searchType: .contains)
        await mockRepository.setMockFetchMangasByResult([])
        
        // WHEN
        let mangas = try await sut.execute(filter: filter, page: 1, perPage: 10)
        
        // THEN
        #expect(mangas.isEmpty)
    }
    
    @Test
    func testGivenRepositoryThrowsErrorWhenExecuteThenThrowsError() async {
        // GIVEN
        let filter = MangaFilter(query: "Naruto", searchType: .contains)
        await mockRepository.setMockFetchMangasByError(.custom(message: "Repository error"))
        
        // WHEN / THEN
        await #expect(throws: APIError.custom(message: "Repository error")) {
            let _ = try await sut.execute(filter: filter, page: 1, perPage: 10)
        }
    }
}
