//
//  WidgetPreview.swift
//  MangaReadingWidgetExtension
//
//  Created by Michel Marques on 27/1/25.
//

import Foundation

extension MangaEntry {
    static var preview: MangaEntry {
        let response = JSONLoader.load(from: "mangas_mock", as: MangaResponseDTO.self)
        let mangaList = response?.items.map( { $0.toDomain() }) ?? []
        
        
        return .init(date: Date(),
                     collections: mangaList.prefix(3).map {
            MangaCollectionDB(manga: $0, completeCollection: .random())
        })
    }
}
