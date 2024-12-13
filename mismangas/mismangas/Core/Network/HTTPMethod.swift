//
//  HTTPMethod.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
    case put = "PUT"
}

extension URLRequest {
    static func get(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = URL.timeOut
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    static func post<JSON: Encodable>(url: URL,
                                      body: JSON,
                                      method: HTTPMethod = .post) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = URL.timeOut
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        return request
    }
    
    static func delete(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = URL.timeOut
        request.httpMethod = HTTPMethod.delete.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
