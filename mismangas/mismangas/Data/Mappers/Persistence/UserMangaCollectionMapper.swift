//
//  MangaCollectionMapper.swift
//  mismangas
//
//  Created by Michel Marques on 24/1/25.
//

import Foundation

extension UserMangaCollectionDTO {
    func toDomain() -> MangaCollection {
        return MangaCollection(mangaID: manga.id,
                               mangaName: manga.title,
                               completeCollection: completeCollection,
                               volumesOwned: volumesOwned,
                               readingVolume: readingVolume,
                               totalVolumes: totalVolumes)
    }
}

extension MangaCollection {
    func toAPIRequest() -> UserMangaCollectionRequest {
        UserMangaCollectionRequest(manga: mangaID,
                                   completeCollection: completeCollection,
                                   volumesOwned: volumesOwned,
                                   readingVolume: readingVolume)
    }
}


extension MangaCollection {
    func toDBModel() -> MangaCollectionDB {
        MangaCollectionDB(mangaID: mangaID,
                          mangaName: mangaName,
                          completeCollection: completeCollection,
                          volumesOwned: volumesOwned,
                          readingVolume: readingVolume,
                          totalVolumes: totalVolumes)
    }
}

