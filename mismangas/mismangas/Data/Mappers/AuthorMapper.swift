//
//  AuthorMapper.swift
//  mismangas
//
//  Created by Michel Marques on 6/1/25.
//


struct AuthorMapper {
    static func map(from dto: AuthorDTO) -> Author {
        let role = AuthorRole(rawValue: dto.role) ?? .storyAndArt
        let fullName = "\(dto.firstName) \(dto.lastName)"
        return Author(id: dto.id, fullName: fullName, role: role)
    }

    static func map(from dtoList: [AuthorDTO]) -> [Author] {
        return dtoList.map { map(from: $0) }
    }
}
