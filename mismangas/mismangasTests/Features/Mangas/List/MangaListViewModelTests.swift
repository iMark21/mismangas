//
//  MangaListViewModelTests.swift
//  mismangasTests
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite @MainActor
struct MangaListViewModelTests {
    
    // MARK: - Properties
    
    private var sut: MangaListViewModel
    private var mockFetchMangasUseCase: FetchMangasUseCaseSpy

    // MARK: - Initialization
    
    init() {
        mockFetchMangasUseCase = FetchMangasUseCaseSpy()
        sut = MangaListViewModel(fetchMangasUseCase: mockFetchMangasUseCase)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenInitialStateWhenFetchInitialPageSucceedsThenStateIsContent() async throws {
        // GIVEN
        let mangas = Manga.previewData
        await mockFetchMangasUseCase.setMockResult(mangas)
        
        // WHEN
        await sut.fetchInitialPage()
        
        // THEN
        #expect(sut.state == .content(items: mangas, isLoadingMore: false))
    }
    
    @Test
    func testGivenInitialStateWhenFetchInitialPageFailsThenStateIsError() async throws {
        // GIVEN
        await mockFetchMangasUseCase.setMockError(.custom(message: "Failed to fetch manga"))
        
        // WHEN
        await sut.fetchInitialPage()
        
        // THEN
        #expect(sut.state == .error(message: "Error: Failed to fetch manga", items: []))
    }

    @Test
    func testGivenLoadedStateWhenFetchNextPageSucceedsThenStateIsUpdated() async throws {
        // GIVEN
        let mangas = Manga.previewData
        await mockFetchMangasUseCase.setMockResult(mangas)
        sut.state = .content(items: Manga.previewData, isLoadingMore: false)
        
        // WHEN
        await sut.fetchNextPage()
        
        // THEN
        #expect(sut.state == .content(items: mangas, isLoadingMore: false))
    }

    @Test
    func testGivenLoadedStateWhenFetchNextPageFailsThenStateIsError() async throws {
        // GIVEN
        await mockFetchMangasUseCase.setMockError(.custom(message: "Failed to fetch next page"))
        sut.state = .content(items: Manga.previewData, isLoadingMore: false)
        
        // WHEN
        await sut.fetchNextPage()
        
        // THEN
        #expect(sut.state == .error(message: "Error: Failed to fetch next page", items: Manga.previewData))
    }

    @Test
    func testGivenAnyStateWhenRefreshSucceedsThenStateIsContent() async throws {
        // GIVEN
        let mangas = Manga.previewData
        await mockFetchMangasUseCase.setMockResult(mangas)
        
        // WHEN
        await sut.refresh()
        
        // THEN
        #expect(sut.state == .content(items: mangas, isLoadingMore: false))
    }

    @Test
    func testGivenAnyStateWhenRefreshFailsThenStateIsError() async throws {
        // GIVEN
        await mockFetchMangasUseCase.setMockError(.custom(message: "Refresh failed"))
        
        // WHEN
        await sut.refresh()
        
        // THEN
        #expect(sut.state == .error(message: "Refresh failed: Refresh failed", items: []))
    }
}
