//
//  MangaListViewModel.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

@Observable
final class MangaListViewModel {

    enum ViewState {
        case loading
        case content(items: [Manga], isLoadingMore: Bool)
        case error(message: String, items: [Manga])
    }

    // MARK: - Public properties
    var state: ViewState = .loading

    // MARK: - Private
    private let fetchMangasUseCase: FetchMangasUseCaseProtocol
    private let paginator: Paginator<Manga, MangaFilter>
    private var currentFilter: MangaFilter

    init(fetchMangasUseCase: FetchMangasUseCaseProtocol = FetchMangasUseCase(),
         initialFilter: MangaFilter = .empty) {
        self.fetchMangasUseCase = fetchMangasUseCase
        self.currentFilter = initialFilter

        paginator = Paginator(perPage: 10) { filter, page, perPage in
            return try await fetchMangasUseCase.execute(
                filter: filter,
                page: page,
                perPage: perPage
            )
        }
    }

    @MainActor
    func fetchInitialPage() {
        guard case .loading = state else { return }
        Task {
            do {
                let newItems = try await paginator.loadNextPage(using: currentFilter)
                state = .content(items: newItems, isLoadingMore: false)
            } catch {
                state = .error(message: "Error: \(error.localizedDescription)", items: [])
            }
        }
    }

    @MainActor
    func fetchNextPage() {
        guard case let .content(items, isLoadingMore) = state, !isLoadingMore else { return }

        state = .content(items: items, isLoadingMore: true)
        Task {
            do {
                let newItems = try await paginator.loadNextPage(using: currentFilter)
                state = .content(items: newItems, isLoadingMore: false)
            } catch {
                state = .error(message: "Error: \(error.localizedDescription)", items: items)
            }
        }
    }

    @MainActor
    func refresh() {
        state = .loading
        Task {
            do {
                await paginator.reset()
                let newItems = try await paginator.loadNextPage(using: currentFilter)
                state = .content(items: newItems, isLoadingMore: false)
            } catch {
                state = .error(message: "Refresh failed: \(error.localizedDescription)", items: [])
            }
        }
    }

    /// Change the filter and refresh the list if the new filter is different from the current one.
    @MainActor
    func applyFilter(_ newFilter: MangaFilter) {
        guard newFilter != currentFilter else { return }
        currentFilter = newFilter
        refresh()
    }
}
