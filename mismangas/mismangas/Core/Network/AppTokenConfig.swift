//
//  AppTokenConfig.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import Foundation

struct AppTokenConfig {
    
    // MARK: - AppToken
    
    static var appToken: String {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let token = dict["AppToken"] as? String else {
            fatalError("⚠️ AppToken not found in Config.plist")
        }
        return token
    }
    
    // MARK: - Required Endpoints
    
    static let requiredEndpoints: Set<URL> = [
        .registerUser,
        .loginUser,
        .renewToken,
        .userCollection
    ]
}
