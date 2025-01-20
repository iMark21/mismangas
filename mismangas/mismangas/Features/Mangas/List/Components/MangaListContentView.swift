//
//  MangaListContentView.swift
//  mismangas
//
//  Created by Michel Marques on 19/1/25.
//

import SwiftUI

struct MangaListContentView<RowContent: View>: View {
    // MARK: - Properties

    @State var viewModel: MangaListViewModel
    let rowContent: (Manga) -> RowContent

    // MARK: - Body

    var body: some View {
        switch viewModel.state {
        case .loading:
            ProgressMeView(message: "Loading Mangas...")

        case let .content(items, isLoadingMore):
            List {
                ForEach(items, id: \.id) { manga in
                    rowContent(manga)
                        .onAppear {
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

        case let .error(message, items):
            AlertErrorView(
                message: message,
                retryAction: { viewModel.refresh() }
            ) {
                if !items.isEmpty {
                    List {
                        ForEach(items, id: \.id) { manga in
                            rowContent(manga)
                                .onAppear {
                                    if items.last == manga {
                                        viewModel.fetchNextPage()
                                    }
                                }
                        }
                    }
                    .refreshable {
                        viewModel.refresh()
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    MangaListContentView(viewModel: .preview, rowContent: { manga in
        MangaRowView(manga: manga)
    })
}
