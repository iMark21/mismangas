//
//  AuthorRowView.swift
//  mismangas
//
//  Created by Michel Marques on 7/1/25.
//


import SwiftUI

struct SelectableRowView<T>: View {
    let item: T
    let content: (T) -> AnyView

    var body: some View {
        content(item)
            .padding(.vertical, 4)
    }
}

#Preview {
    SelectableRowView(
        item: Author(id: "1", fullName: "Hayao Miyazaki", role: .storyAndArt),
        content: { author in
            AnyView(
                AuthorRowView(author: author)
            )
        }
    )
    .padding()
}
