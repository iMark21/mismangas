//
//  AuthorMapper.swift
//  mismangas
//
//  Created by Michel Marques on 6/1/25.
//

import Foundation

extension AuthorDTO {
    func toDomain() -> Author {
        Author(id: id,
               fullName: "\(firstName) \(lastName)",
               role: AuthorRole(rawValue: role) ?? .story)
    }
}
