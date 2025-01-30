//
//  PaginatorTests.swift
//  mismangas
//
//  Created by Michel Marques on 29/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite
struct PaginatorTests {
    
    // MARK: - Properties
    
    private var sut: Paginator<Int, String>
    
    // MARK: - Initialization
    
    init() {
        sut = Paginator(perPage: 3) { filter, page, perPage in
            if page > 2 { return [] }
            return Array((1...perPage).map { (page - 1) * perPage + $0 })
        }
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenInitialStateWhenLoadingFirstPageThenReturnsCorrectItems() async throws {
        // WHEN
        let items = try await sut.loadNextPage(using: "filter")
        
        // THEN
        #expect(items == [1, 2, 3])
    }
    
    @Test
    func testGivenLoadedFirstPageWhenLoadingSecondPageThenAppendsItems() async throws {
        // GIVEN
        _ = try await sut.loadNextPage(using: "filter")
        
        // WHEN
        let items = try await sut.loadNextPage(using: "filter")
        
        // THEN
        #expect(items == [1, 2, 3, 4, 5, 6])
    }
    
    @Test
    func testGivenLastPageLoadedWhenLoadingNextThenDoesNotAppendMoreItems() async throws {
        // GIVEN
        _ = try await sut.loadNextPage(using: "filter")
        _ = try await sut.loadNextPage(using: "filter")
        
        // WHEN
        let items = try await sut.loadNextPage(using: "filter")
        
        // THEN
        #expect(items == [1, 2, 3, 4, 5, 6])
    }
    
    @Test
    func testGivenLoadedPagesWhenResettingThenPaginatorIsEmpty() async throws {
        // GIVEN
        _ = try await sut.loadNextPage(using: "filter")
        _ = try await sut.loadNextPage(using: "filter")
        
        // WHEN
        await sut.reset()
        
        // THEN
        let items = try await sut.loadNextPage(using: "filter")
        #expect(items == [1, 2, 3]) // Should restart from first page
    }
}
