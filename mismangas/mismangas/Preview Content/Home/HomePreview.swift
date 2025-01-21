//
//  HomePreview.swift
//  mismangas
//
//  Created by Michel Marques on 20/1/25.
//


extension HomeViewModel {
    static var preview: HomeViewModel {
        let viewModel = HomeViewModel(bestMangasUseCase: MockFetchBestMangasUseCase())
        viewModel.latestMangas = Manga.previewData.shuffled()
        viewModel.genres = Manga.previewData.shuffled()

        return viewModel
    }
}

// MARK: - Mock UseCase

struct MockFetchBestMangasUseCase: FetchBestMangasUseCaseProtocol {
    func execute() async throws -> [Manga] {
        return Manga.previewData
    }
}
