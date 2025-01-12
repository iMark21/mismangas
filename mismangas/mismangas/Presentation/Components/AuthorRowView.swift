//
//  AuthorRowView.swift
//  mismangas
//
//  Created by Michel Marques on 7/1/25.
//


import SwiftUI

struct AuthorRowView: View {
    let author: Author

    var body: some View {
        VStack(alignment: .leading) {
            Text(author.fullName)
                .font(.headline)
            Text(author.role.rawValue)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    AuthorRowView(author: Author(id: "1", fullName: "Hayao Miyazaki", role: .storyAndArt))
        .padding()
}
