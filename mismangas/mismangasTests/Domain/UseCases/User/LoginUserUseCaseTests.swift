//
//  LoginUserUseCaseTests.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite
struct LoginUserUseCaseTests {
    
    // MARK: - Properties
    
    private var sut: LoginUserUseCase
    private var mockRepository: MockUserRepository
    private var mockKeyChain: MockKeyChainItemManager
    
    // MARK: - Initialization
    
    init() {
        mockRepository = MockUserRepository()
        mockKeyChain = MockKeyChainItemManager()
        sut = LoginUserUseCase(repository: mockRepository, tokenStorage: mockKeyChain)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenValidCredentialsWhenExecuteThenSavesToken() async throws {
        // GIVEN
        let user = User(token: "testToken")
        await mockRepository.setMockLoginUserResult(user)
        
        // WHEN
        try await sut.execute(email: "test@example.com", password: "password123")
        
        // THEN
        let savedToken = try await mockKeyChain.load()
        #expect(savedToken == user.token)
    }
    
    @Test
    func testGivenInvalidCredentialsWhenExecuteThenThrowsError() async {
        // GIVEN
        await mockRepository.setMockLoginUserError(.custom(message: "Invalid credentials"))
        
        // WHEN / THEN
        await #expect(throws: APIError.custom(message: "Invalid credentials")) {
            try await sut.execute(email: "test@example.com", password: "wrongPassword")
        }
    }
    
    @Test
    func testGivenLoginFailsWhenExecuteThenDoesNotSaveToken() async {
        // GIVEN
        await mockRepository.setMockLoginUserError(APIError.custom(message: "Invalid credentials"))
        
        // WHEN / THEN
        await #expect(throws: APIError.custom(message: "Invalid credentials")) {
            try await sut.execute(email: "test@example.com", password: "wrongPassword")
        }
        
        // Check if token was not saved
        let savedToken = try? await mockKeyChain.load()
        #expect(savedToken == nil)
    }
}
