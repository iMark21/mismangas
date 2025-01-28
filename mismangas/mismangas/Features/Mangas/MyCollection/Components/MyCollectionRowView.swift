//
//  MyCollectionRowView.swift
//  mismangas
//
//  Created by Michel Marques on 18/1/25.
//

import SwiftUI

struct MyCollectionRowView: View {
    let mangaName: String
    let collection: MangaCollectionDB

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(mangaName)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                if collection.completeCollection {
                    Text("Status: Complete")
                        .font(.subheadline)
                        .foregroundColor(.green)
                } else {
                    Text("Status: In Progress")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                }

                Text("Owned: \(collection.volumesOwned.last ?? 0) of \(collection.totalVolumes ?? 1) volumes")
                    .font(.footnote)
                    .foregroundColor(.secondary)

                if let currentReadingVolume = collection.readingVolume {
                    Text("Currently Reading: Volume \(currentReadingVolume)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            Image(systemName: collection.completeCollection ? "checkmark.seal.fill" : "book.fill")
                .foregroundColor(collection.completeCollection ? .green : .orange)
                .font(.title3)
        }
        .padding(.vertical, 8)
    }
}
