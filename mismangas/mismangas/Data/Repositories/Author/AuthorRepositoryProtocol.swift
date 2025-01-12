//
//  AuthorRepositoryProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 6/1/25.
//

import Foundation

protocol AuthorRepositoryProtocol: Sendable {
    func fetchAuthors(query: String?, page: Int?, perPage: Int?) async throws -> [Author]
}
