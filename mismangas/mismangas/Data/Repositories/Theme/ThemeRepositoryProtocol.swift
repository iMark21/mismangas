//
//  ThemeRepositoryProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 16/1/25.
//

protocol ThemeRepositoryProtocol: Sendable {
    func fetchThemes() async throws -> [Theme]
}
