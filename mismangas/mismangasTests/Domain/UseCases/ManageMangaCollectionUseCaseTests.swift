//
//  ManageMangaCollectionUseCaseTests.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite
struct ManageMangaCollectionUseCaseTests {
    
    // MARK: - Properties
    
    private var sut: ManageMangaCollectionUseCase
    private var mockRepository: MockMangaCollectionRepository
    
    // MARK: - Initialization
    
    init() {
        mockRepository = MockMangaCollectionRepository()
        sut = ManageMangaCollectionUseCase(repository: mockRepository)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenValidMangaWhenAddOrUpdateMangaThenSyncsWithCloud() async throws {
        // GIVEN
        let mangaCollection = MangaCollection(mangaID: Manga.preview.id,
                                       mangaName: Manga.preview.title,
                                       completeCollection: false,
                                       volumesOwned: [1,2,3],
                                       readingVolume: 1,
                                       totalVolumes: 4)
        
        await mockRepository.setMockSyncResult(())
        
        // WHEN
        try await sut.addOrUpdateManga(mangaCollection)
        
        // THEN
        await #expect(mockRepository.mockSyncResult != nil)
    }
    
    @Test
    func testGivenSyncFailsWhenAddOrUpdateMangaThenThrowsError() async {
        // GIVEN
        let mangaCollection = MangaCollection(mangaID: Manga.preview.id,
                                       mangaName: Manga.preview.title,
                                       completeCollection: false,
                                       volumesOwned: [1,2,3],
                                       readingVolume: 1,
                                       totalVolumes: 4)
        
        await mockRepository.setMockSyncResult(nil)
        
        // WHEN / THEN
        await #expect(throws: APIError.custom(message: "Sync failed")) {
            try await sut.addOrUpdateManga(mangaCollection)
        }
    }
    
    @Test
    func testGivenValidMangaIDWhenDeleteMangaThenDeletesFromCloud() async throws {
        // GIVEN
        let mangaID = 1
        await mockRepository.setMockDeleteResult(())
        
        // WHEN
        try await sut.deleteManga(withID: mangaID)
        
        // THEN
        await #expect(mockRepository.mockDeleteResult != nil)
    }
    
    @Test
    func testGivenDeleteFailsWhenDeleteMangaThenThrowsError() async {
        // GIVEN
        let mangaID = 1
        await mockRepository.setMockDeleteResult(nil)
        
        // WHEN / THEN
        await #expect(throws: APIError.custom(message: "Delete failed")) {
            try await sut.deleteManga(withID: mangaID)
        }
    }
    
    @Test
    func testWhenFetchUserCloudCollectionThenReturnsCollection() async throws {
        // GIVEN
        let expectedCollection = [MangaCollection(mangaID: Manga.preview.id,
                                                  mangaName: Manga.preview.title,
                                                  completeCollection: false,
                                                  volumesOwned: [1,2,3],
                                                  readingVolume: 1,
                                                  totalVolumes: 4)]
        
        await mockRepository.setMockFetchResult(expectedCollection)
        
        // WHEN
        let collection = try await sut.fetchUserCloudCollection()
        
        // THEN
        #expect(collection == expectedCollection)
    }
    
    @Test
    func testWhenFetchUserCloudCollectionFailsThenThrowsError() async {
        // GIVEN
        await mockRepository.setMockFetchResult(nil)
        
        // WHEN / THEN
        await #expect(throws: APIError.custom(message: "Fetch failed")) {
            let _ = try await sut.fetchUserCloudCollection()
        }
    }
}
