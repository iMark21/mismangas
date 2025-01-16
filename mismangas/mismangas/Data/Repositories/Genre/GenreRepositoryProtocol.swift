//
//  GenreRepositoryProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 13/1/25.
//


protocol GenreRepositoryProtocol: Sendable {
    func fetchGenres() async throws -> [Genre]
}
