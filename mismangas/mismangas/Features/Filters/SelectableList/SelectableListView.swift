//
//  AuthorListView.swift
//  mismangas
//
//  Created by Michel Marques on 6/1/25.
//

import SwiftUI

struct SelectableListView<T: Identifiable & Hashable & Searchable>: View {
    
    // MARK: - Properties
    
    @State var viewModel: SelectableListViewModel<T>
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                content
                    .searchable(text: $viewModel.searchQuery, prompt: "Search \(viewModel.title)")
                    .onChange(of: viewModel.searchQuery) {
                        Task { viewModel.applyQuery() }
                    }
                    .task {
                        await viewModel.fetch()
                    }
            }
            .navigationTitle("Select \(viewModel.title)")
            .platformNavigationBarTitle()
            .platformToolbar(cancelAction: { dismiss() })
        }
    }
    
    // MARK: - Content
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressMeView(message: "Loading \(viewModel.title)...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        case .content(let items):
            SelectableListContentView(
                items: items,
                selectedItem: $viewModel.selectedItem,
                onSelect: { item in
                    viewModel.selectItem(item)
                    dismiss()
                },
                content: { item in
                    if let author = item as? Author {
                        return AnyView(
                            SelectableContentRowView(
                                item: author,
                                title: { $0.fullName },
                                subtitle: { $0.role.rawValue }
                            )
                        )
                    } else if let genre = item as? Genre {
                        return AnyView(
                            SelectableContentRowView(
                                item: genre,
                                title: { $0.genre },
                                subtitle: nil
                            )
                        )
                    } else if let theme = item as? Theme {
                        return AnyView(
                            SelectableContentRowView(
                                item: theme,
                                title: { $0.name },
                                subtitle: nil
                            )
                        )
                    } else if let demographic = item as? Demographic {
                        return AnyView(
                            SelectableContentRowView(
                                item: demographic,
                                title: { $0.demographic },
                                subtitle: nil
                            )
                        )
                    } else {
                        return AnyView(EmptyView())
                    }
                }
            )
            
        case .error(let message, _):
            ErrorView(
                message: message,
                onRetry: { Task { await viewModel.fetch() } }
            )
        }
    }
}
// MARK: - Preview

#Preview {
    SelectableListView(viewModel: .authorsPreview)
}
