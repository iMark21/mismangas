//
//  LoginUserViewModelTests.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite @MainActor
struct LoginUserViewModelTests {
    
    // MARK: - Properties
    
    private var sut: LoginUserViewModel
    private var loginUserUseCaseSpy: LoginUserUseCaseSpy
    private var mockMangaCollectionManager: MangaCollectionManagerProtocol
    private var modelContext: ModelContextProtocol
    
    // MARK: - Initialization
    
    init() {
        loginUserUseCaseSpy = LoginUserUseCaseSpy()
        let manageMangaCollectionUseCase = MockManageMangaCollectionUseCase()
        mockMangaCollectionManager = MangaCollectionManager(useCase: manageMangaCollectionUseCase)
        
        sut = LoginUserViewModel(
            loginUserUseCase: loginUserUseCaseSpy,
            syncManager: mockMangaCollectionManager
        )
        
        modelContext = MockModelContext()
    }
    
    // MARK: - Tests
    
    @Test
    func testLoginWithInvalidEmail() async {
        // GIVEN
        sut.email = "invalid-email"
        sut.password = "password123"
        
        // WHEN
        await sut.login(using: modelContext)
        
        // THEN
        #expect(sut.state == .error(message: "Invalid email format."))
    }
    
    @Test
    func testLoginWithEmptyPassword() async {
        // GIVEN
        sut.email = "test@example.com"
        sut.password = ""
        
        // WHEN
        await sut.login(using: modelContext)
        
        // THEN
        #expect(sut.state == .error(message: "Password cannot be empty."))
    }
    
    @Test
    func testSuccessfulLoginAndSync() async {
        // GIVEN
        sut.email = "test@example.com"
        sut.password = "password123"
        
        /// Set up mocks
        await loginUserUseCaseSpy.setMockResult(())
        
        // WHEN
        await sut.login(using: modelContext)
        
        // THEN
        #expect(sut.state == .success)
    }
    
    @Test
    func testLoginFailure() async {
        // GIVEN
        sut.email = "test@example.com"
        sut.password = "password123"
        
        /// Simulate login failure
        await loginUserUseCaseSpy.setMockError(.custom(message: "Invalid credentials"))
        
        // WHEN
        await sut.login(using: modelContext)
        
        // THEN
        #expect(sut.state == .error(message: "Invalid credentials"))
    }
    
    @Test
    func testSyncFailure() async {
        // GIVEN
        sut.email = "test@example.com"
        sut.password = "password123"
        
        /// Simulate successful login and sync failure
        await loginUserUseCaseSpy.setMockError(.custom(message: "Sync failed"))
        
        // WHEN
        await sut.login(using: modelContext)
        
        // THEN
        #expect(sut.state == .error(message: "Sync failed"))
    }
}
