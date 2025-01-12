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
    func execute(query: String?, page: Int?, perPage: Int?) async throws -> [Author] {
        return Author.previewData
    }
}

// MARK: - Preview ViewModel

extension AuthorListViewModel {
    static var preview: AuthorListViewModel {
        let useCase = MockFetchAuthorsUseCase()
        let viewModel = AuthorListViewModel(fetchAuthorsUseCase: useCase)
        return viewModel
    }
}

// MARK: - Preview Authors Filter

extension AuthorFilter {
    static var preview: AuthorFilter {
        AuthorFilter(query: "Query")
    }
}
