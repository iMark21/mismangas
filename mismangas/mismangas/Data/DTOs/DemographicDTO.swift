//
//  DemographicDTO.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

struct DemographicDTO: Decodable, Identifiable {
    let id: String
    let demographic: String

    init(from decoder: Decoder) throws {
        // Attempt to decode as a single string (case of the general list)
        if let singleValueContainer = try? decoder.singleValueContainer(),
           let demographicString = try? singleValueContainer.decode(String.self) {
            self.id = demographicString // Use the demographic name as the id
            self.demographic = demographicString
        } else {
            // Decode as an object (case inside a manga)
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(String.self, forKey: .id)
            self.demographic = try container.decode(String.self, forKey: .demographic)
        }
    }

    private enum CodingKeys: String, CodingKey {
        case id, demographic
    }
}
