//
//  MangaCollectionDTO.swift
//  mismangas
//
//  Created by Michel Marques on 24/1/25.
//


struct MangaCollection: Sendable, Identifiable {
    let mangaID: Int
    let mangaName: String
    let completeCollection: Bool
    let volumesOwned: [Int]
    let readingVolume: Int?
    
    var id: Int {
        return mangaID
    }
}
