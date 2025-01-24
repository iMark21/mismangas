//
//  MyCollectionListView.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//

import SwiftUI
import SwiftData

struct MyCollectionListView: View {
    // MARK: - Properties
    
    @Query private var collections: [MangaCollection]
    @Environment(\.modelContext) private var modelContext

    @Binding var isUserAuthenticated: Bool
    @State private var selectedMangaID: Int? = nil

    private var collectionManager: MangaCollectionManager {
        MangaCollectionManager(modelContext: modelContext)
    }

    // MARK: - Body

    var body: some View {
        if iPad {
            // iPad layout with NavigationSplitView
            NavigationSplitView {
                List(selection: $selectedMangaID) {
                    ForEach(collections) { collection in
                        MyCollectionRowView(
                            mangaName: collection.mangaName,
                            completeCollection: collection.completeCollection
                        )
                        .tag(collection.mangaID)
                    }
                    .onDelete(perform: deleteCollection)
                }
            } detail: {
                detailView
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    logoutButton
                }
            }
        } else {
            // iPhone layout with NavigationStack and NavigationLink
            NavigationStack {
                List {
                    ForEach(collections) { collection in
                        NavigationLink(
                            destination: MangaDetailView(
                                viewModel: MangaDetailViewModel(mangaID: collection.mangaID)
                            )
                        ) {
                            MyCollectionRowView(
                                mangaName: collection.mangaName,
                                completeCollection: collection.completeCollection
                            )
                        }
                    }
                    .onDelete(perform: deleteCollection)
                }
                .navigationTitle("My Collection")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        logoutButton
                    }
                }
            }
        }
    }

    // MARK: - Logout Button

    private var logoutButton: some View {
        Button(role: .destructive) {
            logout()
        } label: {
            Label("Log Out", systemImage: "arrow.backward.square.fill")
        }
    }

    private func logout() {
        do {
            try KeyChainTokenStorage().delete()
            isUserAuthenticated = false 
        } catch {
            print("Failed to log out: \(error.localizedDescription)")
        }
    }

    // MARK: - Detail View

    private var detailView: some View {
        Group {
            if let selectedMangaID = selectedMangaID,
               let collection = collections.first(where: { $0.mangaID == selectedMangaID }) {
                MangaDetailPadView(viewModel: MangaDetailViewModel(mangaID: collection.mangaID))
                    .id(selectedMangaID)
            } else {
                Text("Select a manga from your collection")
                    .foregroundColor(.secondary)
                    .font(.title2)
            }
        }
    }

    // MARK: - Actions

    private func deleteCollection(at offsets: IndexSet) {
        for index in offsets {
            let collection = collections[index]
            collectionManager.removeFromCollection(mangaID: collection.mangaID)
        }
    }
}

// MARK: - Preview

#Preview {
    MyCollectionListView(isUserAuthenticated: .constant(true))
        .modelContainer(MangaCollectionManager.modelContainer)
}
