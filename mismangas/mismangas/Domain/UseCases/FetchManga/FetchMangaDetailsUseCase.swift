//
//  FetchMangaDetailsUseCase.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//

import Foundation

struct FetchMangaDetailsUseCase: FetchMangaDetailsUseCaseProtocol {
    var repository: MangaRepositoryProtocol = MangaRepository()

    func execute(id: Int) async throws -> Manga {
        return try await repository.fetchMangaDetails(by: id)
    }
}
