//
//  MangaListViewModel.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

@Observable
final class MangaListViewModel {
    var mangas: [Manga] = []
    var errorMessage: String?

    private let fetchMangasUseCase: FetchMangasUseCaseProtocol

    init(fetchMangasUseCase: FetchMangasUseCaseProtocol = FetchMangasUseCase()) {
        self.fetchMangasUseCase = fetchMangasUseCase
    }

    @MainActor func fetchMangas(page: Int = 1, perPage: Int = 10) {
        Task {
            do {
                let result = try await fetchMangasUseCase.execute(page: page, perPage: perPage)
                mangas = result
            } catch {
                errorMessage = "Error: \(error.localizedDescription)"
            }
        }
    }
}
