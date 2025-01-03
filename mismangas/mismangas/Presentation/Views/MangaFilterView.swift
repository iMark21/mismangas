//
//  MangaFilterView.swift
//  mismangas
//
//  Created by Michel Marques on 24/12/24.
//


import SwiftUI

struct MangaFilterView: View {
    @Binding var filter: MangaFilter
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Body

    var body: some View {
        NavigationView {
            Form {
                Section("Search") {
                    TextField("Search mangas", text: $filter.query)
                    
                    Picker("Search Type", selection: $filter.searchType) {
                        Text("Begins with").tag(SearchType.beginsWith)
                        Text("Contains").tag(SearchType.contains)
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Filters")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Apply") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    MangaFilterView(filter: .constant(MangaFilter.preview))
}
