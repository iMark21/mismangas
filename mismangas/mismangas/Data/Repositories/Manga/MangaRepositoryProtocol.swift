//
//  MangaRepositoryProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

protocol MangaRepositoryProtocol: Sendable {
    func fetchBestMangas() async throws -> [Manga]
    func fetchMangasBy(filter: MangaFilter, page: Int, perPage: Int) async throws -> [Manga]
    func fetchMangaDetails(by id: Int) async throws -> Manga
}
