//
//  MangaListPadView.swift
//  mismangas
//
//  Created by Michel Marques on 18/1/25.
//

import SwiftUI

struct MangaListPadView: View {
    // MARK: - Properties
    
    @State var viewModel = MangaListViewModel()
    @State private var selectedManga: Manga? = nil
    @State private var showFilterView = false

    // MARK: - Body
    
    var body: some View {
        NavigationSplitView {
            MangaListContentView(viewModel: viewModel) { manga in
                Button {
                    selectedManga = manga
                } label: {
                    MangaRowView(manga: manga)
                }
                .listRowBackground(
                    selectedManga?.id == manga.id ? Color.accentColor.opacity(0.5) : Color.clear
                )
            }
            .navigationTitle("Mangas")
            .navigationBarTitleDisplayMode(.inline)
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
        } detail: {
            if let manga = selectedManga {
                MangaDetailPadView(viewModel: .init(manga: manga))
                    .id(selectedManga?.id)
            } else {
                Text("Select a manga to see details")
                    .foregroundColor(.secondary)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    MangaListPadView(viewModel: .preview)
}
