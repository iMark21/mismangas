//
//  Theme.swift
//  mismangas
//
//  Created by Michel Marques on 16/1/25.
//

import Foundation

struct Theme: Decodable {
    let id: String
    let name: String
}

// MARK: - Searchable

extension Theme: Searchable {
    func matches(query: String) -> Bool {
        name.lowercased().contains(query.lowercased())
    }
}
