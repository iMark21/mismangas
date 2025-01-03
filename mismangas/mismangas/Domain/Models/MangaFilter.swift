//
//  MangaFilter.swift
//  mismangas
//
//  Created by Michel Marques on 24/12/24.
//


enum SearchType {
    case beginsWith
    case contains
}

struct MangaFilter: Equatable {
    var query: String
    var searchType: SearchType?
    
    static var empty: MangaFilter {
        MangaFilter(query: "")
    }
}
