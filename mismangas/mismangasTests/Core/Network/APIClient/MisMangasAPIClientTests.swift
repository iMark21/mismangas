//
//  MisMangasAPIClientTests.swift
//  mismangas
//
//  Created by Michel Marques on 29/1/25.
//

import Testing
import Foundation
@testable import mismangas

@Suite(.serialized)
struct MisMangasAPIClientTests {
    
    // MARK: - Properties
    
    private var sut: MisMangasAPIClient
    
    // MARK: - Initialization
    
    init() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let mockedSession = URLSession(configuration: config)
        
        MockURLProtocol.mockResponse = (nil, nil, nil)
        sut = MisMangasAPIClient(session: mockedSession)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenSuccessfulResponseWhenFetchingJSONThenReturnsValidObject() async throws {
        // GIVEN
        let mockData = try JSONLoader.load("mangas_mock")
        let response = HTTPURLResponse(url: .mangas, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        MockURLProtocol.mockResponse = (mockData, response, nil)

        let request = URLRequest(url: .mangas)

        // WHEN
        let result: MangaResponseDTO = try await sut.perform(request)

        // THEN
        #expect(!result.items.isEmpty)
        #expect(result.items.count == 10)
        #expect(result.items.map( {$0.toDomain() }) == Manga.previewData)
    }
    
    @Test
    func testGivenServerErrorWhenFetchingMangasThenThrowsAPIError() async {
        // GIVEN
        let response = HTTPURLResponse(url: .mangas, statusCode: 500, httpVersion: nil, headerFields: nil)
        MockURLProtocol.mockResponse = (nil, response, nil)

        let request = URLRequest(url: .mangas)

        // WHEN / THEN
        await #expect(throws: APIError.statusCode(500)) {
            let _: MangaResponseDTO = try await sut.perform(request)
        }
    }

    @Test
    func testGivenPlainTextResponseWhenPerformingRequestThenReturnsString() async throws {
        // GIVEN
        let text = "XYZWD"
        let responseData = text.data(using: .utf8)

        let response = HTTPURLResponse(url: .renewToken, statusCode: 200, httpVersion: nil, headerFields: nil)
        MockURLProtocol.mockResponse = (responseData, response, nil)

        let request = URLRequest(url: .renewToken)

        // WHEN
        let result: String = try await sut.perform(request)

        // THEN
        #expect(result == text)
    }

    @Test
    func testGivenEmptyResponseWhenPerformingRequestThenReturnsVoid() async throws {
        // GIVEN
        let response = HTTPURLResponse(url: .registerUser, statusCode: 204, httpVersion: nil, headerFields: nil)
        MockURLProtocol.mockResponse = (Data(), response, nil)

        let request = URLRequest(url: .registerUser)

        // WHEN
        let _: Void = try await sut.perform(request)
    }
}
