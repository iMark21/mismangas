//
//  MangaListView.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import SwiftUI

struct MangaListView: View {
    @State var viewModel = MangaListViewModel()
    @State private var selectedManga: Manga? = nil
    @State private var showFilterView = false

    var body: some View {
        Group {
            if isMac {
                macOSLayout
            } else if isSplitViewSupported {
                NavigationSplitView {
                    listContent
                } detail: {
                    detailContent
                }
            } else {
                NavigationStack {
                    listContent
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

    @ViewBuilder
    private var macOSLayout: some View {
        VStack(spacing: 0) {
            macOSToolbar
            HStack {
                listContent
                    .frame(maxWidth: 500)
                Divider()
                detailContent
                    .id(selectedManga?.id)
            }
        }
    }

    private var listContent: some View {
        MangaListContentView(viewModel: viewModel) { manga in
            if isSplitViewSupported || isMac {
                AnyView(
                    Button {
                        selectedManga = manga
                    } label: {
                        MangaRowView(manga: manga)
                    }
                    .padding(4)
                    .buttonStyle(PlatformBorderLessStyle())
                    .listRowBackground(
                        selectedManga?.id == manga.id ? Color.secondary.opacity(0.3) : Color.clear
                    )
                )
            } else {
                AnyView(
                    NavigationLink(destination: MangaDetailView(viewModel: .init(manga: manga))) {
                        MangaRowView(manga: manga)
                    }
                )
            }
        }
        .navigationTitle(viewModel.filterViewModel.filter.query.isEmpty ? "Mangas" : viewModel.filterViewModel.filter.query)
        .platformNavigationBarTitle()
        .platformToolbar(showFilterView: $showFilterView)
    }

    private var detailContent: some View {
        Group {
            if let manga = selectedManga {
                if isMac {
                    ScrollView {
                        MangaDetailView(viewModel: .init(manga: manga))
                    }
                    .padding()
                } else {
                    MangaDetailView(viewModel: .init(manga: manga))
                        .id(selectedManga?.id)
                }
            } else {
                Text("Select a manga to see details")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: isMac ? .infinity : nil, maxHeight: isMac ? .infinity : nil)
            }
        }
    }

    private var macOSToolbar: some View {
        HStack {
            Button(action: {
                showFilterView = true
            }) {
                Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
            }
            .buttonStyle(.borderless)

            Spacer()

            Button(action: {
                Task {
                    await viewModel.refresh()
                }
            }) {
                Label("Refresh", systemImage: "arrow.clockwise")
            }
            .buttonStyle(.borderless)
        }
        .padding()
        .background(.regularMaterial)
    }
}

// MARK: - Preview

#Preview {
    MangaListView(viewModel: .preview)
}
