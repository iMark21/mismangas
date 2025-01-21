//
//  HomeViewModel.swift
//  mismangas
//
//  Created by Michel Marques on 20/1/25.
//

import Foundation

@Observable
final class HomeViewModel {
    
    private let bestMangasUseCase: FetchBestMangasUseCaseProtocol
    var bestMangas: [Manga] = []
    var isLoadingBestMangas: Bool = true
    
    var latestMangas: [Manga] = []
    var isLoadingLatestMangas: Bool = true
    
    var genres: [Manga] = []
    var isLoadingGenres: Bool = true
    
    init(bestMangasUseCase: FetchBestMangasUseCaseProtocol = FetchBestMangasUseCase()) {
        self.bestMangasUseCase = bestMangasUseCase
    }
    
    @MainActor
    func fetchData() {
        Task {
            isLoadingBestMangas = true
            do {
                bestMangas = try await bestMangasUseCase.execute()
            } catch {
                print("Error fetching best mangas: \(error.localizedDescription)")
            }
            isLoadingBestMangas = false
        }
    }
}
