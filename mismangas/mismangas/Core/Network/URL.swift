//
//  AppConfig.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

extension URL {
    
    // MARK: - Constants
    
    static let baseURL = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com"
    static let timeOut = 60.0
    
    private static let api = URL(string: baseURL)!

    // MARK: - Endpoints
    
    static let mangas = api.appending(path: "list/mangas")
    static let bestMangas = api.appending(path: "list/bestMangas")
}

// MARK: - Query Items

extension URLQueryItem {
    static func page(_ page: Int) -> URLQueryItem {
        URLQueryItem(name: "page", value: "\(page)")
    }
    
    static func per(_ per: Int) -> URLQueryItem {
        URLQueryItem(name: "per", value: "\(per)")
    }
}
