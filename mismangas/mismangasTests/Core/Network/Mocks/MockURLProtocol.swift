//
//  MockURLProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 29/1/25.
//


import Foundation
@testable import mismangas

final class MockURLProtocol: URLProtocol {
    static var mockResponse: (Data?, HTTPURLResponse?, APIError?) = (nil, nil, nil)
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let error = MockURLProtocol.mockResponse.2 {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            if let response = MockURLProtocol.mockResponse.1 {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let data = MockURLProtocol.mockResponse.0 {
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocolDidFinishLoading(self)
        }
    }

    override func stopLoading() {}
}
