//
//  MangaDetailViewModel.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//

import SwiftData
import SwiftUI

@Observable @MainActor
final class MangaDetailViewModel {

    // MARK: - View State
    
    enum ViewState {
        case loading
        case content(manga: Manga)
        case error(message: String)
    }

    // MARK: - Properties
    
    private let fetchMangaDetailsUseCase: FetchMangaDetailsUseCaseProtocol
    var state: ViewState = .loading
    var mangaID: Int?

    // MARK: - Collection Management
    
    var showingCollectionManagement = false
    var completeCollection: Bool = false
    var volumesOwned: [Int] = []
    var readingVolume: Int? = nil

    // MARK: - Initialization
    
    init(manga: Manga? = nil,
         mangaID: Int? = nil,
         fetchMangaDetailsUseCase: FetchMangaDetailsUseCaseProtocol = FetchMangaDetailsUseCase()) {
        self.fetchMangaDetailsUseCase = fetchMangaDetailsUseCase
        self.mangaID = mangaID

        if let manga = manga {
            state = .content(manga: manga)
        } else if let mangaID = mangaID {
            fetchMangaDetails(for: mangaID)
        }
    }

    // MARK: - Methods
    
    func fetchMangaDetails(for mangaID: Int) {
        state = .loading
        Task {
            do {
                let fetchedManga = try await fetchMangaDetailsUseCase.execute(id: mangaID)
                state = .content(manga: fetchedManga)
            } catch {
                state = .error(message: "Failed to load manga details.")
            }
        }
    }
}
