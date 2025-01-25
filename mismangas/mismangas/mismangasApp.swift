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
    @State private var selectedSection: String? = "Home"
    @State private var isUserAuthenticated = false

    var body: some Scene {
        WindowGroup {
            if !isUserAuthenticated {
                WelcomeView(isUserAuthenticated: $isUserAuthenticated)
            } else {
                if iPad {
                    NavigationSplitView {
                        List(selection: $selectedSection) {
                            NavigationLink(value: "Home") {
                                Label("Home", systemImage: "house")
                            }
                            NavigationLink(value: "All Mangas") {
                                Label("All Mangas", systemImage: "book")
                            }
                            NavigationLink(value: "My Collection") {
                                Label("My Collection", systemImage: "heart.fill")
                            }
                        }
                        .navigationTitle("Mismangas")
                    } detail: {
                        if let section = selectedSection {
                            switch section {
                            case "Home":
                                HomeView()
                            case "All Mangas":
                                MangaListPadView()
                            case "My Collection":
                                MyCollectionListView(isUserAuthenticated: $isUserAuthenticated)
                            default:
                                Text("Select a section")
                                    .foregroundColor(.secondary)
                            }
                        } else {
                            Text("Select a section")
                                .foregroundColor(.secondary)
                        }
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
                        MyCollectionListView(isUserAuthenticated: $isUserAuthenticated)
                            .tabItem {
                                Label("My Collection", systemImage: "heart.fill")
                            }
                    }
                }
            }
        }
        .modelContainer(for: [MangaCollectionDB.self])
    }
}
