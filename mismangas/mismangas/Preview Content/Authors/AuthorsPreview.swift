//
//  AuthorsPreview.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//


import Foundation

// MARK: - Mock Data

extension Author {
    static var previewData: [Author] {
        let response = JSONLoader.load(from: "authors_mock", as: [AuthorDTO].self)
        return response?.map { $0.toDomain() } ?? []
    }
    
    static var preview: Author {
        previewData.first!
    }
}

// MARK: - Mock UseCase

final class MockFetchAuthorsUseCase: FetchAuthorsUseCaseProtocol {
    func execute() async throws -> [Author] {
        return Author.previewData
    }
}

// MARK: - Preview ViewModel

extension SelectableListViewModel where T == Author {
    static var authorsPreview: SelectableListViewModel<Author> {
        let useCase = MockFetchAuthorsUseCase()
        let viewModel = SelectableListViewModel(
            title: "Authors",
            fetchItemsUseCase: useCase,
            selectedItem: nil,
            onSelectItem: { _ in
                Logger.log("Item selected")
            }
        )
        return viewModel
    }
}
