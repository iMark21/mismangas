//
//  AuthorRepositoryTests.swift
//  mismangas
//
//  Created by Michel Marques on 29/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite
struct AuthorRepositoryTests {
    
    // MARK: - Properties
    
    private var sut: AuthorRepository
    private var mockAPIClient: MockAPIClient
    
    // MARK: - Initialization
    
    init() {
        mockAPIClient = MockAPIClient()
        sut = AuthorRepository(client: mockAPIClient)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenValidJSONWhenFetchingAuthorsThenReturnsExpectedList() async throws {
        // GIVEN
        let jsonData = try JSONLoader.load("authors_mock")
        let expectedAuthorsDTO = try JSONDecoder().decode([AuthorDTO].self, from: jsonData)

        await mockAPIClient.setMockResult(expectedAuthorsDTO)

        // WHEN
        let authors: [Author] = try await sut.fetchAuthors()

        // THEN
        #expect(authors == expectedAuthorsDTO.map { $0.toDomain() })
    }
    
    @Test
    func testGivenEmptyJSONWhenFetchingAuthorsThenReturnsEmptyList() async throws {
        // GIVEN
        await mockAPIClient.setMockResult([AuthorDTO]())

        // WHEN
        let authors = try await sut.fetchAuthors()

        // THEN
        #expect(authors.isEmpty)
    }
    
    @Test
    func testGivenAPIClientThrowsErrorWhenFetchingAuthorsThenPropagatesError() async {
        // GIVEN
        await mockAPIClient.setMockError(.invalidResponse)

        // WHEN / THEN
        await #expect(throws: APIError.invalidResponse) {
            let _ = try await sut.fetchAuthors()
        }
    }
}
