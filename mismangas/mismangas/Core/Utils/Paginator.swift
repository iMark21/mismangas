//
//  Paginator.swift
//  mismangas
//
//  Created by Michel Marques on 17/12/24.
//

/// A generic paginator to handle paginated data fetching.
import Foundation

actor Paginator<T: Sendable> {
    typealias FetchPage = @Sendable (_ filter: MangaFilter, _ page: Int, _ perPage: Int) async throws -> [T]

    private var items: [T] = []
    private var currentPage: Int = 0
    private var hasMorePages: Bool = true
    private let perPage: Int
    private let fetchPage: FetchPage
    
    init(perPage: Int, fetchPage: @escaping FetchPage) {
        self.perPage = perPage
        self.fetchPage = fetchPage
    }
    
    func loadNextPage(using filter: MangaFilter) async throws -> [T] {
        guard hasMorePages else { return items }
        let nextPage = currentPage + 1
        let newItems = try await fetchPage(filter, nextPage, perPage)
        
        if newItems.count != perPage {
            hasMorePages = false
        }
        
        items += newItems
        currentPage = nextPage
        return items
    }
    
    func reset() {
        items.removeAll()
        currentPage = 0
        hasMorePages = true
    }
}
