//
//  Manga.swift
//  mismangas
//
//  Created by Michel Marques on 10/12/24.
//

import Foundation

struct Manga: Decodable, Equatable, Identifiable, Hashable {
    let id: Int
    let title: String
    let titleEnglish: String?
    let titleJapanese: String?
    let mainPicture: String?
    let genres: [Genre]
    let demographics: [Demographic]
    let authors: [Author]
    let themes: [Theme]
    let score: Double?
    let chapters: Int?
    let volumes: Int?
    let status: String
    let synopsis: String
    let startDate: String?
    let endDate: String?
}
