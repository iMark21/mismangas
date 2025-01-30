//
//  MyCollectionListViewModelTests.swift
//  mismangasTests
//
//  Created by Michel Marques on 30/1/25.
//

import Testing
@testable import mismangas

@Suite @MainActor
struct MyCollectionListViewModelTests {
    
    // MARK: - Properties
    
    private var sut: MyCollectionListViewModel
    private var mockMangaCollectionManager: MangaCollectionManagerSpy
    private var logoutUseCaseSpy: LogoutUserUseCaseSpy
    private var mockModelContext: ModelContextProtocol
    
    // MARK: - Initialization
    
    init() {
        mockMangaCollectionManager = MangaCollectionManagerSpy()
        logoutUseCaseSpy = LogoutUserUseCaseSpy()
        mockModelContext = MockModelContext()
        
        sut = MyCollectionListViewModel(
            syncManager: mockMangaCollectionManager,
            logoutUseCase: logoutUseCaseSpy
        )
    }
    
    // MARK: - Tests
    
    @Test
    func testSyncCollectionsWhenSyncIsSuccessful() async throws {
        // GIVEN
        mockMangaCollectionManager.setMockSyncResult(())
        
        // WHEN
        await sut.syncCollections(using: mockModelContext)
        
        // THEN
        #expect(sut.isSyncing == false)
    }
    
    @Test
    func testSyncCollectionsWhenSyncFails() async throws {
        // GIVEN
        mockMangaCollectionManager.setMockSyncError(APIError.custom(message: "Sync failed"))
        
        // WHEN
        await sut.syncCollections(using: mockModelContext)
        
        // THEN
        #expect(sut.isSyncing == false)
    }
    
    @Test
    func testDeleteCollectionWhenDeletionIsSuccessful() async throws {
        // GIVEN
        let mangaID = 1
        mockMangaCollectionManager.setMockSyncResult(())
        
        // WHEN
        await sut.deleteCollection(withID: mangaID, using: mockModelContext)
        
        // THEN
        #expect(sut.isSyncing == false)
    }
    
    @Test
    func testDeleteCollectionWhenDeletionFails() async throws {
        // GIVEN
        let mangaID = 1
        mockMangaCollectionManager.setMockSyncError(APIError.custom(message: "Deletion failed"))
        
        // WHEN
        await sut.deleteCollection(withID: mangaID, using: mockModelContext)
        
        // THEN
        #expect(sut.isSyncing == false)
    }
    
    @Test
    func testAddOrUpdateMangaWhenSuccessful() async throws {
        // GIVEN
        let manga = Manga.preview
        
        mockMangaCollectionManager.setMockSyncResult(())
        
        // WHEN
        await sut.addOrUpdateManga(manga, completeCollection: true, volumesOwned: [1, 2], readingVolume: 1, using: mockModelContext)
        
        // THEN
        #expect(sut.isSyncing == false)
    }
    
    @Test
    func testAddOrUpdateMangaWhenFailureOccurs() async throws {
        // GIVEN
        let manga = Manga.preview
        
        mockMangaCollectionManager.setMockSyncError(APIError.custom(message: "Failed to add manga"))
        
        // WHEN
        await sut.addOrUpdateManga(manga, completeCollection: true, volumesOwned: [1, 2], readingVolume: 1, using: mockModelContext)
        
        // THEN
        #expect(sut.isSyncing == false)
    }
    
    @Test
    func testLogoutWhenSuccessful() async throws {
        // GIVEN
        await logoutUseCaseSpy.setMockLogoutError(nil)
        
        // WHEN
        sut.showMessageLogout()
        
        // THEN
        #expect(sut.showLogoutConfirmation == true)
    }
    
    @Test
    func testLogoutWhenFailureOccurs() async throws {
        // GIVEN
        await logoutUseCaseSpy.setMockLogoutError(.custom(message: "Logout failed"))
        
        // WHEN
        sut.showMessageLogout()

        // THEN
        #expect(sut.showLogoutConfirmation == true) 
    }
}
