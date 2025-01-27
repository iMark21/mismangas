//
//  MangaCollectionProvider.swift
//  mismangas
//
//  Created by Michel Marques on 27/1/25.
//


import WidgetKit
import SwiftData
import SwiftUI

struct MangaCollectionProvider: @preconcurrency TimelineProvider {
    
    func placeholder(in context: Context) -> MangaEntry {
        MangaEntry(date: Date(), collections: [])
    }

    @MainActor func getSnapshot(in context: Context, completion: @escaping (MangaEntry) -> Void) {
        guard let modelContext = createModelContext() else {
            completion(MangaEntry(date: Date(), collections: []))
            return
        }
        let manager = MangaCollectionManager()
        let entry = MangaEntry(date: Date(), collections: manager.fetchAllCollections(using: modelContext))
        completion(entry)
    }

    @MainActor func getTimeline(in context: Context, completion: @escaping (Timeline<MangaEntry>) -> Void) {
        guard let modelContext = createModelContext() else {
            completion(Timeline(entries: [MangaEntry(date: Date(), collections: [])], policy: .never))
            return
        }
        let manager = MangaCollectionManager()
        let collections = manager.fetchAllCollections(using: modelContext)
        let timeline = Timeline(
            entries: [MangaEntry(date: Date(), collections: collections)],
            policy: .after(Date().addingTimeInterval(60 * 15))
        )
        completion(timeline)
    }

    @MainActor private func createModelContext() -> ModelContext? {
        let appGroupID = "group.com.imark.mismangas"
        let config = ModelConfiguration(
            "MainContainer",
            allowsSave: false,
            groupContainer: .identifier(appGroupID),
            cloudKitDatabase: .none
        )

        do {
            let container = try ModelContainer(
                for: MangaCollectionDB.self,
                configurations: config
            )
            return ModelContext(container)
        } catch {
            print("Error en widget: \(error.localizedDescription)")
            return nil
        }
    }
}

struct MangaEntry: TimelineEntry {
    let date: Date
    let collections: [MangaCollectionDB]
}
