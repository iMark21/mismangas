//
//  ThemeMapper.swift
//  mismangas
//
//  Created by Michel Marques on 16/1/25.
//

import Foundation

extension ThemeDTO {
    func toDomain() -> Theme {
        Theme(id: id, name: name)
    }
}
