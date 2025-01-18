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
        NavigationStack {
            content
                .navigationTitle("Mangas")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showFilterView = true
                        }, label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .font(.title2)
                        })
                    }
                }
        }
        .onAppear {
            viewModel.fetchInitialPage()
        }
        .sheet(isPresented: $showFilterView, onDismiss: {
            viewModel.applyFilter(filter)
        }) {
            MangaFilterView(filter: $filter)
                .presentationDetents([.medium, .large])
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
            AlertErrorView(
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
                NavigationLink(destination: MangaDetailView(viewModel: MangaDetailViewModel(manga: manga))) {
                    MangaRowView(manga: manga)
                }
                .onAppear {
                    // Fetch the next page when the last item appears
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

// MARK: - Preview

#Preview {
    MangaListView(viewModel: .preview)
}
