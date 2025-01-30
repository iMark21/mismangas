//
//  MyCollectionViewModel.swift
//  mismangas
//
//  Created by Michel Marques on 28/1/25.
//


import SwiftData

@Observable
final class MyCollectionManagementViewModel {
    var tempCompleteCollection: Bool = false
    var tempVolumesOwned: [Int] = []
    var tempReadingVolume: Int? = nil

    let manga: Manga?
    
    @MainActor
    private let collectionManager: MangaCollectionManagerProtocol

    @MainActor
    init(manga: Manga?, collectionManager: MangaCollectionManagerProtocol = MangaCollectionManager()) {
        self.manga = manga
        self.collectionManager = collectionManager
    }

    @MainActor
    func loadCollection(using modelContext: ModelContext) {
        guard let manga else { return }
        let state = collectionManager.fetchCollectionState(for: manga.id, using: modelContext)
        tempCompleteCollection = state.completeCollection
        tempVolumesOwned = state.volumesOwned
        tempReadingVolume = state.readingVolume
    }

    func toggleCompleteCollection() {
        tempCompleteCollection.toggle()
        
        if tempCompleteCollection, let totalVolumes = manga?.volumes {
            tempVolumesOwned = Array(1...totalVolumes)
        } else {
            tempVolumesOwned = []
        }

        tempReadingVolume = nil
    }

    @MainActor
    func updateVolumes() {
        guard let totalVolumes = manga?.volumes else { return }

        // Adjust the volumes owned based on the current count
        tempVolumesOwned = tempVolumesOwned.count > 0 ? Array(1...min(tempVolumesOwned.count, totalVolumes)) : []

        // Determine if the collection is complete
        tempCompleteCollection = tempVolumesOwned.count == totalVolumes

        // Adjust the reading volume if needed
        if let currentReadingVolume = tempReadingVolume,
           !tempVolumesOwned.contains(currentReadingVolume) {
            tempReadingVolume = nil
        }
    }
    
    @MainActor
    func saveChanges(using modelContext: ModelContext) async throws {
        guard let manga else { return }
        try await collectionManager.saveToMyCollection(
            manga: manga,
            completeCollection: tempCompleteCollection,
            volumesOwned: tempVolumesOwned,
            readingVolume: tempReadingVolume,
            using: modelContext
        )
    }
}
