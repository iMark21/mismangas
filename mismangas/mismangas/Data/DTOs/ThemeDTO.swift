//
//  ThemeDTO.swift
//  mismangas
//
//  Created by Michel Marques on 16/1/25.
//

import Foundation

struct ThemeDTO: Decodable, Identifiable {
    let id: String
    let name: String

    init(from decoder: Decoder) throws {
        // Attempt to decode as a single string (used in the general list of themes)
        if let singleValueContainer = try? decoder.singleValueContainer(),
           let nameString = try? singleValueContainer.decode(String.self) {
            self.id = nameString // Use the theme name as the id
            self.name = nameString
        } else {
            // If the theme is an object, decode its "id" and "theme" properties
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(String.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .theme)
        }
    }

    private enum CodingKeys: String, CodingKey {
        case id, theme
    }
}
