//
//  APIErrorTests.swift
//  mismangasTests
//
//  Created by Michel Marques on 29/01/25.
//

import Testing
@testable import mismangas

@Suite
struct APIErrorTests {
    
    // MARK: - Equality Tests
    
    @Test
    func testGivenSameErrorWhenComparingThenReturnsEqual() {
        let error1 = APIError.statusCode(404)
        let error2 = APIError.statusCode(404)

        #expect(error1 == error2)
    }
    
    @Test
    func testGivenDifferentErrorsWhenComparingThenReturnsNotEqual() {
        let error1 = APIError.statusCode(404)
        let error2 = APIError.statusCode(500)

        #expect(error1 != error2)
    }
    
    @Test
    func testGivenSameCustomMessageWhenComparingThenReturnsEqual() {
        let error1 = APIError.custom(message: "Custom Error")
        let error2 = APIError.custom(message: "Custom Error")

        #expect(error1 == error2)
    }

    // MARK: - Error Descriptions
    
    @Test
    func testGivenInvalidResponseErrorWhenGettingDescriptionThenReturnsExpectedMessage() {
        let error = APIError.invalidResponse
        #expect(error.localizedDescription == "The response is invalid.")
    }
    
    @Test
    func testGivenStatusCodeErrorWhenGettingDescriptionThenReturnsExpectedMessage() {
        let error = APIError.statusCode(500)
        #expect(error.localizedDescription == "Error response with status code: 500.")
    }
    
    @Test
    func testGivenDecodingErrorWhenGettingDescriptionThenReturnsExpectedMessage() {
        let decodingError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Decoding failed"])
        let error = APIError.decodingError(decodingError)

        #expect(error.localizedDescription == "Failed to decode the response: Decoding failed")
    }
    
    @Test
    func testGivenNetworkErrorWhenGettingDescriptionThenReturnsExpectedMessage() {
        let networkError = URLError(.notConnectedToInternet)
        let error = APIError.networkError(networkError)

        #expect(error.localizedDescription.contains("Network error:"))
    }
    
    @Test
    func testGivenUnauthorizedErrorWhenGettingDescriptionThenReturnsExpectedMessage() {
        let error = APIError.unauthorized
        #expect(error.localizedDescription == "Unauthorized user. Please check your credentials.")
    }
    
    @Test
    func testGivenForbiddenErrorWhenGettingDescriptionThenReturnsExpectedMessage() {
        let error = APIError.forbidden
        #expect(error.localizedDescription == "Access denied. You don't have permission for this action.")
    }
    
    @Test
    func testGivenTokenExpiredErrorWhenGettingDescriptionThenReturnsExpectedMessage() {
        let error = APIError.tokenExpired
        #expect(error.localizedDescription == "Your session has expired. Please log in again.")
    }
    
    @Test
    func testGivenBadRequestErrorWhenGettingDescriptionThenReturnsExpectedMessage() {
        let error = APIError.badRequest
        #expect(error.localizedDescription == "Bad request. Please check your input.")
    }
    
    @Test
    func testGivenCustomErrorWhenGettingDescriptionThenReturnsCustomMessage() {
        let error = APIError.custom(message: "Something went wrong")
        #expect(error.localizedDescription == "Something went wrong")
    }
    
    @Test
    func testGivenUnknownErrorWhenGettingDescriptionThenReturnsFormattedMessage() {
        let unknownError = NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unknown failure"])
        let error = APIError.unknown(unknownError)

        #expect(error.localizedDescription == "Unknown error: Unknown failure")
    }
}