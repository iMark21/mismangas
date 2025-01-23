//
//  FetchGenresUseCase.swift
//  mismangas
//
//  Created by Michel Marques on 13/1/25.
//

import Foundation

struct FetchGenresUseCase: FetchGenresUseCaseProtocol {

    let repository: GenreRepositoryProtocol = GenreRepository()

    func execute() async throws -> [Genre] {
        return try await repository.fetchGenres()
    }
}
