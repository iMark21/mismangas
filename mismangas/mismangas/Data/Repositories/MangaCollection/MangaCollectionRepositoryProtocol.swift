//
//  MangaCollectionRepositoryProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 24/1/25.
//

import Foundation

protocol MangaCollectionRepositoryProtocol: Sendable {
    // MARK: - Cloud Interactions
    func syncMangaToCloud(_ manga: MangaCollection) async throws
    func deleteMangaFromCloud(withID mangaID: Int) async throws
    func fetchUserCloudCollection() async throws -> [MangaCollection]
}
