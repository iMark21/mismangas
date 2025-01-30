//
//  FetchThemesUseCaseTests.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Testing
@testable import mismangas

@Suite
struct FetchThemesUseCaseTests {
    
    // MARK: - Properties
    
    private var sut: FetchThemesUseCase
    private var mockRepository: MockThemeRepository
    
    // MARK: - Initialization
    
    init() {
        mockRepository = MockThemeRepository()
        sut = FetchThemesUseCase(repository: mockRepository)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenThemesWhenExecuteThenReturnsThemes() async throws {
        // GIVEN
        let expectedThemes = Theme.previewData
        await mockRepository.setMockFetchThemesResult(expectedThemes)
        
        // WHEN
        let themes = try await sut.execute()
        
        // THEN
        #expect(themes == expectedThemes)
    }
    
    @Test
    func testGivenNoThemesWhenExecuteThenReturnsEmptyList() async throws {
        // GIVEN
        await mockRepository.setMockFetchThemesResult([])
        
        // WHEN
        let themes = try await sut.execute()
        
        // THEN
        #expect(themes.isEmpty)
    }
    
    @Test
    func testGivenRepositoryThrowsErrorWhenExecuteThenThrowsError() async {
        // GIVEN
        await mockRepository.setMockFetchThemesError(.custom(message: "Repository error"))
        
        // WHEN / THEN
        await #expect(throws: APIError.custom(message: "Repository error")) {
            let _ = try await sut.execute()
        }
    }
}
