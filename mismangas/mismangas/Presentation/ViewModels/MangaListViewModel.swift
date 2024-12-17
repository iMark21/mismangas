//
//  MangaListViewModel.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

@Observable
final class MangaListViewModel {
    
    // View State
    enum ViewState {
        case loading
        case content(items: [Manga], isLoadingMore: Bool)
        case error(message: String, items: [Manga])
    }

    var state: ViewState = .loading
    
    private let fetchMangasUseCase: FetchMangasUseCaseProtocol
    private let paginator: Paginator<Manga>

    init(fetchMangasUseCase: FetchMangasUseCaseProtocol = FetchMangasUseCase()) {
        self.fetchMangasUseCase = fetchMangasUseCase
        self.paginator = Paginator(perPage: 10) { page, perPage in
            try await fetchMangasUseCase.execute(page: page, perPage: perPage)
        }
    }
    
    @MainActor func fetchInitialPage() {
        guard case .loading = state else { return }
        Task {
            do {
                let newItems = try await paginator.loadNextPage()
                state = .content(items: newItems, isLoadingMore: false)
            } catch {
                state = .error(message: "Error: \(error.localizedDescription)", items: [])
            }
        }
    }
    
    @MainActor func fetchNextPage() {
        guard case let .content(items, isLoadingMore) = state, !isLoadingMore else { return }
        
        state = .content(items: items, isLoadingMore: true)
        
        Task {
            do {
                let newItems = try await paginator.loadNextPage()
                state = .content(items: newItems, isLoadingMore: false)
            } catch {
                state = .error(message: "Error: \(error.localizedDescription)", items: items)
            }
        }
    }
    
    @MainActor func refresh() {
        state = .loading
        Task {
            await paginator.reset()
            do {
                let newItems = try await paginator.loadNextPage()
                state = .content(items: newItems, isLoadingMore: false)
            } catch {
                state = .error(message: "Error: \(error.localizedDescription)", items: [])
            }
        }
    }
}
