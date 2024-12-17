//
//  Manga.swift
//  mismangas
//
//  Created by Michel Marques on 10/12/24.
//

import Foundation

struct Manga: Decodable, Identifiable, Equatable {
    let id: Int
    let title: String
    let titleEnglish: String?
    let titleJapanese: String?
    let mainPicture: String
    let genres: [Genre]
    let demographics: [Demographic]
    let score: Double?
    let chapters: Int?
    let volumes: Int?
    let status: String
    let sypnosis: String
    let startDate: String?
    let endDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case titleEnglish
        case titleJapanese
        case mainPicture
        case genres
        case demographics
        case score
        case chapters
        case volumes
        case status
        case sypnosis
        case startDate
        case endDate
    }
}

struct Genre: Decodable, Equatable {
    let id: String
    let genre: String
}

struct Demographic: Decodable, Equatable {
    let id: String
    let demographic: String
}
