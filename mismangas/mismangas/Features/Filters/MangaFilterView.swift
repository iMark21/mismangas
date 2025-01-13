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
                        .background(
                            (filter.searchType == .beginsWith ||
                             filter.searchType == .contains ||
                             filter.searchType == .author ||
                             filter.searchType == .genre) && !filter.query.isEmpty ? Color.blue : Color.gray
                        )
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding()
                }
                .disabled(
                    (filter.searchType != .beginsWith &&
                     filter.searchType != .contains &&
                     filter.searchType != .author &&
                     filter.searchType != .genre) || filter.query.isEmpty
                )
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
