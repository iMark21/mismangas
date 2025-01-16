//
//  DemographicPreview.swift
//  mismangas
//
//  Created by Michel Marques on 16/1/25.
//

// MARK: - Mock Data

extension Demographic {
    static var previewData: [Demographic] {
        let response = JSONLoader.load(from: "demographics_mock", as: [DemographicDTO].self)
        return response?.map { $0.toDomain() } ?? []
    }
    
    static var preview: Demographic {
        previewData.first!
    }
}

// MARK: - Mock UseCase

final class MockFetchDemographicUseCase: FetchDemographicsUseCaseProtocol {
    func execute(query: String?, page: Int?, perPage: Int?) async throws -> [Demographic] {
        return Demographic.previewData
    }
}

// MARK: - Preview ViewModel

extension SelectableListViewModel where T == Demographic {
    static var themesPreview: SelectableListViewModel<Demographic> {
        SelectableListViewModel<Demographic>(
            title: "Themes",
            fetchItemsUseCase: MockFetchDemographicUseCase(),
            onSelectItem: { _ in }
        )
    }
}
