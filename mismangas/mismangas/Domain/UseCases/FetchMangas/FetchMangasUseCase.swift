//
//  FetchMangasUseCase.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

struct FetchMangasUseCase: FetchMangasUseCaseProtocol {
    var repository: MangaRepositoryProtocol = MangaRepository()

    func execute(filter: MangaFilter, page: Int, perPage: Int) async throws -> [Manga] {
        
        return try await repository.fetchMangasBy(
            filter: filter,
            page: page,
            perPage: perPage
        )
    }
}
