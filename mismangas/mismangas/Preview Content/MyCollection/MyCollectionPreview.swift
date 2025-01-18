//
//  Untitled.swift
//  mismangas
//
//  Created by Michel Marques on 18/1/25.
//

import SwiftUI
import SwiftData

extension MangaCollectionManager {
    static var mangaCollections: [MangaCollection] {
        [
            MangaCollection(manga: .previewData.randomElement() ?? .preview),
            MangaCollection(manga: .previewData.randomElement() ?? .preview),
            MangaCollection(manga: .previewData.randomElement() ?? .preview)
        ]
    }

    @MainActor
    static var modelContainer: ModelContainer {
        do {
            let container = try ModelContainer(for: MangaCollection.self)
            mangaCollections.forEach { container.mainContext.insert($0) }
            return container
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
}
