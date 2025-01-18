//
//  MangaCollection.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//

import Foundation
import SwiftData

@Model
final class MangaCollection {
    @Attribute(.unique) var id: UUID
    var mangaID: Int
    var mangaName: String
    var completeCollection: Bool
    var volumesOwned: [Int]
    var readingVolume: Int?

    init(manga: Manga, completeCollection: Bool = false, volumesOwned: [Int] = [], readingVolume: Int? = nil) {
        self.id = UUID()
        self.mangaID = manga.id
        self.mangaName = manga.title
        self.completeCollection = completeCollection
        self.volumesOwned = volumesOwned
        self.readingVolume = readingVolume
    }
}
