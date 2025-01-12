//
//  MangaMapper.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

extension MangaDTO {
    func toDomain() -> Manga {
        return Manga(
            id: id,
            title: title,
            titleEnglish: titleEnglish,
            titleJapanese: titleJapanese,
            mainPicture: mainPicture?.replacingOccurrences(of: "\"", with: ""),
            genres: genres.map { $0.toDomain() },
            demographics: demographics.map { $0.toDomain() },
            authors: authors.map { $0.toDomain() },
            score: score,
            chapters: chapters,
            volumes: volumes,
            status: status ?? " - ",
            sypnosis: sypnosis ?? " - ",
            startDate: startDate,
            endDate: endDate
        )
    }
}
