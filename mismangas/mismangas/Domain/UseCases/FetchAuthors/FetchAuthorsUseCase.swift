//
//  FetchAuthorsUseCase.swift
//  mismangas
//
//  Created by Michel Marques on 6/1/25.
//

import Foundation

struct FetchAuthorsUseCase: FetchAuthorsUseCaseProtocol {

    var repository: AuthorRepositoryProtocol = AuthorRepository()

    func execute() async throws -> [Author] {
        return try await repository.fetchAuthors()
    }
}
