//
//  AuthorListView.swift
//  mismangas
//
//  Created by Michel Marques on 6/1/25.
//

import SwiftUI

struct AuthorListView: View {
    
    // MARK: - Properties
    
    @State var viewModel: AuthorListViewModel
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                content
                    .searchable(text: $viewModel.searchQuery, prompt: "Search authors")
                    .onChange(of: viewModel.searchQuery) {
                        Task { viewModel.applyQuery() }
                    }
                    .task { viewModel.fetch() }
            }
            .navigationTitle("Select Author")
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
            ProgressMeView(message: "Loading authors...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        case .content(let items):
            AuthorListContentView(
                items: items,
                selectedAuthor: $viewModel.selectedAuthor,
                onSelect: { author in
                    viewModel.selectAuthor(author)
                    dismiss()
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
    AuthorListView(viewModel: .preview)
}
