//
//  AppSection.swift
//  mismangas
//
//  Created by Michel Marques on 25/1/25.
//

import Foundation

enum AppSection: String, Hashable, CaseIterable {
    case home = "Home"
    case allMangas = "All Mangas"
    case myCollection = "My Collection"
}

extension AppSection {
    var systemImageName: String {
        switch self {
        case .home:
            return "house"
        case .allMangas:
            return "book"
        case .myCollection:
            return "heart.fill"
        }
    }
}
