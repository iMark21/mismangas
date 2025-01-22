//
//  ThemePreview.swift
//  mismangas
//
//  Created by Michel Marques on 16/1/25.
//

// MARK: - Mock Data

extension Theme {
    static var previewData: [Theme] {
        let response = JSONLoader.load(from: "themes_mock", as: [ThemeDTO].self)
        return response?.map { $0.toDomain() } ?? []
    }
    
    static var preview: Theme {
        previewData.first!
    }
}

// MARK: - Mock UseCase

final class MockFetchThemeUseCase: FetchThemesUseCaseProtocol {
    func execute() async throws -> [Theme] {
        return Theme.previewData
    }
}

// MARK: - Preview ViewModel

extension SelectableListViewModel where T == Theme {
    static var themesPreview: SelectableListViewModel<Theme> {
        SelectableListViewModel<Theme>(
            title: "Themes",
            fetchItemsUseCase: MockFetchThemeUseCase(),
            onSelectItem: { _ in }
        )
    }
}
