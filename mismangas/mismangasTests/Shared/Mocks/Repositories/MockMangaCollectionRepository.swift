//
//  MockMangaCollectionRepository.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//


import Foundation
@testable import mismangas

actor MockMangaCollectionRepository: MangaCollectionRepositoryProtocol {
    
    var mockSyncResult: Void?
    var mockDeleteResult: Void?
    var mockFetchResult: [MangaCollection]?
    
    // MARK: - Mock methods
    
    func setMockSyncResult(_ result: Void?) async {
        mockSyncResult = result
    }
    
    func setMockDeleteResult(_ result: Void?) async {
        mockDeleteResult = result
    }
    
    func setMockFetchResult(_ result: [MangaCollection]?) async {
        mockFetchResult = result
    }
    
    // MARK: - Protocol methods
    
    func syncMangaToCloud(_ manga: MangaCollection) async throws {
        if let result = mockSyncResult {
            return result
        }
        throw APIError.custom(message: "Sync failed")
    }
    
    func deleteMangaFromCloud(withID mangaID: Int) async throws {
        if let result = mockDeleteResult {
            return result
        }
        throw APIError.custom(message: "Delete failed")
    }
    
    func fetchUserCloudCollection() async throws -> [MangaCollection] {
        if let result = mockFetchResult {
            return result
        }
        throw APIError.custom(message: "Fetch failed")
    }
}
