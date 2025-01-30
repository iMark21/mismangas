//
//  MockManageMangaCollectionUseCase.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
@testable import mismangas

actor MockManageMangaCollectionUseCase: ManageMangaCollectionUseCaseProtocol {
    
    // MARK: - Mock properties
    
    var mockAddOrUpdateMangaResult: Void?
    var mockDeleteMangaResult: Void?
    var mockFetchUserCloudCollectionResult: [MangaCollection]?
    var mockAddOrUpdateMangaError: Error?
    var mockDeleteMangaError: Error?
    var mockFetchUserCloudCollectionError: Error?
    
    // MARK: - Mock setters
    
    func setMockAddOrUpdateMangaResult(_ result: Void?) async {
        mockAddOrUpdateMangaResult = result
    }
    
    func setMockDeleteMangaResult(_ result: Void?) async {
        mockDeleteMangaResult = result
    }
    
    func setMockFetchUserCloudCollectionResult(_ result: [MangaCollection]?) async {
        mockFetchUserCloudCollectionResult = result
    }
    
    func setMockAddOrUpdateMangaError(_ error: Error?) async {
        mockAddOrUpdateMangaError = error
    }
    
    func setMockDeleteMangaError(_ error: Error?) async {
        mockDeleteMangaError = error
    }
    
    func setMockFetchUserCloudCollectionError(_ error: Error?) async {
        mockFetchUserCloudCollectionError = error
    }

    // MARK: - Protocol methods
    
    func addOrUpdateManga(_ manga: MangaCollection) async throws {
        if let error = mockAddOrUpdateMangaError {
            throw error
        }
        if let result = mockAddOrUpdateMangaResult {
            return result
        }
    }
    
    func deleteManga(withID mangaID: Int) async throws {
        if let error = mockDeleteMangaError {
            throw error
        }
        if let result = mockDeleteMangaResult {
            return result
        }
    }
    
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
