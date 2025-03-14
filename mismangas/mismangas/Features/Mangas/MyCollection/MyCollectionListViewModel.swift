//
//  MyCollectionListViewModel.swift
//  mismangas
//
//  Created by Michel Marques on 24/1/25.
//

import Foundation
import SwiftData

@Observable @MainActor
final class MyCollectionListViewModel {
    // MARK: - Properties
    private let syncManager: MangaCollectionManagerProtocol
    private var logoutUseCase: LogoutUserUseCaseProtocol = LogoutUserUseCase()
    
    /// Public
    var isSyncing: Bool = false
    var showLogoutConfirmation: Bool = false

    // MARK: - Initialization
    init(syncManager: MangaCollectionManagerProtocol = MangaCollectionManager(),
         logoutUseCase: LogoutUserUseCaseProtocol = LogoutUserUseCase()) {
        self.syncManager = syncManager
        self.logoutUseCase = logoutUseCase
    }
    
    // MARK: - Logout Action
    
    func logout() async {
        do {
            try await logoutUseCase.execute()
        } catch {
            Logger.logErrorMessage("Failed to logout: \(error.localizedDescription)")
        }
    }
    
    func showMessageLogout() {
        showLogoutConfirmation = true
    }

    // MARK: - Manager Actions

    /// Fetch all collections from the local database
    func syncCollections(using context: ModelContextProtocol) async {
        isSyncing = true
        do {
            try await syncManager.syncWithCloud(using: context)
        } catch {
            Logger.logErrorMessage("Failed to sync data: \(error.localizedDescription)")
        }
        isSyncing = false
    }

    /// Delete a collection by manga ID and sync the change with the cloud
    func deleteCollection(withID mangaID: Int, using context: ModelContextProtocol) async {
        do {
            try await syncManager.removeFromCollection(mangaID: mangaID, using: context)
        } catch {
            Logger.logErrorMessage("Failed to delete manga: \(error.localizedDescription)")
        }
    }

    /// Add or update a manga in the collection and sync with the cloud
    func addOrUpdateManga(
        _ manga: Manga,
        completeCollection: Bool,
        volumesOwned: [Int],
        readingVolume: Int?,
        using context: ModelContextProtocol
    ) async {
        do {
            try await syncManager.saveToMyCollection(
                manga: manga,
                completeCollection: completeCollection,
                volumesOwned: volumesOwned,
                readingVolume: readingVolume,
                using: context
            )
        } catch {
            Logger.logErrorMessage("Failed to add/update manga: \(error.localizedDescription)")
        }
    }
}
