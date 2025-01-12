//
//  AuthorListViewModel.swift
//  mismangas
//
//  Created by Michel Marques on 6/1/25.
//

import Foundation

@Observable
final class AuthorListViewModel {

    enum ViewState {
        case loading
        case content(items: [Author])
        case error(message: String, items: [Author])
    }

    // MARK: - Public properties
    
    var state: ViewState = .loading
    
    // SEARCH ENGINE
    var searchQuery: String = ""
    var selectedAuthor: String?
    var onSelectAuthor: ((Author) -> Void)?

    // MARK: - Private properties
    
    private let fetchAuthorsUseCase: FetchAuthorsUseCaseProtocol
    private var currentFilter: AuthorFilter
    private var allAuthors: [Author] = []
    
    
    // MARK: - Init
    
    init(fetchAuthorsUseCase: FetchAuthorsUseCaseProtocol = FetchAuthorsUseCase(),
         initialFilter: AuthorFilter = .empty,
         selectedAuthor: String? = nil,
         onSelectAuthor: ((Author) -> Void)? = nil) {
        self.fetchAuthorsUseCase = fetchAuthorsUseCase
        self.currentFilter = initialFilter
        self.selectedAuthor = selectedAuthor
        self.onSelectAuthor = onSelectAuthor
    }
    
    // MARK: - Functions

    @MainActor
    func fetch() {
        guard case .loading = state else { return }
        Task {
            do {
                let authors = try await fetchAuthorsUseCase.execute(query: nil, page: nil, perPage: nil)
                allAuthors = authors
                state = .content(items: authors)
            } catch {
                state = .error(message: "Error: \(error.localizedDescription)", items: [])
            }
        }
    }

    @MainActor
    func applyQuery() {
        let filteredAuthors: [Author]
        
        if searchQuery.isEmpty {
            filteredAuthors = allAuthors
        } else {
            filteredAuthors = allAuthors.filter { author in
                author.fullName.lowercased().contains(searchQuery.lowercased())
            }
        }
        
        state = .content(items: filteredAuthors)
    }
    
    @MainActor
    func selectAuthor(_ author: Author) {
        selectedAuthor = author.fullName
        onSelectAuthor?(author)
    }
}
