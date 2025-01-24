//
//  Searchable.swift
//  mismangas
//
//  Created by Michel Marques on 12/1/25.
//

import Foundation

protocol Searchable: Identifiable, Hashable, Equatable, Sendable {
    func matches(query: String) -> Bool
}
