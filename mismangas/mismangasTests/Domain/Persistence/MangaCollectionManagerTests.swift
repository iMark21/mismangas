//
//  MangaCollectionManagerTests.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite @MainActor
struct MangaCollectionManagerTests {
    
    // MARK: - Properties
    
    private var sut: MangaCollectionManager
    private var mockContext: MockModelContext
    private var mockUseCase: MockManageMangaCollectionUseCase
    
    // MARK: - Initialization
    
    init() {
        mockContext = MockModelContext()
        mockUseCase = MockManageMangaCollectionUseCase()
        sut = MangaCollectionManager(useCase: mockUseCase)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenValidMangaWhenSyncWithCloudThenPerformsSuccessfully() async throws {
        // GIVEN
        let manga = Manga.preview
        
        await mockUseCase.setMockFetchUserCloudCollectionResult(
            [MangaCollection(mangaID: manga.id,
                             mangaName: manga.title,
                             completeCollection: false,
                             volumesOwned: [1,2,3],
                             readingVolume: 1,
                             totalVolumes: 4)])
        
        await mockUseCase.setMockAddOrUpdateMangaResult(())
        
        // WHEN
        try await sut.syncWithCloud(using: mockContext)
        
        // THEN
        await #expect(mockUseCase.mockAddOrUpdateMangaResult != nil)
    }
    
    @Test
    func testGivenNoMangaInCloudWhenSyncWithCloudThenSyncToLocal() async throws {
        // GIVEN
        let manga = Manga.preview
        
        mockContext.insert(MangaCollectionDB(manga: manga, completeCollection: false, volumesOwned: [1,2,3], readingVolume: 1))
        
        // Simulate an empty cloud collection
        await mockUseCase.setMockFetchUserCloudCollectionResult([])

        // Simulate a successful add/update manga operation
        await mockUseCase.setMockAddOrUpdateMangaResult(())
        
        #expect(mockContext.insertedObjects.count == 1)

        // WHEN
        try await sut.syncWithCloud(using: mockContext)
        
        // THEN
        #expect(mockContext.insertedObjects.count == 0)
    }
    
    @Test
    func testGivenValidTokenWhenRemoveFromCollectionThenDeletesFromLocalAndCloud() async throws {
        // GIVEN
        let manga = Manga.preview
        let mangaCollectionDB = MangaCollectionDB(manga: manga,
                                                  completeCollection: false,
                                                  volumesOwned: [1,2,3],
                                                  readingVolume: 1)
        
        await mockUseCase.setMockDeleteMangaResult(())
                
        mockContext.insert(mangaCollectionDB)
        
        // WHEN
        try await sut.removeFromCollection(mangaID: manga.id, using: mockContext)
            
        // THEN
        #expect(mockContext.deletedObjects.count == 1)
        await #expect(mockUseCase.mockDeleteMangaResult != nil)
    }
    
    @Test
    func testGivenMangaAlreadyInCollectionWhenSaveToMyCollectionThenUpdatesLocalAndSyncsWithCloud() async throws {
        // GIVEN
        let manga = Manga.preview
        
        /// Simulate the manga being already in the local collection
        let existingCollection = MangaCollectionDB(manga: manga, completeCollection: true, volumesOwned: [1], readingVolume: nil)
        mockContext.insert(existingCollection)
        
        /// Simulate the add or update operation
        await mockUseCase.setMockAddOrUpdateMangaResult(())
        
        // WHEN
        try await sut.saveToMyCollection(manga: manga, completeCollection: true, volumesOwned: [1], readingVolume: nil, using: mockContext)
        
        // THEN
        await #expect(mockUseCase.mockAddOrUpdateMangaResult != nil)
    }
}
