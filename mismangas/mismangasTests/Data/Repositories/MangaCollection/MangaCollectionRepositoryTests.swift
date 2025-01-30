//
//  MangaCollectionRepositoryTests.swift
//  mismangasTests
//
//  Created by Michel Marques on 29/01/25.
//

import Testing
@testable import mismangas

@Suite
struct MangaCollectionRepositoryTests {
    
    // MARK: - Properties
    
    private var sut: MangaCollectionRepository
    private var mockAPIClient: MockAPIClient
    private var mockKeyChainItemManager: MockKeyChainItemManager
    
    // MARK: - Initialization
    
    init() {
        mockAPIClient = MockAPIClient()
        mockKeyChainItemManager = MockKeyChainItemManager()
        sut = MangaCollectionRepository(apiClient: mockAPIClient, tokenStorage: mockKeyChainItemManager)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenValidTokenWhenSyncMangaToCloudThenPerformsSuccessfully() async throws {
        // GIVEN
        let mangaCollection = MangaCollection(mangaID: Manga.preview.id,
                                       mangaName: Manga.preview.title,
                                       completeCollection: false,
                                       volumesOwned: [1,2,3],
                                       readingVolume: 1,
                                       totalVolumes: 4)
        
        let token = "validToken123"
        
        try await mockKeyChainItemManager.save(item: token)
        
        await mockAPIClient.setMockResult(Void())
        
        // WHEN
        try await sut.syncMangaToCloud(mangaCollection)
        
        // THEN
        await #expect(mockAPIClient.mockResult as? Void != nil)
    }
    
    @Test
    func testGivenNoTokenWhenSyncMangaToCloudThenThrowsUnauthorizedError() async {
        // GIVEN
        let mangaCollection = MangaCollection(mangaID: Manga.preview.id,
                                       mangaName: Manga.preview.title,
                                       completeCollection: false,
                                       volumesOwned: [1,2,3],
                                       readingVolume: 1,
                                       totalVolumes: 4)
        
        try? await mockKeyChainItemManager.delete()
        
        // WHEN / THEN
        await #expect(throws: APIError.unauthorized) {
            try await sut.syncMangaToCloud(mangaCollection)
        }
    }
    
    @Test
    func testGivenNoTokenWhenFetchingUserCloudCollectionThenThrowsUnauthorizedError() async {
        // GIVEN
        try? await mockKeyChainItemManager.delete()
        
        // WHEN / THEN
        await #expect(throws: APIError.unauthorized) {
            let _ = try await sut.fetchUserCloudCollection()
        }
    }
    
    @Test
    func testGivenValidTokenWhenDeleteMangaFromCloudThenPerformsSuccessfully() async throws {
        // GIVEN
        let mangaID = 123
        let token = "validToken123"
        
        try await mockKeyChainItemManager.save(item: token)
        
        await mockAPIClient.setMockResult(Void())
        
        // WHEN
        try await sut.deleteMangaFromCloud(withID: mangaID)
        
        // THEN
        await #expect(mockAPIClient.mockResult as? Void != nil)
    }
    
    @Test
    func testGivenNoTokenWhenDeleteMangaFromCloudThenThrowsUnauthorizedError() async {
        // GIVEN
        let mangaID = 123
        
        try? await mockKeyChainItemManager.delete()
        
        // WHEN / THEN
        await #expect(throws: APIError.unauthorized) {
            try await sut.deleteMangaFromCloud(withID: mangaID)
        }
    }
}
