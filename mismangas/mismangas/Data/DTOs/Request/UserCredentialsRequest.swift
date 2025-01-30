//
//  RegisterUserRequest.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import Foundation

struct UserCredentialsRequest: Codable {
    let email: String
    let password: String
}
