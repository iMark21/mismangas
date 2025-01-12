//
//  AuthorDTO.swift
//  mismangas
//
//  Created by Michel Marques on 6/1/25.
//


struct AuthorDTO: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let role: String
}

extension AuthorDTO {
    func toDomain() -> Author {
        Author(
            id: id,
            fullName: "\(firstName) \(lastName)",
            role: AuthorRole(rawValue: role) ?? .story
        )
    }
}
