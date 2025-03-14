//
//  SearchType.swift
//  mismangas
//
//  Created by Michel Marques on 24/12/24.
//


enum SearchType: String, CaseIterable, Identifiable {
    case beginsWith
    case contains
    case author
    case genre
    case theme
    case demographic
    
    var id: Self { self }
}
