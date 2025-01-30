//
//  PillType.swift
//  mismangas
//
//  Created by Michel Marques on 21/1/25.
//

import Foundation

enum PillType {
    case author
    case genre
    case theme
    case demographic
}

struct PillItem: Identifiable {
    let id: String
    let title: String
    let type: PillType
}

// MARK: - Transformer

extension PillItem {
    static func fromGenres(_ genres: [Genre]) -> [PillItem] {
        genres.map { PillItem(id: $0.id, title: $0.genre, type: .genre) }
    }
    
    static func fromThemes(_ themes: [Theme]) -> [PillItem] {
        themes.map { PillItem(id: $0.id, title: $0.name, type: .theme) }
    }
    
    static func fromDemographics(_ demographics: [Demographic]) -> [PillItem] {
        demographics.map { PillItem(id: $0.id, title: $0.demographic, type: .demographic) }
    }
    
    static func fromAuthors(_ authors: [Author]) -> [PillItem] {
        authors.map { PillItem(id: $0.id, title: "\($0.fullName)", type: .author) }
    }
}
