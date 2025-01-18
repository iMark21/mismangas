//
//  mismangasApp.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import SwiftUI
import SwiftData

@main
struct mismangasApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                MangaListView()
                    .tabItem {
                        Label("All Mangas", systemImage: "book")
                    }
                MyCollectionListView()
                    .tabItem {
                        Label("My Collection", systemImage: "heart.fill")
                    }
            }
        }
        .modelContainer(for: [MangaCollection.self])
    }
}
