//
//  Paginator.swift
//  mismangas
//
//  Created by Michel Marques on 17/12/24.
//

actor Paginator<T: Sendable, F: FilterProtocol & Sendable> {
    typealias FetchPage = @Sendable (_ filter: F, _ page: Int, _ perPage: Int) async throws -> [T]
    
    private var items: [T] = []
    private var currentPage: Int = 0
    private var hasMorePages: Bool = true
    private let perPage: Int
    private let fetchPage: FetchPage
    
    init(perPage: Int, fetchPage: @escaping FetchPage) {
        self.perPage = perPage
        self.fetchPage = fetchPage
    }
    
    func loadNextPage(using filter: F) async throws -> [T] {
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
