import Foundation
@testable import mismangas

final class MockMangaCollectionRepository: MangaCollectionRepositoryProtocol {
    
    var mockSyncResult: Void?
    var mockDeleteResult: Void?
    var mockFetchResult: [MangaCollection]?
    
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