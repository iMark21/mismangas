//
//  RegisterUserViewModelTests.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite
struct RegisterUserViewModelTests {
    
    // MARK: - Properties
    
    private var sut: RegisterUserViewModel
    private var registerUserUseCaseSpy: RegisterUserUseCaseSpy
    private var loginUserUseCaseSpy: LoginUserUseCaseSpy
    
    // MARK: - Initialization
    
    init() {
        registerUserUseCaseSpy = RegisterUserUseCaseSpy()
        loginUserUseCaseSpy = LoginUserUseCaseSpy()
        
        sut = RegisterUserViewModel(
            registerUserUseCase: registerUserUseCaseSpy,
            loginUserUseCase: loginUserUseCaseSpy
        )
    }
    
    // MARK: - Tests
    
    @Test @MainActor
    func testRegisterWithInvalidEmail() async {
        // GIVEN
        sut.email = "invalid-email"
        sut.password = "password123"
        
        // WHEN
        await sut.registerUser()
        
        // THEN
        #expect(sut.state == .registrationFailed(message: "Please enter a valid email."))
    }
    
    @Test @MainActor
    func testRegisterWithShortPassword() async {
        // GIVEN
        sut.email = "test@example.com"
        sut.password = "short"
        
        // WHEN
        await sut.registerUser()
        
        // THEN
        #expect(sut.state == .registrationFailed(message: "Password must be at least 8 characters."))
    }
    
    @Test @MainActor
    func testSuccessfulRegistrationAndLogin() async {
        // GIVEN
        sut.email = "test@example.com"
        sut.password = "password123"
        
        /// Simulate successful registration and login
        await registerUserUseCaseSpy.setMockResult(())
        await loginUserUseCaseSpy.setMockResult(())
        
        // WHEN
        await sut.registerUser()
        
        // THEN
        #expect(sut.state == .authenticated)
    }
    
    @Test @MainActor
    func testRegistrationFailure() async {
        // GIVEN
        sut.email = "test@example.com"
        sut.password = "password123"
        
        /// Simulate registration failure
        await registerUserUseCaseSpy.setMockError(APIError.custom(message: "Registration failed"))
        
        // WHEN
        await sut.registerUser()
        
        // THEN
        #expect(sut.state == .registrationFailed(message: "Registration failed"))
    }
    
    @Test @MainActor
    func testLoginFailureAfterRegistration() async {
        // GIVEN
        sut.email = "test@example.com"
        sut.password = "password123"
        
        /// Simulate successful registration but login failure
        await registerUserUseCaseSpy.setMockResult(())
        await loginUserUseCaseSpy.setMockError(APIError.custom(message: "Login failed"))
        
        // WHEN
        await sut.registerUser()
        
        // THEN
        #expect(sut.state == .registrationFailed(message: "Login failed"))
    }
}
