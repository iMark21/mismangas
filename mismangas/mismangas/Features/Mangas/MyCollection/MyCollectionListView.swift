//
//  CollectionListView.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//

import SwiftUI
import SwiftData

struct MyCollectionListView: View {
    @Query private var collections: [MangaCollection]
    @Environment(\.modelContext) private var modelContext

    private var collectionManager: MangaCollectionManager {
        MangaCollectionManager(modelContext: modelContext)
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(collections) { collection in
                    NavigationLink(destination: MangaDetailView(viewModel: MangaDetailViewModel(mangaID: collection.mangaID))) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(collection.mangaName)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                if collection.completeCollection {
                                    Text("Status: Complete")
                                        .font(.subheadline)
                                        .foregroundColor(.green)
                                } else {
                                    Text("Status: In Progress")
                                        .font(.subheadline)
                                        .foregroundColor(.orange)
                                }
                            }
                            Spacer()
                            Image(systemName: collection.completeCollection ? "checkmark.seal.fill" : "book.fill")
                                .foregroundColor(collection.completeCollection ? .green : .orange)
                                .font(.title3)
                        }
                        .padding(.vertical, 8)
                    }
                }
                .onDelete(perform: deleteCollection)
            }
            .navigationTitle("My Collection")
            .toolbar {
                EditButton()
            }
        }
    }

    private func deleteCollection(at offsets: IndexSet) {
        for index in offsets {
            let collection = collections[index]
             _ = collectionManager.removeFromCollection(mangaID: collection.mangaID)
        }
    }
}

// MARK: - Preview

#Preview {
    MyCollectionListView()
        .modelContainer(MangaCollectionManager.modelContainer)
}
