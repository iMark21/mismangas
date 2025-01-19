//
//  MangaCollectionManager.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//

import Foundation
import SwiftData

final class MangaCollectionManager {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    // MARK: - Fetch Operations

    /// Fetch collection for a specific manga
    func fetchCollection(for mangaID: Int) -> MangaCollection? {
        let descriptor = FetchDescriptor<MangaCollection>(predicate: #Predicate { $0.mangaID == mangaID })
        return try? modelContext.fetch(descriptor).first
    }

    /// Fetch collection state for a manga
    func fetchCollectionState(for mangaID: Int) -> (completeCollection: Bool, volumesOwned: [Int], readingVolume: Int?) {
        if let collection = fetchCollection(for: mangaID) {
            return (collection.completeCollection, collection.volumesOwned, collection.readingVolume)
        }
        return (false, [], nil)
    }

    // MARK: - Add/Update Operations

    /// Add manga to the collection or update if it already exists
    func saveToMyCollection(manga: Manga, completeCollection: Bool, volumesOwned: [Int], readingVolume: Int?) {
        if let existing = fetchCollection(for: manga.id) {
            existing.completeCollection = completeCollection
            existing.volumesOwned = volumesOwned
            existing.readingVolume = readingVolume
        } else {
            let newCollection = MangaCollection(
                manga: manga,
                completeCollection: completeCollection,
                volumesOwned: volumesOwned,
                readingVolume: readingVolume
            )
            modelContext.insert(newCollection)
        }
        try? modelContext.save()
    }


    // MARK: - Delete Operations

    /// Remove manga from collection and reset state
    func removeFromCollection(mangaID: Int)  {
        if let collection = fetchCollection(for: mangaID) {
            modelContext.delete(collection)
            try? modelContext.save()
        }
    }

    // MARK: - Volume Management

    /// Update the owned volumes and adjust the reading volume if necessary
    func updateVolumes(newCount: Int, currentReadingVolume: Int?) -> (updatedVolumes: [Int], updatedReadingVolume: Int?) {
        let updatedVolumes = newCount == 0 ? [] : Array(1...newCount)
        let updatedReadingVolume = (currentReadingVolume ?? 0) > newCount ? nil : currentReadingVolume
        return (updatedVolumes, updatedReadingVolume)
    }
}
