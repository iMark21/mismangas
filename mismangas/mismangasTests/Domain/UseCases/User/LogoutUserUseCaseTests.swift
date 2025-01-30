//
//  LogoutUserUseCaseTests.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite
struct LogoutUserUseCaseTests {
    
    // MARK: - Properties
    
    private var sut: LogoutUserUseCase
    private var mockKeyChain: MockKeyChainItemManager
    
    // MARK: - Initialization
    
    init() {
        mockKeyChain = MockKeyChainItemManager()
        sut = LogoutUserUseCase(tokenStorage: mockKeyChain)
    }
    
    // MARK: - Tests
    
    @Test
    func testWhenExecuteThenDeletesToken() async throws {
        // GIVEN
        let token = "validToken123"
        try await mockKeyChain.save(item: token)
        
        // WHEN
        try await sut.execute()
        
        // THEN
        let savedToken = try await mockKeyChain.load()
        #expect(savedToken == nil)
    }
    
    @Test
    func testWhenDeleteFailsThenThrowsError() async {
        // GIVEN
        await mockKeyChain.setShouldThrowDeleteError(true)
        
        // WHEN / THEN
        await #expect(throws: APIError.custom(message: "Deletion failed")) {
            try await sut.execute()
        }
    }
}
