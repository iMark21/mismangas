//
//  HomeViewModel.swift
//  mismangas
//
//  Created by Michel Marques on 20/1/25.
//

import Foundation

@Observable @MainActor
final class HomeViewModel {
    // MARK: - Properties
    
    /// Use cases
    private let bestMangasUseCase: FetchBestMangasUseCaseProtocol
    private let genresUseCase: any FetchGenresUseCaseProtocol
    private let themesUseCase: any FetchThemesUseCaseProtocol
    private let demographicsUseCase: any FetchDemographicsUseCaseProtocol

    /// Data
    var bestMangas: [Manga] = []
    var genres: [Genre] = []
    var themes: [Theme] = []
    var demographics: [Demographic] = []

    /// Loading states
    var isLoadingMangas: Bool = true
    var isLoadingGenres: Bool = true
    var isLoadingThemes: Bool = true
    var isLoadingDemographics: Bool = true
    
    // MARK: - Init
    
    init(bestMangasUseCase: FetchBestMangasUseCaseProtocol = FetchBestMangasUseCase(),
         genresUseCase: any FetchGenresUseCaseProtocol = FetchGenresUseCase(),
         demographics: any FetchDemographicsUseCaseProtocol = FetchDemographicsUseCase(),
         themesUseCase: any FetchThemesUseCaseProtocol = FetchThemesUseCase()) {
        self.bestMangasUseCase = bestMangasUseCase
        self.genresUseCase = genresUseCase
        self.themesUseCase = themesUseCase
        self.demographicsUseCase = demographics
        
        Task { 
            await fetchData()
        }
    }
    
    // MARK: - Public Methods
    
    func fetchData() async {
        await fetchBestMangas()
        await fetchGenres()
        await fetchThemes()
        await fetchDemographics()
    }
    
    // MARK: - Private Fetch Methods
    
    private func fetchBestMangas() async {
        isLoadingMangas = true
        defer { isLoadingMangas = false }
        do {
            bestMangas = try await bestMangasUseCase.execute()
        } catch {
            Logger.logErrorMessage("Error fetching best mangas: \(error.localizedDescription)")
            bestMangas = []
        }
    }
    
    private func fetchGenres() async {
        isLoadingGenres = true
        defer { isLoadingGenres = false }
        do {
            genres = try await genresUseCase.execute()
        } catch {
            Logger.logErrorMessage("Error fetching genres: \(error.localizedDescription)")
            genres = []
        }
    }
    
    private func fetchThemes() async {
        isLoadingThemes = true
        defer { isLoadingThemes = false }
        do {
            themes = try await themesUseCase.execute()
        } catch {
            Logger.logErrorMessage("Error fetching themes: \(error.localizedDescription)")
            themes = []
        }
    }
    
    private func fetchDemographics() async {
        isLoadingDemographics = true
        defer { isLoadingDemographics = false }
        do {
            demographics = try await demographicsUseCase.execute()
        } catch {
            Logger.logErrorMessage("Error fetching demographics: \(error.localizedDescription)")
            demographics = []
        }
    }
}
