//
//  MangaCollectionManagerSpy.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//


import Foundation
@testable import mismangas

@MainActor
final class MangaCollectionManagerSpy: MangaCollectionManagerProtocol {
    
    // MARK: - Mock Properties
    
    var mockSyncResult: Void?
    var mockSyncError: APIError?
    
    var mockFetchCollectionResult: MangaCollectionDB?
    var mockFetchCollectionStateResult: (completeCollection: Bool, volumesOwned: [Int], readingVolume: Int?)?
    var mockFetchAllCollectionsResult: [MangaCollectionDB]?
    
    var mockSaveToMyCollectionError: APIError?
    var mockRemoveFromCollectionError: APIError?
    var mockClearLocalDatabaseError: APIError?
    
    var mockUpdateVolumesResult: (updatedVolumes: [Int], updatedReadingVolume: Int?)?
    
    // MARK: - Mock Setters
    
    func setMockSyncResult(_ result: Void?) {
        mockSyncResult = result
    }
    
    func setMockSyncError(_ error: APIError?) {
        mockSyncError = error
    }
    
    func setMockFetchCollectionResult(_ result: MangaCollectionDB?) {
        mockFetchCollectionResult = result
    }
    
    func setMockFetchCollectionStateResult(_ result: (completeCollection: Bool, volumesOwned: [Int], readingVolume: Int?)) {
        mockFetchCollectionStateResult = result
    }
    
    func setMockFetchAllCollectionsResult(_ result: [MangaCollectionDB]?) {
        mockFetchAllCollectionsResult = result
    }
    
    func setMockSaveToMyCollectionError(_ error: APIError?) {
        mockSaveToMyCollectionError = error
    }
    
    func setMockRemoveFromCollectionError(_ error: APIError?) {
        mockRemoveFromCollectionError = error
    }
    
    func setMockClearLocalDatabaseError(_ error: APIError?) {
        mockClearLocalDatabaseError = error
    }
    
    func setMockUpdateVolumesResult(_ result: (updatedVolumes: [Int], updatedReadingVolume: Int?)?) {
        mockUpdateVolumesResult = result
    }
    
    // MARK: - Protocol Methods
    
    func syncWithCloud(using context: ModelContextProtocol) async throws {
        if let error = mockSyncError {
            throw error
        }
        if let result = mockSyncResult {
            return result
        }
    }
    
    func fetchCollection(for mangaID: Int, using context: ModelContextProtocol) -> MangaCollectionDB? {
        return mockFetchCollectionResult
    }
    
    func fetchCollectionState(for mangaID: Int, using context: ModelContextProtocol) -> (completeCollection: Bool, volumesOwned: [Int], readingVolume: Int?) {
        return mockFetchCollectionStateResult ?? (false, [], nil)
    }
    
    func fetchAllCollections(using context: ModelContextProtocol) -> [MangaCollectionDB] {
        return mockFetchAllCollectionsResult ?? []
    }
    
    func saveToMyCollection(manga: Manga, completeCollection: Bool, volumesOwned: [Int], readingVolume: Int?, using context: ModelContextProtocol) async throws {
        if let error = mockSaveToMyCollectionError {
            throw error
        }
    }
    
    func removeFromCollection(mangaID: Int, using context: ModelContextProtocol) async throws {
        if let error = mockRemoveFromCollectionError {
            throw error
        }
    }
    
    func clearLocalDatabase(using context: ModelContextProtocol) throws {
        if let error = mockClearLocalDatabaseError {
            throw error
        }
    }
    
    func updateVolumes(newCount: Int, currentReadingVolume: Int?) -> (updatedVolumes: [Int], updatedReadingVolume: Int?) {
        return mockUpdateVolumesResult ?? ([], nil)
    }
}
