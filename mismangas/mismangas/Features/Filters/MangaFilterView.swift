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
    
    // Pickers
    @State private var showAuthorPicker = false
    @State private var showGenrePicker = false
    @State private var showThemePicker = false
    @State private var showDemographicPicker = false
    
    private var isFilterValid: Bool {
        [.beginsWith, .contains, .author, .genre, .theme, .demographic]
            .contains(filter.searchType) && !filter.query.isEmpty
    }

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        HStack {
                            Text("Select filter")
                            Spacer()
                            Picker("", selection: $filter.searchType) {
                                Text("Begins with").tag(SearchType.beginsWith)
                                Text("Contains").tag(SearchType.contains)
                                Text("Author").tag(SearchType.author)
                                Text("Genre").tag(SearchType.genre)
                                Text("Theme").tag(SearchType.theme)
                                Text("Demographic").tag(SearchType.demographic)
                            }
                            .pickerStyle(.menu)
                            .onChange(of: filter.searchType) {
                                filter.query = ""
                            }
                        }
                    }

                    Section {
                        if filter.searchType == .beginsWith || filter.searchType == .contains {
                            TextField("Type text", text: $filter.query)
                        } else if filter.searchType == .author {
                            Text(filter.query.isEmpty ? "Select an author..." : filter.query)
                                .foregroundColor(filter.query.isEmpty ? .blue : .primary)
                                .onTapGesture {
                                    showAuthorPicker = true
                                }
                        } else if filter.searchType == .genre {
                            Text(filter.query.isEmpty ? "Select a genre..." : filter.query)
                                .foregroundColor(filter.query.isEmpty ? .blue : .primary)
                                .onTapGesture {
                                    showGenrePicker = true
                                }
                        } else if filter.searchType == .theme {
                            Text(filter.query.isEmpty ? "Select a theme..." : filter.query)
                                .foregroundColor(filter.query.isEmpty ? .blue : .primary)
                                .onTapGesture {
                                    showThemePicker = true
                                }
                        } else if filter.searchType == .demographic {
                            Text(filter.query.isEmpty ? "Select a demographic..." : filter.query)
                                .foregroundColor(filter.query.isEmpty ? .blue : .primary)
                                .onTapGesture {
                                    showDemographicPicker = true
                                }
                        } else {
                            Text("Coming soon")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                    }
                }

                Button(action: {
                    dismiss()
                }) {
                    Text("Apply Filter")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isFilterValid ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding()
                }
                .disabled(!isFilterValid)
            }
            .onAppear {
                filter.searchType = filter.searchType == .none ? .beginsWith : filter.searchType
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Reset") {
                        resetFilters()
                    }
                    .foregroundColor(.red)
                }
            }
            .sheet(isPresented: $showAuthorPicker) {
                SelectableListView(
                    viewModel: SelectableListViewModel(
                        title: "Authors",
                        fetchItemsUseCase: FetchAuthorsUseCase(),
                        onSelectItem: { (selectedAuthor: Author) in
                            filter.query = selectedAuthor.fullName
                            filter.id = selectedAuthor.id
                        }
                    )
                )
            }
            .sheet(isPresented: $showGenrePicker) {
                SelectableListView(
                    viewModel: SelectableListViewModel(
                        title: "Genres",
                        fetchItemsUseCase: FetchGenresUseCase(),
                        onSelectItem: { (selectedGenre: Genre) in
                            filter.query = selectedGenre.genre
                            filter.id = selectedGenre.id
                        }
                    )
                )
            }
            .sheet(isPresented: $showThemePicker) {
                SelectableListView(
                    viewModel: SelectableListViewModel(
                        title: "Themes",
                        fetchItemsUseCase: FetchThemesUseCase(),
                        onSelectItem: { (selectedTheme: Theme) in
                            filter.query = selectedTheme.name
                            filter.id = selectedTheme.id
                        }
                    )
                )
            }
            .sheet(isPresented: $showDemographicPicker) {
                SelectableListView(
                    viewModel: SelectableListViewModel(
                        title: "Demographics",
                        fetchItemsUseCase: FetchDemographicsUseCase(),
                        onSelectItem: { (selectedDemographic: Demographic) in
                            filter.query = selectedDemographic.demographic
                            filter.id = selectedDemographic.id
                        }
                    )
                )
            }
        }
    }

    private func resetFilters() {
        filter.id = nil
        filter.query = ""
        filter.searchType = .none
        dismiss()
    }
}

// MARK: - Preview

#Preview {
    MangaFilterView(filter: .constant(MangaFilter.preview))
}
