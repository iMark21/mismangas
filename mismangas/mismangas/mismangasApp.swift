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

    var body: some Scene {
        WindowGroup {
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
        .modelContainer(for: [MangaCollectionDB.self])
    }
}
