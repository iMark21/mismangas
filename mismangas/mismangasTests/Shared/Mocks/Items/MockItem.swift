//
//  MockItem.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
@testable import mismangas

struct MockItem: Searchable {
    var id: String
    var name: String
    
    func matches(query: String) -> Bool {
        return name.contains(query)
    }
}
