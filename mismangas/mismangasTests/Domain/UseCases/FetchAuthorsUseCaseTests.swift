//
//  FetchAuthorsUseCaseTests.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite
struct FetchAuthorsUseCaseTests {
    
    // MARK: - Properties
    
    private var sut: FetchAuthorsUseCase
    private var mockRepository: MockAuthorRepository
    
    // MARK: - Initialization
    
    init() {
        mockRepository = MockAuthorRepository()
        sut = FetchAuthorsUseCase(repository: mockRepository)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenAuthorsExistWhenExecuteThenReturnsAuthors() async throws {
        // GIVEN
        let expectedAuthors = Author.previewData
        await mockRepository.setMockAuthorsResult(expectedAuthors)
        
        // WHEN
        let authors = try await sut.execute()
        
        // THEN
        #expect(authors == expectedAuthors)
    }
    
    @Test
    func testGivenNoAuthorsWhenExecuteThenReturnsEmptyList() async throws {
        // GIVEN
        await mockRepository.setMockAuthorsResult([])
        
        // WHEN
        let authors = try await sut.execute()
        
        // THEN
        #expect(authors.isEmpty)
    }
    
    @Test
    func testGivenRepositoryThrowsErrorWhenExecuteThenThrowsError() async {
        // GIVEN
        await mockRepository.setMockError(.custom(message: "Repository error"))
        
        // WHEN / THEN
        await #expect(throws: APIError.custom(message: "Repository error")) {
            let _ = try await sut.execute()
        }
    }
}
