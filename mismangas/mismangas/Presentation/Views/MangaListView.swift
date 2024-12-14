//
//  ContentView.swift
//  mismangas
//
//  Created by Michel Marques on 10/12/24.
//

import SwiftUI

struct MangaListView: View {
    @State var viewModel: MangaListViewModel

    var body: some View {
        NavigationView {
            List(viewModel.mangas) { manga in
                MangaRowView(manga: manga)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Mangas")
            .onAppear {
                viewModel.fetchMangas()
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage ?? "Unknown Error")
            }
        }
    }
}

#Preview {
    MangaListView(viewModel: .preview)
}
