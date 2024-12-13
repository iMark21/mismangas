//
//  MangaResponse.swift
//  mismangas
//
//  Created by Michel Marques on 10/12/24.
//

import Foundation

struct MangaResponseDTO: Decodable {
    let items: [MangaDTO]
    let metadata: Metadata
}

struct Metadata: Decodable {
    let total: Int
    let per: Int
    let page: Int
}
