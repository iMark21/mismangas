//
//  AuthorListViewModel.swift
//  mismangas
//
//  Created by Michel Marques on 6/1/25.
//

import Foundation

@Observable
final class SelectableListViewModel<T: Searchable> {

    enum ViewState {
        case loading
        case content(items: [T])
        case error(message: String, items: [T])
    }

    // MARK: - Public properties
    
    var state: ViewState = .loading
    var title: String
    var searchQuery: String = ""
    var selectedItem: T?
    var onSelectItem: ((T) -> Void)?

    // MARK: - Private properties
    
    private let fetchItemsUseCase: any FetchItemsUseCaseProtocol
    private var allItems: [T] = []
    
    // MARK: - Init
    
    init(title: String,
         fetchItemsUseCase: any FetchItemsUseCaseProtocol,
         selectedItem: T? = nil,
         onSelectItem: ((T) -> Void)? = nil) {
        self.title = title
        self.fetchItemsUseCase = fetchItemsUseCase
        self.selectedItem = selectedItem
        self.onSelectItem = onSelectItem
    }
    
    // MARK: - Functions

    @MainActor
    func fetch() {
        guard case .loading = state else { return }
        Task {
            do {
                let items = try await fetchItemsUseCase.execute(query: nil, page: nil, perPage: nil) as? [T] ?? []
                allItems = items
                state = .content(items: items)
            } catch {
                state = .error(message: "Error: \(error.localizedDescription)", items: [])
            }
        }
    }

    @MainActor
    func applyQuery() {
        let filteredItems: [T]
        
        if searchQuery.isEmpty {
            filteredItems = allItems
        } else {
            filteredItems = allItems.filter { item in
                item.matches(query: searchQuery)
            }
        }
        
        state = .content(items: filteredItems)
    }
    
    @MainActor
    func selectItem(_ item: T) {
        selectedItem = item
        onSelectItem?(item)
    }
}
