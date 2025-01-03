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
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select filter", selection: $filter.searchType) {
                    Text("Begins with").tag(SearchType.beginsWith)
                    Text("Contains").tag(SearchType.contains)
                    Text("Author").tag(SearchType.author)
                    Text("Genre").tag(SearchType.genre)
                    Text("Theme").tag(SearchType.theme)
                    Text("Demographic").tag(SearchType.demographic)
                }
                .pickerStyle(.automatic)
                .padding()
                
                Spacer()
                                
                Button(action: {
                    dismiss()
                }) {
                    Text("Apply Filter")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            (filter.searchType == .beginsWith || filter.searchType == .contains) && !filter.query.isEmpty ? Color.blue : Color.gray
                        )
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(
                    (filter.searchType != .beginsWith && filter.searchType != .contains) || filter.query.isEmpty
                )
                .padding()
            }
            .onAppear {
                if filter.searchType == nil {
                    filter.searchType = .beginsWith
                }
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $filter.query)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Reset") {
                        resetFilters()
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
    
    // MARK: - Reset Filters
    private func resetFilters() {
        filter.query = ""
        filter.searchType = .none
        dismiss()
    }
}

// MARK: - Preview

#Preview {
    MangaFilterView(filter: .constant(MangaFilter.preview))
}
