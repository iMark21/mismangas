//
//  MyCollectionListView.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//

import SwiftUI
import SwiftData

struct MyCollectionListView: View {
    // MARK: - Environment
    @Environment(\.modelContext) private var modelContext
    @State var viewModel: MyCollectionListViewModel = MyCollectionListViewModel()

    // MARK: - Properties
    @Query private var collections: [MangaCollectionDB]
    @Binding var isUserAuthenticated: Bool
    @State private var selectedMangaID: Int?

    var body: some View {
        NavigationStack {
            ZStack {
                collectionList
                    .navigationTitle("My Collection")
                    .platformToolbar(
                        logoutAction: {
                            viewModel.showLogoutConfirmation = true
                        },
                        isSyncing: viewModel.isSyncing,
                        syncAction: {
                            syncData()
                        }
                    )
            }
            .alert("Are you sure you want to log out?", isPresented: $viewModel.showLogoutConfirmation) {
                Button("Log Out", role: .destructive) {
                    viewModel.logout()
                    isUserAuthenticated = false
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }

    private var collectionList: some View {
        List {
            ForEach(collections) { collection in
                NavigationLink(
                    destination: MangaDetailView(viewModel: MangaDetailViewModel(mangaID: collection.mangaID))
                ) {
                    MyCollectionRowView(mangaName: collection.mangaName,
                                        completeCollection: collection.completeCollection)
                }
            }
            .onDelete { offsets in
                Task {
                    for offset in offsets {
                        let mangaID = collections[offset].mangaID
                        await viewModel.deleteCollection(withID: mangaID, using: modelContext)
                    }
                }
            }
        }.refreshable {
            syncData()
        }
    }

    private var logoutButton: some View {
        Button(role: .destructive) {
            viewModel.showLogoutConfirmation = true
        } label: {
            Label("Logout", systemImage: "power")
        }
    }

    private var syncButton: some View {
        Button(action: {
            syncData()
        }) {
            Label("Sync", systemImage: "arrow.triangle.2.circlepath")
        }
        .disabled(viewModel.isSyncing)
    }

    private func syncData() {
        Task {
            await viewModel.syncCollections(using: modelContext)
        }
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var isUserAuthenticated = true

    MyCollectionListView(isUserAuthenticated: $isUserAuthenticated)
}
