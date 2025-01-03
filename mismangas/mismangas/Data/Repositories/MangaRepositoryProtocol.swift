//
//  MangaRepositoryProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

protocol MangaRepositoryProtocol: Sendable {
    func fetchMangasBy(query: String, searchType: SearchType?, page: Int, perPage: Int) async throws -> [Manga]
}
