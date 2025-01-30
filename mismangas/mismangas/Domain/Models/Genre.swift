//
//  Genre.swift
//  mismangas
//
//  Created by Michel Marques on 12/1/25.
//

import Foundation

struct Genre: Decodable {
    let id: String
    let genre: String
}

// MARK: - Searchable

extension Genre: Searchable {
    func matches(query: String) -> Bool {
        genre.lowercased().contains(query.lowercased())
    }
}
