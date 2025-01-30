//
//  MockMangaRepository.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
@testable import mismangas

actor MockMangaRepository: MangaRepositoryProtocol {
    
    // MARK: - Mock Properties
    
    var mockFetchBestMangasResult: [Manga]?
    var mockFetchMangasByResult: [Manga]?
    var mockFetchMangaDetailsResult: Manga?
    
    var mockFetchBestMangasError: Error?
    var mockFetchMangasByError: Error?
    var mockFetchMangaDetailsError: Error?
    
    // MARK: - Mock Setters
    
    func setMockFetchBestMangasResult(_ result: [Manga]?) {
        mockFetchBestMangasResult = result
    }
    
    func setMockFetchMangasByResult(_ result: [Manga]?) {
        mockFetchMangasByResult = result
    }
    
    func setMockFetchMangaDetailsResult(_ result: Manga?) {
        mockFetchMangaDetailsResult = result
    }
    
    func setMockFetchBestMangasError(_ error: APIError?) {
        mockFetchBestMangasError = error
    }
    
    func setMockFetchMangasByError(_ error: APIError?) {
        mockFetchMangasByError = error
    }
    
    func setMockFetchMangaDetailsError(_ error: APIError?) {
        mockFetchMangaDetailsError = error
    }
    
    // MARK: - Protocol Methods
    
    func fetchBestMangas() async throws -> [Manga] {
        if let error = mockFetchBestMangasError {
            throw error
        }
        return mockFetchBestMangasResult ?? []
    }
    
    func fetchMangasBy(filter: MangaFilter, page: Int, perPage: Int) async throws -> [Manga] {
        if let error = mockFetchMangasByError {
            throw error
        }
        return mockFetchMangasByResult ?? []
    }
    
    func fetchMangaDetails(by id: Int) async throws -> Manga {
        if let error = mockFetchMangaDetailsError {
            throw error
        }
        guard let manga = mockFetchMangaDetailsResult else {
            throw APIError.custom(message: "Manga details not found")
        }
        return manga
    }
}
