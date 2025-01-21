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
            if iPad {
                NavigationSplitView {
                    List {
                        NavigationLink(destination: MangaListPadView()) {
                            Label("All Mangas", systemImage: "book")
                        }
                        NavigationLink(destination: MyCollectionListView()) {
                            Label("My Collection", systemImage: "heart.fill")
                        }
                    }
                    .navigationTitle("Mismangas")
                } detail: {
                    Text("Select a section")
                        .foregroundColor(.secondary)
                }
            } else {
                // TabView para iPhone
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
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
        }
        .modelContainer(for: [MangaCollection.self])
    }
}
