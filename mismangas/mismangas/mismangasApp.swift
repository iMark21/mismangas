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
    @State private var selectedSection: AppSection? = .home
    @State private var isUserAuthenticated = false
    private let modelContainer: ModelContainer
    
    init() {
        let appGroupID = "group.com.imark.mismangas"
        let schema = Schema([MangaCollectionDB.self])
        
        let config = ModelConfiguration(
            "MainContainer",
            groupContainer: .identifier(appGroupID),
            cloudKitDatabase: .none
        )
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Error configurando SwiftData: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if !isUserAuthenticated {
                    WelcomeView(isUserAuthenticated: $isUserAuthenticated)
                } else {
                    switch currentDeviceType {
                    case .mac:
                        macOSMainView(selectedSection: $selectedSection)
                    case .iPad:
                        iPadMainView(selectedSection: $selectedSection, isUserAuthenticated: $isUserAuthenticated)
                    case .iPhone:
                        iPhoneMainView(isUserAuthenticated: $isUserAuthenticated)
                    }
                }
            }
        }
        .modelContainer(modelContainer)
    }
}

