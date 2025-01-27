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
        VStack(alignment: .leading) {
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

    // MARK: - Subvistas

    @ViewBuilder
    private func widgetTitle() -> some View {
        Text("I'm reading")
            .font(.headline)
            .foregroundColor(.primary)
    }

    // MARK: - Small Widget Content
    
    @ViewBuilder
    private func smallWidgetContent() -> some View {
        if entry.collections.isEmpty {
            emptyState()
        } else {
            ForEach(entry.collections.prefix(2)) { collection in
                mangaRow(for: collection)
                    .padding(.vertical, 4)
            }
        }
    }

    // MARK: - Medium Widget Content
    
    @ViewBuilder
    private func mediumWidgetContent() -> some View {
        if entry.collections.isEmpty {
            emptyState()
        } else {
            ForEach(entry.collections.prefix(2)) { collection in
                mangaRow(for: collection)
                    .padding(.vertical, 4)
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
                mangaRow(for: collection)
                    .padding(.vertical, 4)
            }
        }
    }
    
    // MARK: - Views

    @ViewBuilder
    private func emptyState() -> some View {
        Text("No manga in progress")
            .font(.subheadline)
            .foregroundColor(.secondary)
    }

    @ViewBuilder
    private func mangaRow(for collection: MangaCollectionDB) -> some View {
        VStack(alignment: .leading) {
            // Título del manga
            Text(collection.mangaName)
                .font(.subheadline)
                .lineLimit(1)

            // Barra de progreso
            ProgressView(value: collection.completeCollection ? 1.0 : CGFloat(collection.readingVolume ?? 0) / CGFloat(collection.totalVolumes ?? 1))
                .progressViewStyle(LinearProgressViewStyle(tint: collection.completeCollection ? .green : .blue))
                .scaleEffect(x: 1, y: 2, anchor: .center)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
// MARK: - Preview

#Preview(as: .systemLarge) {
    MangaReadingWidget()
} timeline: {
    MangaEntry.preview
}
