//
//  mismangasApp.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import SwiftUI

@main
struct mismangasApp: App {
    var body: some Scene {
        WindowGroup {
            let fetchMangasUseCase = FetchMangasUseCase()
            let viewModel = MangaListViewModel(fetchMangasUseCase: fetchMangasUseCase)
            MangaListView(viewModel: viewModel)
        }
    }
}
