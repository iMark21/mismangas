//
//  AppConfig.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

// MARK: - Base Configuration

extension URL {
    static let baseURL = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com"
    static let timeOut = 60.0
    
    private static let api = URL(string: baseURL)!
}

// MARK: - Manga Endpoints

extension URL {
    static let mangas = api.appending(path: "list/mangas")
    static let bestMangas = api.appending(path: "list/bestMangas")
    
    static func searchMangasBeginsWith(_ prefix: String) -> URL {
        api.appending(path: "search/mangasBeginsWith/\(prefix)")
    }
    
    static func searchMangasContains(_ text: String) -> URL {
        api.appending(path: "search/mangasContains/\(text)")
    }
}

// MARK: - Manga Detail Endpoint

extension URL {
    static func mangaDetail(for id: Int) -> URL {
        api.appending(path: "search/manga/\(id)")
    }
}

// MARK: - Author Endpoints

extension URL {
    static let authors = api.appending(path: "list/authors")
    
    static func searchMangasByAuthor(_ author: String) -> URL {
        api.appending(path: "list/mangaByAuthor/\(author)")
    }
    
    static func searchAuthors(by name: String) -> URL {
        api.appending(path: "search/author/\(name)")
    }
}

// MARK: - Genre Endpoints

extension URL {
    static let genres = api.appending(path: "list/genres")
    
    static func searchMangasByGenre(_ genre: String) -> URL {
        api.appending(path: "list/mangaByGenre/\(genre)")
    }
}

// MARK: - Theme Endpoints

extension URL {
    static let themes = api.appending(path: "list/themes")
    
    static func searchMangasByTheme(_ theme: String) -> URL {
        api.appending(path: "list/mangaByTheme/\(theme)")
    }
}

// MARK: - Demographic Endpoints

extension URL {
    static let demographics = api.appending(path: "list/demographics")
    
    static func searchMangasByDemographic(_ demographic: String) -> URL {
        api.appending(path: "list/mangaByDemographic/\(demographic)")
    }
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

// MARK: - User Endpoints

extension URL {
    static let registerUser = api.appending(path: "users")
    static let loginUser = api.appending(path: "users/login")
    static let renewToken = api.appending(path: "users/renew")
}

// MARK: - User Collection Endpoints

extension URL {
    static let userCollection = api.appending(path: "collection/manga")
    
    static func userCollectionManga(_ mangaID: Int) -> URL {
        api.appending(path: "collection/manga/\(mangaID)")
    }
}
