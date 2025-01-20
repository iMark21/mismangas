//
//  MyCollectionRowView.swift
//  mismangas
//
//  Created by Michel Marques on 18/1/25.
//


import SwiftUI

struct MyCollectionRowView: View {
    let mangaName: String
    let completeCollection: Bool

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(mangaName)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                if completeCollection {
                    Text("Status: Complete")
                        .font(.subheadline)
                        .foregroundColor(.green)
                } else {
                    Text("Status: In Progress")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                }
            }
            Spacer()
            Image(systemName: completeCollection ? "checkmark.seal.fill" : "book.fill")
                .foregroundColor(completeCollection ? .green : .orange)
                .font(.title3)
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Preview

#Preview {
    MyCollectionRowView(mangaName: Manga.preview.title, completeCollection: true)
}
