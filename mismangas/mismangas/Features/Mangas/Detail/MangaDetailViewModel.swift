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
    
    enum ViewState: Equatable {
        case loading
        case content(manga: Manga)
        case error(message: String)
    }

    // MARK: - Properties
    
    private(set) var fetchMangaDetailsUseCase: FetchMangaDetailsUseCaseProtocol
    private(set) var collectionManager: MangaCollectionManagerProtocol
    var state: ViewState = .loading
    var mangaID: Int?
    var manga: Manga?

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
        self.manga = manga
    }
    
    func load() async {
        if let mangaID {
            await fetchMangaDetails(for: mangaID)
        } else if let manga = manga {
            state = .content(manga: manga)
        }
    }

    // MARK: - Methods
    
    func fetchMangaDetails(for mangaID: Int) async {
        state = .loading
        do {
            let fetchedManga = try await fetchMangaDetailsUseCase.execute(id: mangaID)
            state = .content(manga: fetchedManga)
        } catch {
            state = .error(message: "Failed to load manga details.")
        }
    }
    
    func toggleCollection(_ manga: Manga, isInCollection: Bool, modelContext: ModelContextProtocol) async {
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
