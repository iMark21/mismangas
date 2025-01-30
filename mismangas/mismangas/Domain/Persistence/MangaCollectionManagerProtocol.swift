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
    func syncWithCloud(using context: ModelContextProtocol) async throws

    // Fetch Collection
    func fetchCollection(for mangaID: Int, using context: ModelContextProtocol) -> MangaCollectionDB?
    func fetchCollectionState(for mangaID: Int, using context: ModelContextProtocol) -> (completeCollection: Bool, volumesOwned: [Int], readingVolume: Int?)
    func fetchAllCollections(using context: ModelContextProtocol) -> [MangaCollectionDB]

    // Add/Update Collection
    func saveToMyCollection(manga: Manga, completeCollection: Bool, volumesOwned: [Int], readingVolume: Int?, using context: ModelContextProtocol) async throws

    // Delete Collection
    func removeFromCollection(mangaID: Int, using context: ModelContextProtocol) async throws
    func clearLocalDatabase(using context: ModelContextProtocol) throws

    // Volume Management
    func updateVolumes(newCount: Int, currentReadingVolume: Int?) -> (updatedVolumes: [Int], updatedReadingVolume: Int?)
}
