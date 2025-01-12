//
//  AuthorFilter.swift
//  mismangas
//
//  Created by Michel Marques on 7/1/25.
//


struct AuthorFilter: FilterProtocol {
    var query: String
    
    static var empty: AuthorFilter {
        return AuthorFilter(query: "")
    }
}
