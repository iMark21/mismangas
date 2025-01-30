//
//  MyCollectionManagementViewModelTests.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite @MainActor
struct MyCollectionManagementViewModelTests {
    
    // MARK: - Properties
    
    private var sut: MyCollectionManagementViewModel
    private var mockCollectionManager: MangaCollectionManagerSpy
    private var mockModelContext: ModelContextProtocol
    
    // MARK: - Initialization
    
    init() {
        mockCollectionManager = MangaCollectionManagerSpy()
        mockModelContext = MockModelContext()
        sut = MyCollectionManagementViewModel(manga: Manga.preview, collectionManager: mockCollectionManager)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenCollectionStateWhenLoadCollectionThenSetsCorrectValues() async throws {
        // GIVEN
        mockCollectionManager.setMockFetchCollectionStateResult((completeCollection: true, volumesOwned: [1, 2, 3], readingVolume: 2))
        
        // WHEN
        sut.loadCollection(using: mockModelContext)
        
        // THEN
        #expect(sut.tempCompleteCollection == true)
        #expect(sut.tempVolumesOwned == [1, 2, 3])
        #expect(sut.tempReadingVolume == 2)
    }
    
    @Test
    func testGivenInitialStateWhenToggleCompleteCollectionThenTogglesCorrectly() {
        // GIVEN
        sut.tempCompleteCollection = false
        
        // WHEN
        sut.toggleCompleteCollection()
        
        // THEN
        #expect(sut.tempCompleteCollection == true)
        /// Should mark all volumes as owned
        #expect(sut.tempVolumesOwned == Array(1...18))
        /// Should reset reading volume
        #expect(sut.tempReadingVolume == nil)
    }
    
    @Test
    func testGivenVolumesOwnedWhenUpdateVolumesThenUpdatesCorrectly() {
        // GIVEN
        sut.tempVolumesOwned = Array(1...18)
        sut.tempReadingVolume = 3
        
        // WHEN
        sut.updateVolumes()
        
        // THEN
        
        /// Ensure volumes remain unchanged
        #expect(sut.tempVolumesOwned == Array(1...18))
        /// Should mark as complete collection
        #expect(sut.tempCompleteCollection == true)
        /// Should maintain the current reading volume
        #expect(sut.tempReadingVolume == 3)
    }
    
    @Test
    func testGivenValidDataWhenSaveChangesThenSavesSuccessfully() async throws {
        // GIVEN
        mockCollectionManager.setMockSaveToMyCollectionError(nil)
        
        // WHEN
        try await sut.saveChanges(using: mockModelContext)
        
        // THEN
        #expect(mockCollectionManager.mockSaveToMyCollectionError == nil) 
    }
    
    @Test
    func testGivenSaveErrorWhenSaveChangesThenHandlesError() async throws {
        // GIVEN
        mockCollectionManager.setMockSaveToMyCollectionError(APIError.custom(message: "Save failed"))
        
        // WHEN
        do {
            try await sut.saveChanges(using: mockModelContext)
        } catch {
            // THEN
            #expect(error as? APIError == APIError.custom(message: "Save failed"))
            #expect(mockCollectionManager.mockSaveToMyCollectionError != nil)
        }
    }
}
