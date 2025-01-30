//
//  GenrePreview.swift
//  mismangas
//
//  Created by Michel Marques on 13/1/25.
//

import Foundation

// MARK: - Mock Data

extension Genre {
    static var previewData: [Genre] {
        let response = JSONLoader.load(from: "genres_mock", as: [GenreDTO].self)
        return response?.map { $0.toDomain() } ?? []
    }
    
    static var preview: Genre {
        previewData.first!
    }
}

// MARK: - Mock UseCase

final class MockFetchGenreUseCase: FetchGenresUseCaseProtocol {
    func execute() async throws -> [Genre] {
        return Genre.previewData
    }
}

// MARK: - Preview ViewModel

extension SelectableListViewModel where T == Genre {
    static var genresPreview: SelectableListViewModel<Genre> {
        let useCase = MockFetchGenreUseCase()
        let viewModel = SelectableListViewModel(
            title: "Genres",
            fetchItemsUseCase: useCase,
            selectedItem: nil,
            onSelectItem: { _ in
                Logger.log("Item selected")
            }
        )
        return viewModel
    }
}
