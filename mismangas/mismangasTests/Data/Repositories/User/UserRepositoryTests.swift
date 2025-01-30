//
//  UserRepositoryTests.swift
//  mismangas
//
//  Created by Michel Marques on 29/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite
struct UserRepositoryTests {
    
    // MARK: - Properties
    
    private var sut: UserRepository
    private var mockAPIClient: MockAPIClient
    
    // MARK: - Initialization
    
    init() {
        mockAPIClient = MockAPIClient()
        sut = UserRepository(client: mockAPIClient)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenValidCredentialsWhenRegisteringUserThenPerformsSuccessfully() async throws {
        // GIVEN
        let email = "test@example.com"
        let password = "password123"
        
        await mockAPIClient.setMockResult(Void())
        
        // WHEN
        try await sut.registerUser(email: email, password: password)
        
        // THEN
        await #expect(mockAPIClient.mockResult as? Void != nil)
    }
    
    @Test
    func testGivenInvalidCredentialsWhenRegisteringUserThenThrowsError() async {
        // GIVEN
        let email = "test@example.com"
        let password = "password123"
        
        await mockAPIClient.setMockError(APIError.custom(message: "Invalid credentials"))
        
        // WHEN / THEN
        await #expect(throws: APIError.custom(message: "Invalid credentials")) {
            try await sut.registerUser(email: email, password: password)
        }
    }
    
    @Test
    func testGivenValidCredentialsWhenLoginUserThenReturnsUser() async throws {
        // GIVEN
        let email = "test@example.com"
        let password = "password123"
        
        let token = "token"
        await mockAPIClient.setMockResult(token)
        
        // WHEN
        let user = try await sut.loginUser(email: email, password: password)
        
        // THEN
        #expect(user.token == token)
    }
    
    @Test
    func testGivenInvalidCredentialsWhenLoginUserThenThrowsError() async {
        // GIVEN
        let email = "test@example.com"
        let password = "password123"
        
        await mockAPIClient.setMockError(.custom(message: "Invalid credentials"))
        
        // WHEN / THEN
        await #expect(throws: APIError.custom(message: "Invalid credentials")) {
            try await sut.loginUser(email: email, password: password)
        }
    }
    
    @Test
    func testGivenValidTokenWhenRenewingTokenThenReturnsUser() async throws {
        // GIVEN
        let token = "validToken123"
        
        let newToken = "new_token"
        await mockAPIClient.setMockResult(newToken)
        
        // WHEN
        let user = try await sut.renewToken(token)
        
        // THEN
        #expect(user.token == newToken)
    }
    
    @Test
    func testGivenInvalidTokenWhenRenewingTokenThenThrowsError() async {
        // GIVEN
        let token = "invalidToken123"
        
        await mockAPIClient.setMockError(.custom(message: "Invalid token"))
        
        // WHEN / THEN
        await #expect(throws: APIError.custom(message: "Invalid token")) {
            try await sut.renewToken(token)
        }
    }
}
