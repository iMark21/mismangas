//
//  MangaFilterView.swift
//  mismangas
//
//  Created by Michel Marques on 24/12/24.
//

import SwiftUI

struct MangaFilterView: View {
    @State var viewModel: MangaFilterViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Group {
            if isMac {
                macOSLayout
            } else {
                iOSLayout
            }
        }
        .frame(minWidth: isMac ? 500 : nil, minHeight: isMac ? 400 : nil)
    }
    
    private var macOSLayout: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Text("Filters")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Button("Cancel") {
                        cancel()
                    }
                    .keyboardShortcut(.cancelAction)
                    .padding(.trailing)
                }
                .padding()

                Divider()

                VStack {
                    Form {
                        filterPickerSection
                        queryFieldSection
                    }
                    .padding()
                    Spacer()
                    applyFilterButton
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .platformNavigationBarTitle()
            .platformModalPresentation(item: $viewModel.showPicker) { type in
                showSheet(type)
            }
        }
    }
    // MARK: - iOS Layout
    private var iOSLayout: some View {
        NavigationStack {
            VStack {
                Form {
                    filterPickerSection
                    queryFieldSection
                }

                applyFilterButton
            }
            .navigationTitle("Filters")
            .platformNavigationBarTitle()
            .platformToolbar(
                resetAction: {
                    cancel()
                }
            )
            .platformModalPresentation(item: $viewModel.showPicker) { type in
                showSheet(type)
            }
        }
    }

    // MARK: - Sections
    @ViewBuilder
    private var filterPickerSection: some View {
        Section {
            HStack {
                Text("Select filter")
                Spacer()
                Picker("", selection: $viewModel.filter.searchType) {
                    Text("Begins with").tag(SearchType.beginsWith)
                    Text("Contains").tag(SearchType.contains)
                    Text("Author").tag(SearchType.author)
                    Text("Genre").tag(SearchType.genre)
                    Text("Theme").tag(SearchType.theme)
                    Text("Demographic").tag(SearchType.demographic)
                }
                .pickerStyle(.menu)
                .onChange(of: viewModel.filter.searchType) {
                    viewModel.resetQueryIfNeeded()
                }
            }
        }
    }

    @ViewBuilder
    private var queryFieldSection: some View {
        Section {
            if viewModel.filter.searchType == .beginsWith || viewModel.filter.searchType == .contains {
                TextField("Type text", text: $viewModel.filter.query)
                    .platformAutoCapitalization()
                    .disableAutocorrection(true)
            } else {
                Text(viewModel.filter.query.isEmpty ? "Select \(viewModel.filter.searchType?.rawValue ?? "option")..." : viewModel.filter.query)
                    .foregroundColor(viewModel.filter.query.isEmpty ? .blue : .primary)
                    .onTapGesture {
                        viewModel.showPicker = viewModel.filter.searchType
                        print("showPicker updated to: \(String(describing: viewModel.showPicker))")
                    }
            }
        }
    }

    @ViewBuilder
    private var applyFilterButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            Text("Apply Filter")
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.isFilterValid ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding()
        })
        .disabled(!viewModel.isFilterValid)
    }

    @ViewBuilder
    private func showSheet(_ type: SearchType) -> some View {
        switch type {
        case .author:
            SelectableListView(
                viewModel: SelectableListViewModel(
                    title: "Authors",
                    fetchItemsUseCase: FetchAuthorsUseCase(),
                    selectedItem: viewModel.filter.searchType == .author ? Author(id: viewModel.filter.id ?? "", fullName: viewModel.filter.query, role: .story) : nil,
                    onSelectItem: { (selectedAuthor: Author) in
                        viewModel.updateSelectedItem(for: .author, id: selectedAuthor.id, query: selectedAuthor.fullName)
                    }
                )
            )
        case .genre:
            SelectableListView(
                viewModel: SelectableListViewModel(
                    title: "Genres",
                    fetchItemsUseCase: FetchGenresUseCase(),
                    selectedItem: viewModel.filter.searchType == .genre ? Genre(id: viewModel.filter.id ?? "", genre: viewModel.filter.query) : nil,
                    onSelectItem: { (selectedGenre: Genre) in
                        viewModel.updateSelectedItem(for: .genre, id: selectedGenre.id, query: selectedGenre.genre)
                    }
                )
            )
        case .theme:
            SelectableListView(
                viewModel: SelectableListViewModel(
                    title: "Themes",
                    fetchItemsUseCase: FetchThemesUseCase(),
                    selectedItem: viewModel.filter.searchType == .theme ? Theme(id: viewModel.filter.id ?? "", name: viewModel.filter.query) : nil,
                    onSelectItem: { (selectedTheme: Theme) in
                        viewModel.updateSelectedItem(for: .theme, id: selectedTheme.id, query: selectedTheme.name)
                    }
                )
            )
        case .demographic:
            SelectableListView(
                viewModel: SelectableListViewModel(
                    title: "Demographics",
                    fetchItemsUseCase: FetchDemographicsUseCase(),
                    selectedItem: viewModel.filter.searchType == .demographic ? Demographic(id: viewModel.filter.id ?? "", demographic: viewModel.filter.query) : nil,
                    onSelectItem: { (selectedDemographic: Demographic) in
                        viewModel.updateSelectedItem(for: .demographic, id: selectedDemographic.id, query: selectedDemographic.demographic)
                    }
                )
            )
        default:
            EmptyView()
        }
    }
    
    private func cancel() {
        viewModel.resetFilters()
        dismiss()
    }
}

// MARK: - Preview

#Preview {
    MangaFilterView(viewModel: MangaFilterViewModel(filter: .preview))
}
