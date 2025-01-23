//
//  FetchThemesUseCase.swift
//  mismangas
//
//  Created by Michel Marques on 16/1/25.
//

import Foundation

struct FetchThemesUseCase: FetchThemesUseCaseProtocol {
    
    let repository: ThemeRepositoryProtocol = ThemeRepository()

    func execute() async throws -> [Theme] {
        // Fetch all themes from the repository
        return try await repository.fetchThemes()
    }
}
