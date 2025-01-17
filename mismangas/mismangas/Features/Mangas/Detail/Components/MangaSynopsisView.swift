//
//  MangaSynopsisView.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//


import SwiftUI

struct MangaSynopsisView: View {
    let synopsis: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Synopsis")
                .font(.headline)
            Text(synopsis)
                .font(.body)
                .multilineTextAlignment(.leading)
        }
    }
}

// MARK: - Preview

#Preview {
    MangaSynopsisView(synopsis: Manga.preview.synopsis)
}
