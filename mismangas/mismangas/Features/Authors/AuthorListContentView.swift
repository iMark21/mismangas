//
//  AuthorListContentView.swift
//  mismangas
//
//  Created by Michel Marques on 12/1/25.
//

import SwiftUI

struct AuthorListContentView: View {
    let items: [Author]
    @Binding var selectedAuthor: String?
    var onSelect: (Author) -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(items, id: \.id) { author in
                    Button {
                        onSelect(author)
                    } label: {
                        HStack {
                            AuthorRowView(author: author)
                            Spacer()
                            if author.fullName == selectedAuthor {
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
    AuthorListContentView(
        items: Author.previewData,
        selectedAuthor: .constant(Author.preview.fullName),
        onSelect: { author in
            Logger.log("Selected author: \(author.fullName)")
        }
    )
}
