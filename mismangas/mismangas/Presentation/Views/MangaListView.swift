//
//  MangaListView.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//


import SwiftUI

struct MangaListView: View {
    @State var viewModel = MangaListViewModel()
    @State private var showFilterView = false
    @State private var filter = MangaFilter.empty
    
    // MARK: - Body

    var body: some View {
        NavigationView {
            content
                .navigationTitle("Mangas")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Filtros") {
                            showFilterView = true
                        }
                    }
                }
        }
        .onAppear {
            viewModel.fetchInitialPage()
        }
        // If showFilterView is true, present the sheet
        .sheet(isPresented: $showFilterView, onDismiss: {
            // When the sheet is dismissed, apply the filter if it has changed
            viewModel.applyFilter(filter)
        }) {
            // Pass the filter to the MangaFilterView
            MangaFilterView(filter: $filter)
        }
    }
    
    // MARK: - Private content

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressMeView(message: "Loading Mangas...")
        case let .content(items, isLoadingMore):
            mangaListView(items: items, isLoadingMore: isLoadingMore)
        case let .error(message, items):
            ErrorView(
                message: message,
                retryAction: { viewModel.refresh() }
            ) {
                if !items.isEmpty {
                    mangaListView(items: items, isLoadingMore: false)
                }
            }
        }
    }

    private func mangaListView(items: [Manga], isLoadingMore: Bool) -> some View {
        List {
            ForEach(items, id: \.id) { manga in
                MangaRowView(manga: manga)
                    .onAppear {
                        // When the last item appears, fetch the next page
                        if items.last == manga {
                            viewModel.fetchNextPage()
                        }
                    }
            }
            if isLoadingMore {
                LoadingMoreView(message: "Loading more...")
            }
        }
        .listStyle(.plain)
        .refreshable {
            viewModel.refresh()
        }
    }
}

#Preview {
    MangaListView(viewModel: .preview)
}
