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
    static func get(_ url: URL, headers: [String: String]? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = URL.timeOut
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Add custom headers
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    static func post(url: URL,
                     body: Encodable? = nil,
                     headers: [String: String] = [:]) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = URL.timeOut
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Add custom headers
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // Add App-Token
        if AppTokenConfig.requiredEndpoints.contains(url) {
            request.setValue(AppTokenConfig.appToken, forHTTPHeaderField: "App-Token")
        }
        
        // Encode JSON body if provided
        if let body = body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        
        return request
    }
    
    static func delete(_ url: URL,
                       headers: [String: String]? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = URL.timeOut
        request.httpMethod = HTTPMethod.delete.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Add custom headers
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
}
