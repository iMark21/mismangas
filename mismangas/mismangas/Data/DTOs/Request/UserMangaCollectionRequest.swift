//
//  UserMangaCollectionRequest.swift
//  mismangas
//
//  Created by Michel Marques on 24/1/25.
//

import Foundation

struct UserMangaCollectionRequest: Encodable {
    let manga: Int
    let completeCollection: Bool
    let volumesOwned: [Int]
    let readingVolume: Int?
}
