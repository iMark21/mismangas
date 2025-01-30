import Foundation
@testable import mismangas

class MockManageMangaCollectionUseCase: ManageMangaCollectionUseCaseProtocol {
    
    // Properties to simulate method responses
    var mockAddOrUpdateMangaResult: Void?
    var mockDeleteMangaResult: Void?
    var mockFetchUserCloudCollectionResult: [MangaCollection]?
    var mockAddOrUpdateMangaError: Error?
    var mockDeleteMangaError: Error?
    var mockFetchUserCloudCollectionError: Error?
    
    // Simulate adding or updating a manga
    func addOrUpdateManga(_ manga: MangaCollection) async throws {
        if let error = mockAddOrUpdateMangaError {
            throw error
        }
        if let result = mockAddOrUpdateMangaResult {
            return result
        }
    }
    
    // Simulate deleting a manga
    func deleteManga(withID mangaID: Int) async throws {
        if let error = mockDeleteMangaError {
            throw error
        }
        if let result = mockDeleteMangaResult {
            return result
        }
    }
    
    // Simulate fetching user cloud collection
    func fetchUserCloudCollection() async throws -> [MangaCollection] {
        if let error = mockFetchUserCloudCollectionError {
            throw error
        }
        if let result = mockFetchUserCloudCollectionResult {
            return result
        }
        return []
    }
}