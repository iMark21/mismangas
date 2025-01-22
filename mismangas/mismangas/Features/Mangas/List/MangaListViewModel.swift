//
//  MangaListViewModel.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

@Observable
final class MangaListViewModel {

    // MARK: - View State
    enum ViewState {
        case loading
        case content(items: [Manga], isLoadingMore: Bool)
        case error(message: String, items: [Manga])
    }

    // MARK: - Public Properties
    var state: ViewState = .loading
    var currentFilter: MangaFilter

    // MARK: - Private Properties
    private let fetchMangasUseCase: FetchMangasUseCaseProtocol
    private let paginator: Paginator<Manga, MangaFilter>

    // MARK: - Initialization
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

    // MARK: - Public Methods
    @MainActor
    func fetchInitialPage() async {
        guard case .loading = state else { return }
        do {
            let newItems = try await paginator.loadNextPage(using: currentFilter)
            state = .content(items: newItems, isLoadingMore: false)
        } catch {
            state = .error(message: "Error: \(error.localizedDescription)", items: [])
        }
    }

    @MainActor
    func fetchNextPage() async {
        guard case let .content(items, isLoadingMore) = state, !isLoadingMore else { return }

        state = .content(items: items, isLoadingMore: true)
        do {
            let newItems = try await paginator.loadNextPage(using: currentFilter)
            state = .content(items: newItems, isLoadingMore: false)
        } catch {
            state = .error(message: "Error: \(error.localizedDescription)", items: items)
        }
    }

    @MainActor
    func refresh() async {
        state = .loading
        do {
            await paginator.reset()
            let newItems = try await paginator.loadNextPage(using: currentFilter)
            state = .content(items: newItems, isLoadingMore: false)
        } catch {
            state = .error(message: "Refresh failed: \(error.localizedDescription)", items: [])
        }
    }

    /// Change the filter and refresh the list if the new filter is different from the current one.
    @MainActor
    func applyFilter(_ newFilter: MangaFilter) async {
        guard newFilter != currentFilter else { return }
        currentFilter = newFilter
        await refresh()
    }
}
