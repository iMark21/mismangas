//
//  FetchBestMangasUseCaseTests.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite
struct FetchBestMangasUseCaseTests {
    
    // MARK: - Properties
    
    private var sut: FetchBestMangasUseCase
    private var mockRepository: MockMangaRepository
    
    // MARK: - Initialization
    
    init() {
        mockRepository = MockMangaRepository()
        sut = FetchBestMangasUseCase(repository: mockRepository)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenBestMangasWhenExecuteThenReturnsMangas() async throws {
        // GIVEN
        let expectedMangas = Manga.previewData
        await mockRepository.setMockFetchBestMangasResult(expectedMangas)
        
        // WHEN
        let mangas = try await sut.execute()
        
        // THEN
        #expect(mangas == expectedMangas)
    }
    
    @Test
    func testGivenNoBestMangasWhenExecuteThenReturnsEmptyList() async throws {
        // GIVEN
        await mockRepository.setMockFetchBestMangasResult([])
        
        // WHEN
        let mangas = try await sut.execute()
        
        // THEN
        #expect(mangas.isEmpty)
    }
    
    @Test
    func testGivenRepositoryThrowsErrorWhenExecuteThenThrowsError() async {
        // GIVEN
        await mockRepository.setMockFetchBestMangasError(.custom(message: "Repository error"))
        
        // WHEN / THEN
        await #expect(throws: APIError.custom(message: "Repository error")) {
            let _ = try await sut.execute()
        }
    }
}
