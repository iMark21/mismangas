//
//  MangaCollectionManager.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//

import Foundation
import SwiftData

@MainActor
final class MangaCollectionManager: MangaCollectionManagerProtocol {
    private let useCase: ManageMangaCollectionUseCaseProtocol

    init(useCase: ManageMangaCollectionUseCaseProtocol = ManageMangaCollectionUseCase()) {
        self.useCase = useCase
    }

    // MARK: - Sync Operations

    func syncWithCloud(using context: ModelContext) async throws {
        let cloudCollections = try await useCase.fetchUserCloudCollection()
        let localCollections = fetchAllCollections(using: context)
        
        // Create a dictionary for quick lookups by ID
        let localDict = Dictionary(uniqueKeysWithValues: localCollections.map { ($0.mangaID, $0) })

        for cloudCollection in cloudCollections {
            if let localCollection = localDict[cloudCollection.mangaID] {
                // Update existing entry
                updateLocalCollection(localCollection, with: cloudCollection, using: context)
            } else {
                // Insert new entry
                saveToLocal(cloudCollection, using: context)
            }
        }

        // Remove entries that no longer exist in the cloud
        let cloudIDs = Set(cloudCollections.map { $0.mangaID })
        for localCollection in localCollections where !cloudIDs.contains(localCollection.mangaID) {
            context.delete(localCollection)
        }

        try context.save()
        Logger.log("Synchronization with cloud completed successfully.")
    }

    // MARK: - Fetch Operations

    func fetchCollection(for mangaID: Int, using context: ModelContext) -> MangaCollectionDB? {
        let descriptor = FetchDescriptor<MangaCollectionDB>(predicate: #Predicate { $0.mangaID == mangaID })
        return try? context.fetch(descriptor).first
    }

    func fetchCollectionState(for mangaID: Int, using context: ModelContext) -> (completeCollection: Bool, volumesOwned: [Int], readingVolume: Int?) {
        if let collection = fetchCollection(for: mangaID, using: context) {
            return (collection.completeCollection, collection.volumesOwned, collection.readingVolume)
        }
        return (false, [], nil)
    }

    func fetchAllCollections(using context: ModelContext) -> [MangaCollectionDB] {
        let descriptor = FetchDescriptor<MangaCollectionDB>()
        return (try? context.fetch(descriptor)) ?? []
    }

    // MARK: - Add/Update Operations

    func saveToMyCollection(
        manga: Manga,
        completeCollection: Bool,
        volumesOwned: [Int],
        readingVolume: Int?,
        using context: ModelContext
    ) async throws {
        if let existing = fetchCollection(for: manga.id, using: context) {
            existing.completeCollection = completeCollection
            existing.volumesOwned = volumesOwned
            existing.readingVolume = readingVolume
        } else {
            let newCollection = MangaCollectionDB(
                manga: manga,
                completeCollection: completeCollection,
                volumesOwned: volumesOwned,
                readingVolume: readingVolume
            )
            context.insert(newCollection)
        }
        try? context.save()
        try await syncMangaToCloud(MangaCollection(
            mangaID: manga.id,
            mangaName: manga.title,
            completeCollection: completeCollection,
            volumesOwned: volumesOwned,
            readingVolume: readingVolume
        ))
    }

    // MARK: - Delete Operations

    func removeFromCollection(mangaID: Int, using context: ModelContext) async throws {
        if let collection = fetchCollection(for: mangaID, using: context) {
            context.delete(collection)
            try? context.save()
        }
        try await deleteMangaFromCloud(withID: mangaID)
    }
    
    func clearLocalDatabase(using context: ModelContext) throws {
        let descriptor = FetchDescriptor<MangaCollectionDB>()
        let allCollections = try context.fetch(descriptor)
        for collection in allCollections {
            context.delete(collection)
        }
        try context.save()
    }

    // MARK: - Volume Management

    func updateVolumes(newCount: Int, currentReadingVolume: Int?) -> (updatedVolumes: [Int], updatedReadingVolume: Int?) {
        let updatedVolumes = newCount == 0 ? [] : Array(1...newCount)
        let updatedReadingVolume = (currentReadingVolume ?? 0) > newCount ? nil : currentReadingVolume
        return (updatedVolumes, updatedReadingVolume)
    }

    // MARK: - Private Methods

    private func saveToLocal(_ mangaCollection: MangaCollection, using context: ModelContext) {
        context.insert(mangaCollection.toDBModel())
        try? context.save()
    }

    private func syncMangaToCloud(_ manga: MangaCollection) async throws {
        try await useCase.addOrUpdateManga(manga)
    }

    private func deleteMangaFromCloud(withID mangaID: Int) async throws {
        try await useCase.deleteManga(withID: mangaID)
    }
    
    private func fetchUserCloudCollection() async throws -> [MangaCollection] {
        try await useCase.fetchUserCloudCollection()
    }
    
    private func updateLocalCollection(_ local: MangaCollectionDB, with cloud: MangaCollection, using context: ModelContext) {
        local.mangaName = cloud.mangaName
        local.completeCollection = cloud.completeCollection
        local.volumesOwned = cloud.volumesOwned
        local.readingVolume = cloud.readingVolume
    }
}
