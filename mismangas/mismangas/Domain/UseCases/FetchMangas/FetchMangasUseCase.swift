//
//  FetchMangasInput.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

struct FetchMangasUseCase: FetchMangasUseCaseProtocol {
    var repository: MangaRepositoryProtocol = MangaRepository()
    
    func execute(page: Int, perPage: Int) async throws -> [Manga] {
        return try await repository.fetchMangas(page: page, perPage: perPage)
    }
}
