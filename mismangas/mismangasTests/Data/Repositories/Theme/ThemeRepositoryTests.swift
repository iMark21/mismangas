//
//  ThemeRepositoryTests.swift
//  mismangas
//
//  Created by Michel Marques on 29/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite
struct ThemeRepositoryTests {
    
    // MARK: - Properties
    
    private var sut: ThemeRepository
    private var mockAPIClient: MockAPIClient
    
    // MARK: - Initialization
    
    init() {
        mockAPIClient = MockAPIClient()
        sut = ThemeRepository(client: mockAPIClient)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenValidJSONWhenFetchingThemesThenReturnsExpectedList() async throws {
        // GIVEN
        let jsonData = try JSONLoader.load("themes_mock")
        let expectedThemes = try JSONDecoder().decode([ThemeDTO].self, from: jsonData)
        
        await mockAPIClient.setMockResult(expectedThemes)

        // WHEN
        let themes = try await sut.fetchThemes()

        // THEN
        #expect(themes == expectedThemes.map { $0.toDomain() })
    }
    
    @Test
    func testGivenEmptyJSONWhenFetchingThemesThenReturnsEmptyList() async throws {
        // GIVEN
        await mockAPIClient.setMockResult([ThemeDTO]())

        // WHEN
        let themes = try await sut.fetchThemes()

        // THEN
        #expect(themes.isEmpty)
    }
    
    @Test
    func testGivenAPIClientThrowsErrorWhenFetchingThemesThenPropagatesError() async {
        // GIVEN
        await mockAPIClient.setMockError(APIError.invalidResponse)

        // WHEN / THEN
        await #expect(throws: APIError.invalidResponse) {
            let _ = try await sut.fetchThemes()
        }
    }
}
