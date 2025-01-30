//
//  AuthorRepositoryProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 6/1/25.
//

import Foundation

protocol AuthorRepositoryProtocol: Sendable {
    func fetchAuthors() async throws -> [Author]
}
