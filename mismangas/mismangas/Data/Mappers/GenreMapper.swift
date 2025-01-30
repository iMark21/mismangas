//
//  GenreMapper.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//


extension GenreDTO {
    func toDomain() -> Genre {
        return Genre(id: id, genre: genre)
    }
}
