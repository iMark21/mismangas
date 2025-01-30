//
//  MangaDetailViewModelTests.swift
//  mismangasTests
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite(.serialized) @MainActor
struct MangaDetailViewModelTests {
    
    // MARK: - Properties
    
    private var sut: MangaDetailViewModel
    private var mockFetchMangaDetailsUseCase: FetchMangaDetailsUseCaseSpy
    private var mockCollectionManager: MangaCollectionManagerSpy
    private var modelContext: ModelContextProtocol
    
    // MARK: - Initialization
    
    init() {
        mockFetchMangaDetailsUseCase = FetchMangaDetailsUseCaseSpy()
        mockCollectionManager = MangaCollectionManagerSpy()
        modelContext = MockModelContext()
        
        sut = MangaDetailViewModel(
            mangaID: Manga.preview.id,
            fetchMangaDetailsUseCase: mockFetchMangaDetailsUseCase,
            collectionManager: mockCollectionManager
        )
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenValidMangaIDWhenFetchSucceedsThenStateIsContent() async throws {
        // GIVEN
        let manga = Manga.preview
        await mockFetchMangaDetailsUseCase.setMockResult(manga)
        
        // WHEN
        await sut.fetchMangaDetails(for: 1)
        
        // THEN
        #expect(sut.state == .content(manga: manga))
    }

    
    @Test
    func testGivenValidMangaIDWhenFetchFailsThenStateIsError() async throws {
        // GIVEN
        await mockFetchMangaDetailsUseCase.setMockError(.custom(message: "Failed to load manga details"))
        
        // WHEN
        await sut.fetchMangaDetails(for: Manga.preview.id)
        
        // THEN
        #expect(sut.state == .error(message: "Failed to load manga details."))
    }
    
    @Test
    func testGivenMangaInCollectionWhenToggleSucceedsThenStateIsContent() async throws {
        // GIVEN
        let manga = Manga.preview
        await (sut.fetchMangaDetailsUseCase as? FetchMangaDetailsUseCaseSpy)?.setMockResult(manga)
        await sut.load()
        
        // WHEN
        await sut.toggleCollection(manga, isInCollection: true, modelContext: modelContext)
        
        // THEN
        #expect(sut.state == .content(manga: manga))
    }
    
    @Test
    func testGivenMangaNotInCollectionWhenToggleSucceedsThenStateIsContent() async throws {
        // GIVEN
        let manga = Manga.preview
        await (sut.fetchMangaDetailsUseCase as? FetchMangaDetailsUseCaseSpy)?.setMockResult(manga)
        await sut.load()
        
        // WHEN
        await sut.toggleCollection(manga, isInCollection: false, modelContext: modelContext)
        
        // THEN
        #expect(sut.state == .content(manga: manga))
    }
    
    @Test
    func testResetWhenCalled() {
        // GIVEN
        sut.completeCollection = true
        sut.volumesOwned = [1, 2, 3]
        sut.readingVolume = 2
        
        // WHEN
        sut.reset()
        
        // THEN
        #expect(sut.completeCollection == false)
        #expect(sut.volumesOwned.isEmpty == true)
        #expect(sut.readingVolume == nil)
    }
}
