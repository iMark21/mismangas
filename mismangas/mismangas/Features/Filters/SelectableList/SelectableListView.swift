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
                    .task { viewModel.fetch() }
            }
            .navigationTitle("Select \(viewModel.title)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
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
                    guard let author = item as? Author else { return AnyView(EmptyView()) }
                    return AnyView(AuthorRowView(author: author))
                }
            )
            
        case .error(let message, _):
            ErrorView(
                message: message,
                onRetry: { Task { viewModel.fetch() } }
            )
        }
    }
}
// MARK: - Preview

#Preview {
    SelectableListView(viewModel: .authorsPreview)
}
