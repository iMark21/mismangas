//
//  ManageMangaCollectionUseCaseProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 24/1/25.
//

import Foundation

protocol ManageMangaCollectionUseCaseProtocol: Sendable {
    func addOrUpdateManga(_ manga: MangaCollection) async throws
    func deleteManga(withID mangaID: Int) async throws
    func fetchUserCloudCollection() async throws -> [MangaCollection]
}
