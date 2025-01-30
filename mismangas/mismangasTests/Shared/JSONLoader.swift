//
//  JSONLoader.swift
//  mismangas
//
//  Created by Michel Marques on 29/1/25.
//


import Foundation

enum JSONLoader {
    static func load(_ filename: String) throws -> Data {
        let bundle = Bundle.main
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            throw NSError(domain: "JSONLoader", code: 404, userInfo: [NSLocalizedDescriptionKey: "File not found: \(filename)"])
        }
        return try Data(contentsOf: url)
    }
}
