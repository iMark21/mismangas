//
//  FetchMangaDetailsUseCaseProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//

import Foundation

protocol FetchMangaDetailsUseCaseProtocol: Sendable {
    func execute(id: Int) async throws -> Manga
}
