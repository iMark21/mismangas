//
//  Untitled.swift
//  mismangas
//
//  Created by Michel Marques on 18/1/25.
//

import SwiftUI
import SwiftData

extension MangaCollectionManager {
    static var mangaCollections: [MangaCollectionDB] {
        [
            MangaCollectionDB(manga: .previewData.randomElement() ?? .preview),
            MangaCollectionDB(manga: .previewData.randomElement() ?? .preview),
            MangaCollectionDB(manga: .previewData.randomElement() ?? .preview)
        ]
    }

    @MainActor
    static var modelContainer: ModelContainer {
        do {
            let container = try ModelContainer(for: MangaCollectionDB.self)
            mangaCollections.forEach { container.mainContext.insert($0) }
            return container
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
}
