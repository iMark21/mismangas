//
//  UserMangaCollectionResponse.swift
//  mismangas
//
//  Created by Michel Marques on 24/1/25.
//


struct UserMangaCollectionDTO: Decodable {
    let manga: MangaDTO
    let completeCollection: Bool
    let volumesOwned: [Int]
    let readingVolume: Int?
}
