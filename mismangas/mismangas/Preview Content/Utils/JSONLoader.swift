//
//  JSONLoader.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

struct JSONLoader {
    static func load<T: Decodable>(from filename: String, as type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("Error: No se encontró el archivo \(filename).json en el bundle.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Error al cargar \(filename).json: \(error.localizedDescription)")
            return nil
        }
    }
}
