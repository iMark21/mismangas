//
//  MangasPreview.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

// MARK: - Mock Data

extension Manga {
    static var previewData: [Manga] {
        let response = JSONLoader.load(from: "mangas_mock", as: MangaResponseDTO.self)
        return response?.items.map( { $0.toDomain() }) ?? []
    }
    
    static var preview: Manga {
        previewData.first!
    }
}

// MARK: - Mock UseCase

final class MockFetchMangasUseCase: FetchMangasUseCaseProtocol {
    func execute(filter: MangaFilter, page: Int, perPage: Int) async throws -> [Manga] {
        return Manga.previewData
    }
}

// MARK: - Preview ViewModel

extension MangaListViewModel {
    static var preview: MangaListViewModel {
        let useCase = MockFetchMangasUseCase()
        let viewModel = MangaListViewModel(fetchMangasUseCase: useCase)
        return viewModel
    }
}

// MARK: - Preview Mangas Filter

extension MangaFilter {
    static var preview: MangaFilter {
        MangaFilter(query: "One Piece", searchType: .contains)
    }
}
