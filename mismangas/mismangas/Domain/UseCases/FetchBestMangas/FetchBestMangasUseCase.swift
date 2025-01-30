//
//  FetchBestMangasUseCase.swift
//  mismangas
//
//  Created by Michel Marques on 20/1/25.
//

import Foundation

struct FetchBestMangasUseCase: FetchBestMangasUseCaseProtocol {
    var repository: MangaRepositoryProtocol = MangaRepository()

    func execute() async throws -> [Manga] {
        return try await repository.fetchBestMangas()
    }
}
