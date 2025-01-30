//
//  RegisterUserUseCaseTests.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite
struct RegisterUserUseCaseTests {
    
    // MARK: - Properties
    
    private var sut: RegisterUserUseCase
    private var mockRepository: MockUserRepository
    
    // MARK: - Initialization
    
    init() {
        mockRepository = MockUserRepository()
        sut = RegisterUserUseCase(repository: mockRepository)
    }
    
    // MARK: - Tests
    
    @Test
    func testGivenValidCredentialsWhenExecuteThenRegisterUser() async throws {
        // GIVEN
        let email = "test@example.com"
        let password = "password123"
        await mockRepository.setMockRegisterUserResult(())
        
        // WHEN
        try await sut.execute(email: email, password: password)
        
        // THEN
        await #expect(mockRepository.mockRegisterUserResult != nil)
    }
    
    @Test
    func testGivenInvalidCredentialsWhenExecuteThenThrowsError() async {
        // GIVEN
        let email = "test@example.com"
        let password = "wrongPassword"
        await mockRepository.setMockRegisterUserError(.custom(message: "Invalid credentials"))
        
        // WHEN / THEN
        await #expect(throws: APIError.custom(message: "Invalid credentials")) {
            try await sut.execute(email: email, password: password)
        }
    }
}
