//
//  MangaCollectionManagerProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 24/1/25.
//

import Foundation
import SwiftData

@MainActor
protocol MangaCollectionManagerProtocol {
    // Sync Collection
    func syncWithCloud(using context: ModelContext) async throws

    // Fetch Collection
    func fetchCollection(for mangaID: Int, using context: ModelContext) -> MangaCollectionDB?
    func fetchCollectionState(for mangaID: Int, using context: ModelContext) -> (completeCollection: Bool, volumesOwned: [Int], readingVolume: Int?)
    func fetchAllCollections(using context: ModelContext) -> [MangaCollectionDB]

    // Add/Update Collection
    func saveToMyCollection(manga: Manga, completeCollection: Bool, volumesOwned: [Int], readingVolume: Int?, using context: ModelContext) async throws

    // Delete Collection
    func removeFromCollection(mangaID: Int, using context: ModelContext) async throws
    func clearLocalDatabase(using context: ModelContext) throws

    // Volume Management
    func updateVolumes(newCount: Int, currentReadingVolume: Int?) -> (updatedVolumes: [Int], updatedReadingVolume: Int?)
}
