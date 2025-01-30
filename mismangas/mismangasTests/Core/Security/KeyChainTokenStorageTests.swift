//
//  KeyChainTokenStorageTests.swift
//  mismangas
//
//  Created by Michel Marques on 29/1/25.
//

import Testing
@testable import mismangas

@Suite(.serialized)
struct KeyChainTokenStorageTests {
    
    // MARK: - Properties
    
    private var sut: KeyChainTokenStorage
    
    // MARK: - Initialization
    
    init() {
        sut = KeyChainTokenStorage(service: "testService")
        try? sut.delete()
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenValidTokenWhenSavingThenCanRetrieveIt() async throws {
        // GIVEN
        let token = "testAuthToken123"
        
        // WHEN
        try sut.save(item: token)
        let retrievedToken = try sut.load()
        
        // THEN
        #expect(retrievedToken == token)
    }
    
    @Test
    func testGivenNoTokenWhenLoadingThenReturnsNil() async throws {
        // GIVEN / WHEN
        let retrievedToken = try sut.load()
        
        // THEN
        #expect(retrievedToken == nil)
    }
    
    @Test
    func testGivenStoredTokenWhenDeletingThenLoadReturnsNil() async throws {
        // GIVEN
        let token = "toBeDeletedToken"
        try sut.save(item: token)
        
        // WHEN
        try sut.delete()
        let retrievedToken = try sut.load()
        
        // THEN
        #expect(retrievedToken == nil)
    }
}
