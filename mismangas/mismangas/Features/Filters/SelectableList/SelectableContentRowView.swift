//
//  SelectableContentRowView.swift
//  mismangas
//
//  Created by Michel Marques on 12/1/25.
//

import SwiftUI

struct SelectableContentRowView<T>: View {
    let item: T
    let title: (T) -> String
    let subtitle: ((T) -> String)?

    var body: some View {
        VStack(alignment: .leading) {
            Text(title(item))
                .font(.headline)
            if let subtitle = subtitle {
                Text(subtitle(item))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    VStack {
        SelectableContentRowView(item: Author.preview,
                title: { $0.fullName },
                subtitle: { $0.role.rawValue })
            .padding()

        SelectableContentRowView(item: Genre.preview,
                title: { $0.genre },
                subtitle: nil)
            .padding()
    }
}
