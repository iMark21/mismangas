//
//  UserMapper.swift
//  mismangas
//
//  Created by Michel Marques on 29/1/25.
//

import Foundation

extension String {
    func toUserDomain() -> User {
        User(token: self)
    }
}
