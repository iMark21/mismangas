//
//  MangaDTO.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

struct MangaDTO: Decodable {
    let id: Int
    let title: String
    let titleEnglish: String?
    let titleJapanese: String?
    let mainPicture: String?
    let url: String?
    let genres: [GenreDTO]
    let demographics: [DemographicDTO]
    let authors: [AuthorDTO]
    let score: Double?
    let chapters: Int?
    let volumes: Int?
    let status: String?
    let sypnosis: String?
    let background: String?
    let startDate: String?
    let endDate: String?
}
