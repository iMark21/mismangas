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
    
    // Picker
    @State private var showPicker: SearchType?
    
    private var isFilterValid: Bool {
        !filter.query.isEmpty
    }

    var body: some View {
        NavigationStack {
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
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        } else {
                            Text(filter.query.isEmpty ? "Select \(filter.searchType?.rawValue ?? "option")..." : filter.query)
                                .foregroundColor(filter.query.isEmpty ? .blue : .primary)
                                .onTapGesture {
                                    showPicker = filter.searchType
                                }
                        }
                    }
                }
                
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Apply Filter")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isFilterValid ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding()
                })
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
            .sheet(item: $showPicker, content: showSheet)
        }
    }

    private func resetFilters() {
        filter.id = nil
        filter.query = ""
        filter.searchType = .none
        dismiss()
    }
    
    // MARK: - View Builder
    
    @ViewBuilder
    private func showSheet(_ type: SearchType) -> some View {
        
        
        
        switch type {
        case .author:
            SelectableListView(
                viewModel: SelectableListViewModel(
                    title: "Authors",
                    fetchItemsUseCase: FetchAuthorsUseCase(),
                    selectedItem: filter.searchType == .author ? Author(id: filter.id ?? "", fullName: filter.query, role: .story) : nil,
                    onSelectItem: { (selectedAuthor: Author) in
                        filter.query = selectedAuthor.fullName
                        filter.id = selectedAuthor.id
                    }
                )
            )
        case .genre:
            SelectableListView(
                viewModel: SelectableListViewModel(
                    title: "Genres",
                    fetchItemsUseCase: FetchGenresUseCase(),
                    selectedItem: filter.searchType == .genre ? Genre(id: filter.id ?? "", genre: filter.query) : nil,
                    onSelectItem: { (selectedGenre: Genre) in
                        filter.query = selectedGenre.genre
                        filter.id = selectedGenre.id
                    }
                )
            )
        case .theme:
            SelectableListView(
                viewModel: SelectableListViewModel(
                    title: "Themes",
                    fetchItemsUseCase: FetchThemesUseCase(),
                    selectedItem: filter.searchType == .theme ? Theme(id: filter.id ?? "", name: filter.query) : nil,
                    onSelectItem: { (selectedTheme: Theme) in
                        filter.query = selectedTheme.name
                        filter.id = selectedTheme.id
                    }
                )
            )
        case .demographic:
            SelectableListView(
                viewModel: SelectableListViewModel(
                    title: "Demographics",
                    fetchItemsUseCase: FetchDemographicsUseCase(),
                    selectedItem: filter.searchType == .demographic ? Demographic(id: filter.id ?? "", demographic: filter.query) : nil,
                    onSelectItem: { (selectedDemographic: Demographic) in
                        filter.query = selectedDemographic.demographic
                        filter.id = selectedDemographic.id
                    }
                )
            )
        default:
            EmptyView()
        }
    }
}

// MARK: - Preview

#Preview {
    MangaFilterView(filter: .constant(MangaFilter.preview))
}
