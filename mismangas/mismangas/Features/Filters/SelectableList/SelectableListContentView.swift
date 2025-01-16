//
//  AuthorListContentView.swift
//  mismangas
//
//  Created by Michel Marques on 12/1/25.
//

import SwiftUI

struct SelectableListContentView<T: Identifiable & Hashable>: View {
    let items: [T]
    @Binding var selectedItem: T?
    var onSelect: (T) -> Void
    var content: (T) -> AnyView

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(items, id: \.id) { item in
                    Button {
                        onSelect(item)
                    } label: {
                        HStack {
                            content(item)
                            Spacer()
                            if item == selectedItem {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Preview

#Preview {
    SelectableListContentView(
        items: Author.previewData,
        selectedItem: .constant(Author.preview),
        onSelect: { author in
            Logger.log("Selected item: \(author.fullName)")
        },
        content: { author in
            AnyView(
                SelectableRowView(
                    item: author,
                    content: { selectedAuthor in
                        AnyView(
                            SelectableContentRowView(
                                item: selectedAuthor,
                                title: { $0.fullName },
                                subtitle: { $0.role.rawValue }
                            )
                        )
                    }
                )
            )
        }
    )
}
