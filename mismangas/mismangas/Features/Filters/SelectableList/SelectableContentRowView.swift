//
//  SelectableContentRowView.swift
//  mismangas
//
//  Created by Michel Marques on 12/1/25.
//

import SwiftUI

struct SelectableContentRowView<T>: View {
    
    // MARK: - Properties

    let item: T
    let title: (T) -> String
    let subtitle: ((T) -> String)?

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(title(item))
                .font(.headline)
                .foregroundColor( .primary)
            if let subtitle = subtitle {
                Text(subtitle(item))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    VStack {
        SelectableContentRowView(item: Author.preview,
                                 title: { $0.fullName },
                                 subtitle: { $0.role.rawValue })

        SelectableContentRowView(item: Genre.preview,
                                 title: { $0.genre },
                                 subtitle: nil)
    }
}
