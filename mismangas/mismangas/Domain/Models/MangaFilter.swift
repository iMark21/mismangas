//
//  MangaFilter.swift
//  mismangas
//
//  Created by Michel Marques on 24/12/24.
//


enum SearchType: String, CaseIterable {
    case beginsWith
    case contains
    case author
    case genre
    case theme
    case demographic
}

struct MangaFilter: Equatable {
    var query: String
    var searchType: SearchType?
    
    static var empty: MangaFilter {
        MangaFilter(query: "")
    }
}
