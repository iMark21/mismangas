//
//  MyCollectionManagementSection.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//

import SwiftUI
import SwiftData

struct MyCollectionManagementSection: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var collections: [MangaCollection]

    @Binding var completeCollection: Bool
    @Binding var volumesOwned: [Int]
    @Binding var readingVolume: Int?
    let totalVolumes: Int?
    let manga: Manga?

    private var collectionManager: MangaCollectionManager {
        MangaCollectionManager(modelContext: modelContext)
    }

    var body: some View {
        Form {
            completeCollectionToggle

            if let totalVolumes {
                volumesOwnedStepper(totalVolumes: totalVolumes)
                if !completeCollection {
                    currentlyReadingPicker(totalVolumes: totalVolumes)
                }
            }
        }
        .onAppear(perform: loadCollection)
    }

    // MARK: - Components

    private var completeCollectionToggle: some View {
        Toggle("Complete Collection", isOn: $completeCollection)
            .onChange(of: completeCollection) { saveCollection() }
    }

    private func volumesOwnedStepper(totalVolumes: Int) -> some View {
        Stepper(
            "Volumes Owned: \(volumesOwned.count)",
            value: Binding(
                get: { volumesOwned.count },
                set: { updateVolumes($0) }
            ),
            in: 0...totalVolumes
        )
        .onChange(of: volumesOwned) { saveCollection() }
    }

    private func currentlyReadingPicker(totalVolumes: Int) -> some View {
        Picker("Currently Reading", selection: $readingVolume) {
            Text("None").tag(nil as Int?)
            ForEach(1...totalVolumes, id: \.self) { volume in
                Text("Volume \(volume)").tag(volume as Int?)
            }
        }
        .pickerStyle(.menu)
        .onChange(of: readingVolume) { saveCollection() }
    }

    // MARK: - Data Persistence

    private func loadCollection() {
        guard let manga else { return }
        let state = collectionManager.fetchCollectionState(for: manga.id)
        completeCollection = state.completeCollection
        volumesOwned = state.volumesOwned
        readingVolume = state.readingVolume
    }

    private func saveCollection() {
        guard let manga else { return }
        collectionManager.saveToMyCollection(manga: manga,
                                          completeCollection: completeCollection,
                                          volumesOwned: volumesOwned,
                                          readingVolume: readingVolume)
    }

    private func updateVolumes(_ newCount: Int) {
        let updatedState = collectionManager.updateVolumes(newCount: newCount, currentReadingVolume: readingVolume)
        volumesOwned = updatedState.updatedVolumes
        readingVolume = updatedState.updatedReadingVolume
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var completeCollection = false
    @Previewable @State var volumesOwned: [Int] = []
    @Previewable @State var readingVolume: Int? = nil

    return MyCollectionManagementSection(
        completeCollection: $completeCollection,
        volumesOwned: $volumesOwned,
        readingVolume: $readingVolume,
        totalVolumes: Manga.preview.volumes,
        manga: .preview
    )
}
