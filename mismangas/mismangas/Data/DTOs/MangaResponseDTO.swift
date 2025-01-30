//
//  MangaResponse.swift
//  mismangas
//
//  Created by Michel Marques on 10/12/24.
//

import Foundation

struct MangaResponseDTO: Decodable {
    let items: [MangaDTO]
    let metadata: Metadata?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let objectResponse = try? container.decode(ResponseWrapper.self) {
            self.items = objectResponse.items
            self.metadata = objectResponse.metadata
        } else if let arrayResponse = try? container.decode([MangaDTO].self) {
            self.items = arrayResponse
            self.metadata = nil
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid response format.")
        }
    }

    private struct ResponseWrapper: Decodable {
        let items: [MangaDTO]
        let metadata: Metadata
    }
}

struct Metadata: Decodable {
    let total: Int
    let per: Int
    let page: Int
}
