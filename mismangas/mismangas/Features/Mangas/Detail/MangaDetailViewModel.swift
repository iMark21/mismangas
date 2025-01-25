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
    private let collectionManager: MangaCollectionManagerProtocol
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
         fetchMangaDetailsUseCase: FetchMangaDetailsUseCaseProtocol = FetchMangaDetailsUseCase(),
         collectionManager: MangaCollectionManagerProtocol = MangaCollectionManager()) {
        self.fetchMangaDetailsUseCase = fetchMangaDetailsUseCase
        self.collectionManager = collectionManager
        self.mangaID = mangaID

        if let mangaID = mangaID {
            fetchMangaDetails(for: mangaID)
        } else if let manga = manga {
            state = .content(manga: manga)
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
    
    func toggleCollection(_ manga: Manga, isInCollection: Bool, modelContext: ModelContext) async {
        do {
            if isInCollection {
                try await collectionManager.removeFromCollection(mangaID: manga.id, using: modelContext)
                reset()
            } else {
                try await collectionManager.saveToMyCollection(manga: manga,
                                                               completeCollection: completeCollection,
                                                               volumesOwned: volumesOwned,
                                                               readingVolume: readingVolume,
                                                               using: modelContext)
            }
        } catch {
            state = .error(message: "Failed to toggle collection: \(error.localizedDescription)")
        }
    }
    
    func reset() {
        completeCollection = false
        volumesOwned = []
        readingVolume = nil
    }
}
