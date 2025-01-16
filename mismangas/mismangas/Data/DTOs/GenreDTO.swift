//
//  GenreDTO.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

struct GenreDTO: Decodable, Identifiable {
    let id: String
    let genre: String

    init(from decoder: Decoder) throws {
        // First, we try to decode a single string value representing the genre
        if let singleValueContainer = try? decoder.singleValueContainer(),
           let genreString = try? singleValueContainer.decode(String.self) {
            self.id = genreString // Use the genre name as the id
            self.genre = genreString
        } else {
            // If it's not a single string, we attempt to decode an object with "id" and "genre" keys
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(String.self, forKey: .id) // Decode the id field
            self.genre = try container.decode(String.self, forKey: .genre) // Decode the genre field
        }
    }

    private enum CodingKeys: String, CodingKey {
        case id, genre
    }
}
