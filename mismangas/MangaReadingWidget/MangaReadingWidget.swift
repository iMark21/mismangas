//
//  MangaReadingWidget.swift
//  MangaReadingWidget
//
//  Created by Michel Marques on 27/1/25.
//


import WidgetKit
import SwiftUI
import SwiftData

struct MangaReadingWidget: Widget {
    let kind: String = "MangaReadingWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: MangaCollectionProvider()
        ) { entry in
            MangaReadingWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Manga Collection")
        .description("Displays your manga collection")
        .supportedFamilies(
            [.systemSmall,
             .systemMedium,
             .systemLarge]
        )
    }
}
