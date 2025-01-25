//
//  MangaCollectionRepository.swift
//  mismangas
//
//  Created by Michel Marques on 24/1/25.
//

import Foundation

struct MangaCollectionRepository: MangaCollectionRepositoryProtocol {
    
    let apiClient: APIClient = MisMangasAPIClient()
    let tokenStorage: KeyChainItemManager = KeyChainTokenStorage()

    // MARK: - Cloud Interactions
    func syncMangaToCloud(_ manga: MangaCollection) async throws {
        guard let token = try tokenStorage.load() else {
            throw APIError.unauthorized
        }

        let requestDTO = manga.toAPIRequest()
        try await apiClient.perform(
            .post(
                url: .userCollection,
                body: requestDTO,
                headers: [
                    "Authorization": "Bearer \(token)"
                ]
            )
        ) as Void
    }

    func deleteMangaFromCloud(withID mangaID: Int) async throws {
        guard let token = try tokenStorage.load() else {
            throw APIError.unauthorized
        }

        try await apiClient.perform(
            .delete(
                .userCollectionManga(mangaID),
                headers: [
                    "Authorization": "Bearer \(token)"
                ]
            )
        ) as Void
    }

    func fetchUserCloudCollection() async throws -> [MangaCollection] {
        guard let token = try tokenStorage.load() else {
            throw APIError.unauthorized
        }

        let response: [UserMangaCollectionDTO] = try await apiClient.perform(
            .get(
                .userCollection,
                headers: [
                    "Authorization": "Bearer \(token)"
                ]
            )
        )
        
        return response.map { $0.toDomain() }
    }
}
