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
        // Attempt to decode as a single string (used in the general list of genres)
        if let singleValueContainer = try? decoder.singleValueContainer(),
           let genreString = try? singleValueContainer.decode(String.self) {
            self.id = genreString // Use the genre name as the id
            self.genre = genreString
        } else {
            // If the genre is an object, decode its "id" and "genre" properties
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(String.self, forKey: .id)
            self.genre = try container.decode(String.self, forKey: .genre)
        }
    }

    private enum CodingKeys: String, CodingKey {
        case id, genre
    }
}
