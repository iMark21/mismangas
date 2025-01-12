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
    @State private var showAuthorPicker = false

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
                            (filter.searchType == .beginsWith || filter.searchType == .contains || filter.searchType == .author) && !filter.query.isEmpty ? Color.blue : Color.gray
                        )
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding()
                }
                .disabled(
                    (filter.searchType != .beginsWith && filter.searchType != .contains && filter.searchType != .author) || filter.query.isEmpty
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
                        selectedItem: nil,
                        onSelectItem: { (selectedAuthor: Author) in
                            filter.query = selectedAuthor.fullName
                            filter.id = selectedAuthor.id
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
