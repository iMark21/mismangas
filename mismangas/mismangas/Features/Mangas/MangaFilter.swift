//
//  MangaFilter.swift
//  mismangas
//
//  Created by Michel Marques on 7/1/25.
//


struct MangaFilter: Equatable, FilterProtocol {
    var id: String?
    var query: String
    var searchType: SearchType?
    
    static var empty: MangaFilter {
        MangaFilter(query: "")
    }
}
