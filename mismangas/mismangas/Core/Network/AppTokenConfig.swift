//
//  AppTokenConfig.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import Foundation

struct AppTokenConfig {
    static let requiredEndpoints: Set<URL> = [
        .registerUser,
        .loginUser,
        .renewToken,
        .userCollection
    ]
    
    static let appToken = "sLGH38NhEJ0_anlIWwhsz1-LarClEohiAHQqayF0FY"
}
