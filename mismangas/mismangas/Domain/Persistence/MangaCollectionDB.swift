//
//  MangaCollectionDB.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//

import Foundation
import SwiftData

@Model
final class MangaCollectionDB {
    @Attribute(.unique) var id: UUID
    var mangaID: Int
    var mangaName: String
    var completeCollection: Bool
    var volumesOwned: [Int]
    var readingVolume: Int?
    var totalVolumes: Int?
    
    init(mangaID: Int, mangaName: String, completeCollection: Bool = false, volumesOwned: [Int] = [], readingVolume: Int? = nil, totalVolumes: Int?) {
        self.id = UUID()
        self.mangaID = mangaID
        self.mangaName = mangaName
        self.completeCollection = completeCollection
        self.volumesOwned = volumesOwned
        self.readingVolume = readingVolume
        self.totalVolumes = totalVolumes
    }

    convenience init(manga: Manga, completeCollection: Bool = false, volumesOwned: [Int] = [], readingVolume: Int? = nil) {
        self.init(
            mangaID: manga.id,
            mangaName: manga.title,
            completeCollection: completeCollection,
            volumesOwned: volumesOwned,
            readingVolume: readingVolume,
            totalVolumes: manga.volumes
        )
    }
}
