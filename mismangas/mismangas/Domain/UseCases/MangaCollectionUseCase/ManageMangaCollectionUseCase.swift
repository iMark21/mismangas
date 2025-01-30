//
//  ManageMangaCollectionUseCase.swift
//  mismangas
//
//  Created by Michel Marques on 24/1/25.
//

import Foundation

struct ManageMangaCollectionUseCase: ManageMangaCollectionUseCaseProtocol {
    private let repository: MangaCollectionRepositoryProtocol

    init(repository: MangaCollectionRepositoryProtocol = MangaCollectionRepository()) {
        self.repository = repository
    }

    func addOrUpdateManga(_ manga: MangaCollection) async throws {
        // Sync with the cloud
        try await repository.syncMangaToCloud(manga)
    }

    func deleteManga(withID mangaID: Int) async throws {
        // Delete in the cloud
        try await repository.deleteMangaFromCloud(withID: mangaID)
    }
    
    func fetchUserCloudCollection() async throws -> [MangaCollection] {
        // Fetch from the cloud
        try await repository.fetchUserCloudCollection()
    }
}
