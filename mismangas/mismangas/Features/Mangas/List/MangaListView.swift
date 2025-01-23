//
//  MangaListView.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//


import SwiftUI

struct MangaListView: View {
    
    // MARK: - Properties

    @State var viewModel = MangaListViewModel()
    @State private var showFilterView = false

    // MARK: - Body

    var body: some View {
        NavigationStack {
            MangaListContentView(viewModel: viewModel) { manga in
                NavigationLink(destination: MangaDetailView(viewModel: .init(manga: manga))) {
                    MangaRowView(manga: manga)
                }
            }
            .navigationTitle(viewModel.filterViewModel.filter.query.isEmpty ?
                             "Mangas" : viewModel.filterViewModel.filter.query)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showFilterView = true
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.title2)
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchInitialPage()
            }
        }
        .sheet(isPresented: $showFilterView, onDismiss: {
            Task {
                await viewModel.refresh()
            }
        }) {
            MangaFilterView(viewModel: viewModel.filterViewModel)
        }
    }
}

// MARK: - Preview

#Preview {
    MangaListView(viewModel: .preview)
}
