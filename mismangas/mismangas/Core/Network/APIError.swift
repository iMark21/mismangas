//
//  APIError.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

enum APIError: LocalizedError {
    case invalidResponse
    case statusCode(Int)
    case decodingError(Error)
    case networkError(URLError)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "La respuesta no es válida."
        case .statusCode(let code):
            return "Respuesta con código de error: \(code)."
        case .decodingError(let error):
            return "Error al decodificar la respuesta: \(error.localizedDescription)"
        case .networkError(let error):
            return "Error de red: \(error.localizedDescription)"
        case .unknown(let error):
            return "Error desconocido: \(error.localizedDescription)"
        }
    }
}
