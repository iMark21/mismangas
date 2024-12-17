//
//  ContentView.swift
//  mismangas
//
//  Created by Michel Marques on 10/12/24.
//

import SwiftUI

struct MangaListView: View {
    @State var viewModel: MangaListViewModel
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Mangas")
        }
        .onAppear {
            viewModel.fetchInitialPage()
        }
    }
}

// MARK: - Content View

private extension MangaListView {
    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressMeView(message: "Loading Mangas ...")
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
    
    // MARK: - Subviews
    
    func mangaListView(items: [Manga], isLoadingMore: Bool) -> some View {
        List {
            ForEach(items, id: \.id) { manga in
                MangaRowView(manga: manga)
                    .listRowSeparator(.hidden)
                    .onAppear {
                        if items.last == manga {
                            viewModel.fetchNextPage()
                        }
                    }
            }
            if isLoadingMore {
                LoadingMoreView(message: "Loading more...")
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .refreshable {
            viewModel.refresh()
        }
    }
}

// MARK: - Preview

#Preview {
    MangaListView(viewModel: .preview)
}
