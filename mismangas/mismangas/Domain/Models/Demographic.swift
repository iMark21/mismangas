//
//  Demographic.swift
//  mismangas
//
//  Created by Michel Marques on 12/1/25.
//

import Foundation

struct Demographic: Identifiable, Decodable, Hashable, Sendable {
    let id: String
    let demographic: String
}

// MARK: - Searchable

extension Demographic: Searchable {
    func matches(query: String) -> Bool {
        demographic.lowercased().contains(query.lowercased())
    }
}
