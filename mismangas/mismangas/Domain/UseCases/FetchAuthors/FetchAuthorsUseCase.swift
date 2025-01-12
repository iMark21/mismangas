//
//  FetchAuthorsUseCase.swift
//  mismangas
//
//  Created by Michel Marques on 6/1/25.
//

import Foundation

struct FetchAuthorsUseCase: FetchAuthorsUseCaseProtocol {

    let repository: AuthorRepositoryProtocol = AuthorRepository()

    func execute(query: String? = nil, page: Int? = nil, perPage: Int? = nil) async throws -> [Author] {
        return try await repository.fetchAuthors(query: query, page: page, perPage: perPage)
    }
}
