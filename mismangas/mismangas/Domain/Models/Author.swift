//
//  Author.swift
//  mismangas
//
//  Created by Michel Marques on 6/1/25.
//


struct Author: Identifiable, Decodable, Equatable {
    let id: String
    let fullName: String
    let role: AuthorRole
}

enum AuthorRole: String, Decodable {
    case story = "Story"
    case art = "Art"
    case storyAndArt = "Story & Art"
}

extension Author: CustomStringConvertible {
    var description: String {
        return fullName
    }
}
