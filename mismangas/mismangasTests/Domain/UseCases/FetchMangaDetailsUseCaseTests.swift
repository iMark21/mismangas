//
//  FetchMangaDetailsUseCaseTests.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite
struct FetchMangaDetailsUseCaseTests {
    
    // MARK: - Properties
    
    private var sut: FetchMangaDetailsUseCase
    private var mockRepository: MockMangaRepository
    
    // MARK: - Initialization
    
    init() {
        mockRepository = MockMangaRepository()
        sut = FetchMangaDetailsUseCase(repository: mockRepository)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenValidMangaIDWhenExecuteThenReturnsManga() async throws {
        // GIVEN
        let expectedManga = Manga.preview
        await mockRepository.setMockFetchMangaDetailsResult(expectedManga)
        
        // WHEN
        let manga = try await sut.execute(id: expectedManga.id)
        
        // THEN
        #expect(manga == expectedManga)
    }
    
    @Test
    func testGivenInvalidMangaIDWhenExecuteThenThrowsError() async {
        // GIVEN
        let mangaID = 9121021
        await mockRepository.setMockFetchMangaDetailsError(.custom(message: "Manga not found"))
        
        // WHEN / THEN
        await #expect(throws: APIError.custom(message: "Manga not found")) {
            let _ = try await sut.execute(id: mangaID)
        }
    }
    
    @Test
    func testGivenNoMangaDetailsWhenExecuteThenThrowsError() async {
        // GIVEN
        let mangaID = Manga.preview.id
        await mockRepository.setMockFetchMangaDetailsResult(nil)
        
        // WHEN / THEN
        await #expect(throws: APIError.custom(message: "Manga details not found")) {
            let _ = try await sut.execute(id: mangaID)
        }
    }
}
