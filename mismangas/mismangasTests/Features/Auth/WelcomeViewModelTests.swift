//
//  WelcomeViewModelTests.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite @MainActor
struct WelcomeViewModelTests {
    
    // MARK: - Properties
    
    private var sut: WelcomeViewModel
    private var renewTokenUseCaseSpy: RenewTokenUseCaseSpy
    private var mockCollectionManager: MangaCollectionManagerProtocol
    private var modelContext: ModelContextProtocol
    
    // MARK: - Initialization
    
    init() {
        renewTokenUseCaseSpy = RenewTokenUseCaseSpy()
        
        let manageMangaCollectionUseCase = MockManageMangaCollectionUseCase()
        mockCollectionManager = MangaCollectionManager(useCase: manageMangaCollectionUseCase)
        
        sut = WelcomeViewModel(
            renewTokenUseCase: renewTokenUseCaseSpy,
            collectionManager: mockCollectionManager
        )
        
        modelContext = MockModelContext()
    }
    
    // MARK: - Tests
    
    @Test
    func testStateChangesToUnauthenticatedWhenTryingToAuthenticating() async {
        // GIVEN
        await renewTokenUseCaseSpy.setMockResult(false)
        
        // WHEN
        await sut.checkAuthentication(using: modelContext)
        
        // THEN
        #expect(sut.state == .unauthenticated)
    }
    
    @Test
    func testStateChangesToAuthenticatedWhenSuccessfulAuthentication() async {
        // GIVEN
        await renewTokenUseCaseSpy.setMockResult(true)
        
        // WHEN
        await sut.checkAuthentication(using: modelContext)
        
        // THEN
        #expect(sut.state == .authenticated)
    }
    
    @Test
    func testStateChangesToUnauthenticatedWhenAuthenticationFails() async {
        // GIVEN
        await renewTokenUseCaseSpy.setMockResult(false)
        
        // WHEN
        await sut.checkAuthentication(using: modelContext)
        
        // THEN
        #expect(sut.state == .unauthenticated)
    }
    
    @Test
    func testStateChangesToAuthenticatedWhenSync() async {
        // GIVEN
        await renewTokenUseCaseSpy.setMockResult(true)
        
        // WHEN
        await sut.checkAuthentication(using: modelContext)
        
        // THEN
        #expect(sut.state == .authenticated)
    }
    
    @Test
    func testLogsErrorWhenAuthenticationFails() async {
        // GIVEN
        await renewTokenUseCaseSpy.setMockError(.custom(message: "Token renewal failed"))
        
        // WHEN
        await sut.checkAuthentication(using: modelContext)
        
        // THEN
        /// Verify that the error is logged
        #expect(sut.state == .unauthenticated)
    }
}
