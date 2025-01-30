//
//  MangaReadingWidgetEntryView.swift
//  mismangas
//
//  Created by Michel Marques on 27/1/25.
//


import SwiftUI
import WidgetKit


struct MangaReadingWidgetEntryView: View {
    var entry: MangaCollectionProvider.Entry

    @Environment(\.widgetFamily) var family

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            widgetTitle()

            switch family {
            case .systemSmall:
                smallWidgetContent()
            case .systemMedium:
                mediumWidgetContent()
            default:
                largeWidgetContent()
            }
            Spacer()
        }
        .padding()
        .onAppear {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }

    // MARK: - Subviews

    private func widgetTitle() -> some View {
        Text("Currently Reading")
            .font(.headline)
            .foregroundColor(.primary)
            .padding(.bottom, 4)
    }

    // MARK: - Small Widget Content

    @ViewBuilder
    private func smallWidgetContent() -> some View {
        if let collection = entry.collections.first {
            compactMangaRow(for: collection)
        } else {
            emptyState()
        }
    }

    // MARK: - Medium Widget Content

    @ViewBuilder
    private func mediumWidgetContent() -> some View {
        if entry.collections.isEmpty {
            emptyState()
        } else {
            ForEach(entry.collections.prefix(2)) { collection in
                detailedMangaRow(for: collection)
            }
        }
    }

    // MARK: - Large Widget Content

    @ViewBuilder
    private func largeWidgetContent() -> some View {
        if entry.collections.isEmpty {
            emptyState()
        } else {
            ForEach(entry.collections) { collection in
                detailedMangaRow(for: collection)
            }
        }
    }

    // MARK: - Empty State View

    @ViewBuilder
    private func emptyState() -> some View {
        VStack {
            Text("No manga in your collection")
                .font(.caption)
                .foregroundColor(.secondary)
            Text("Add manga to track progress.")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .multilineTextAlignment(.center)
    }

    // MARK: - Compact Manga Row (Small Widget)

    private func compactMangaRow(for collection: MangaCollectionDB) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(collection.mangaName)
                    .font(.caption)
                    .lineLimit(1)

                if let totalVolumes = collection.totalVolumes,
                   let readingVolume = collection.readingVolume {
                    Text("\(readingVolume) / \(totalVolumes)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            volumeIndicator(for: collection, maxWidth: 50)
        }
    }

    // MARK: - Detailed Manga Row (Medium/Large Widgets)

    private func detailedMangaRow(for collection: MangaCollectionDB) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(collection.mangaName)
                    .font(.subheadline)
                    .lineLimit(1)

                if let totalVolumes = collection.totalVolumes,
                   let readingVolume = collection.readingVolume {
                    Text("Reading: \(readingVolume) / \(totalVolumes)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }

                if collection.completeCollection {
                    Text("Complete Collection")
                        .font(.caption2)
                        .foregroundColor(.green)
                } else {
                    EmptyView()
                }
            }
            Spacer()
            volumeIndicator(for: collection, maxWidth: 70)
        }
    }

    // MARK: - Volume Indicator

    private func volumeIndicator(for collection: MangaCollectionDB, maxWidth: CGFloat) -> some View {
        Group {
            if let totalVolumes = collection.totalVolumes, let readingVolume = collection.readingVolume {
                VolumeIndicatorView(
                    totalVolumes: totalVolumes,
                    readingVolume: readingVolume,
                    maxWidth: maxWidth
                )
            } else {
                EmptyView()
            }
        }
    }
}

// MARK: - Preview

#Preview(as: .systemMedium) {
    MangaReadingWidget()
} timeline: {
    MangaEntry.preview
}
