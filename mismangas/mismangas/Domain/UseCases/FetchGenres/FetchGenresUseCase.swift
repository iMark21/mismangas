//
//  FetchGenresUseCase.swift
//  mismangas
//
//  Created by Michel Marques on 13/1/25.
//

import Foundation

struct FetchGenresUseCase: FetchGenresUseCaseProtocol {

    var repository: GenreRepositoryProtocol = GenreRepository()

    func execute() async throws -> [Genre] {
        return try await repository.fetchGenres()
    }
}
