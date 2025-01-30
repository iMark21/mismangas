//
//  HomeViewModelTests.swift
//  mismangasTests
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite @MainActor
struct HomeViewModelTests {
    
    // MARK: - Properties
    
    private var sut: HomeViewModel
    private var mockFetchBestMangasUseCase: FetchBestMangasUseCaseSpy
    private var mockFetchGenresUseCase: FetchGenresUseCaseSpy
    private var mockFetchThemesUseCase: FetchThemesUseCaseSpy
    
    // MARK: - Initialization
    
    init() {
        mockFetchBestMangasUseCase = FetchBestMangasUseCaseSpy()
        mockFetchGenresUseCase = FetchGenresUseCaseSpy()
        mockFetchThemesUseCase = FetchThemesUseCaseSpy()
        
        sut = HomeViewModel(
            bestMangasUseCase: mockFetchBestMangasUseCase,
            genresUseCase: mockFetchGenresUseCase,
            themesUseCase: mockFetchThemesUseCase
        )
    }
    
    // MARK: - Tests
    
    @Test
    func testInitializationFetchesData() async throws {
        // GIVEN
        await mockFetchBestMangasUseCase.setMockResult(Manga.previewData)
        await mockFetchGenresUseCase.setMockResult(Manga.preview.genres)
        await mockFetchThemesUseCase.setMockResult(Manga.preview.themes)
        
        // WHEN
        await sut.fetchData()
        
        // THEN
        #expect(sut.bestMangas == Manga.previewData)
        #expect(sut.genres == Manga.preview.genres)
        #expect(sut.themes == Manga.preview.themes)
    }
}
