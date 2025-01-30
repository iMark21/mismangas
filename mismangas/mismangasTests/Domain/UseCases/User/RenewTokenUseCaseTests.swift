//
//  RenewTokenUseCaseTests.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite
struct RenewTokenUseCaseTests {
    
    // MARK: - Properties
    
    private var sut: RenewTokenUseCase
    private var mockRepository: MockUserRepository
    private var mockKeyChain: MockKeyChainItemManager
    
    // MARK: - Initialization
    
    init() {
        mockRepository = MockUserRepository()
        mockKeyChain = MockKeyChainItemManager()
        sut = RenewTokenUseCase(repository: mockRepository, tokenStorage: mockKeyChain)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenValidTokenWhenExecuteThenRenewsTokenSuccessfully() async throws {
        // GIVEN
        let oldToken = "validOldToken"
        let newUser = User(token: "validNewToken")
        
        /// Set the old token in the keychain
        try await mockKeyChain.save(item: oldToken)
        
        /// Set up mock repository to return the new user
        await mockRepository.setMockRenewTokenResult(newUser)
        
        // WHEN
        let result = try await sut.execute()
        
        // THEN
        /// Verify that the new token was saved in the keychain
        let savedToken = try await mockKeyChain.load()
        #expect(savedToken == newUser.token)
        #expect(result == true)
    }
    
    @Test
    func testGivenNoTokenWhenExecuteThenThrowsError() async {
        // GIVEN
        /// No token saved in the keychain
        
        // WHEN / THEN
        await #expect(throws: APIError.custom(message: "No token available")) {
            try await sut.execute()
        }
    }
    
    @Test
    func testGivenRenewTokenFailsWhenExecuteThenThrowsError() async {
        // GIVEN
        let oldToken = "validOldToken"
        try? await mockKeyChain.save(item: oldToken)
        
        /// Simulate failure in renewing the token
        await mockRepository.setMockRenewTokenError(.custom(message: "Token renewal failed"))
        
        // WHEN
        let result = try? await sut.execute()
        
        // THEN
        #expect(result == false)
    }
}
