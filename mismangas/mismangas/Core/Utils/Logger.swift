//
//  Logger.swift
//  mismangas
//
//  Created by Michel Marques on 17/12/24.
//


import Foundation

struct Logger {
    // MARK: - Log Levels
    enum LogLevel: String {
        case info = "ℹ️ [INFO]"
        case error = "❌ [ERROR]"
        case debug = "🐞 [DEBUG]"
    }

    // MARK: - Static Methods
    static func log(_ message: String,
                    level: LogLevel = .info,
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {
        #if DEBUG
        let filename = (file as NSString).lastPathComponent
        let timestamp = ISO8601DateFormatter().string(from: Date())
        print("\(timestamp) \(level.rawValue) [\(filename):\(line) \(function)] - \(message)")
        #endif
    }

    static func logRequest(_ request: URLRequest) {
        guard let url = request.url else { return }
        log("[REQUEST] \(request.httpMethod ?? "GET") \(url.absoluteString)", level: .debug)

        if let headers = request.allHTTPHeaderFields {
            log("[REQUEST HEADERS] \(headers)", level: .debug)
        }

        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            log("[REQUEST BODY] \(bodyString)", level: .debug)
        }
    }

    static func logResponse(_ response: URLResponse, data: Data?) {
        if let httpResponse = response as? HTTPURLResponse {
            log("[RESPONSE] \(httpResponse.statusCode) - \(httpResponse.url?.absoluteString ?? "")", level: .debug)
        }

        if let data = data, let responseString = String(data: data, encoding: .utf8) {
            log("[RESPONSE BODY] \(responseString)", level: .debug)
        }
    }

    static func logError(_ error: Error) {
        log("[ERROR] \(error.localizedDescription)", level: .error)
    }
    
    static func logErrorMessage(_ message: String,
                                file: String = #file,
                                function: String = #function,
                                line: Int = #line) {
        log("[ERROR] \(message)", level: .error, file: file, function: function, line: line)
    }
}
