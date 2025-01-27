//
//  MyCollectionManagementSection.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//

import SwiftUI
import SwiftData

struct MyCollectionManagementSection: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query private var collections: [MangaCollectionDB]

    @State private var tempCompleteCollection: Bool = false
    @State private var tempVolumesOwned: [Int] = []
    @State private var tempReadingVolume: Int? = nil

    @Binding var completeCollection: Bool
    @Binding var volumesOwned: [Int]
    @Binding var readingVolume: Int?
    
    let totalVolumes: Int?
    let manga: Manga?

    private var collectionManager: MangaCollectionManager {
        MangaCollectionManager()
    }

    var body: some View {
        VStack {
            Form {
                completeCollectionToggle
                
                if let totalVolumes {
                    volumesOwnedStepper(totalVolumes: totalVolumes)
                    if !tempCompleteCollection {
                        currentlyReadingPicker(totalVolumes: totalVolumes)
                    }
                }
            }
            .hideFormBackground()
            .platformBackground()
            
            HStack {
                Spacer()
                
                Button("Cancel") {
                    dismissChanges()
                }
                .buttonStyle(.bordered)
                
                Button("Save") {
                    saveChanges()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.top)
        }
        .padding()
        .platformBackground()
        .onAppear(perform: loadCollection)
    }

    // MARK: - Components

    private var completeCollectionToggle: some View {
        Toggle("Complete Collection", isOn: $tempCompleteCollection)
    }

    private func volumesOwnedStepper(totalVolumes: Int) -> some View {
        Stepper(
            "Volumes Owned: \(tempVolumesOwned.count)",
            value: Binding(
                get: { tempVolumesOwned.count },
                set: { updateVolumes($0) }
            ),
            in: 0...totalVolumes
        )
    }

    private func currentlyReadingPicker(totalVolumes: Int) -> some View {
        Picker("Currently Reading", selection: $tempReadingVolume) {
            Text("None").tag(nil as Int?)
            ForEach(1...totalVolumes, id: \.self) { volume in
                Text("Volume \(volume)").tag(volume as Int?)
            }
        }
        .pickerStyle(.menu)
    }

    // MARK: - Actions

    private func loadCollection() {
        guard let manga else { return }

        let state = collectionManager.fetchCollectionState(for: manga.id, using: modelContext)
        tempCompleteCollection = state.completeCollection
        tempVolumesOwned = state.volumesOwned
        tempReadingVolume = state.readingVolume
    }

    private func saveChanges() {
        completeCollection = tempCompleteCollection
        volumesOwned = tempVolumesOwned
        readingVolume = tempReadingVolume

        saveCollection()
        dismiss()
    }

    private func dismissChanges() {
        dismiss()
    }

    private func saveCollection() {
        guard let manga else { return }

        Task {
            do {
                try await collectionManager.saveToMyCollection(
                    manga: manga,
                    completeCollection: completeCollection,
                    volumesOwned: volumesOwned,
                    readingVolume: readingVolume,
                    using: modelContext
                )
            } catch {
                Logger.logErrorMessage("Failed to save collection: \(error.localizedDescription)")
            }
        }
    }

    private func updateVolumes(_ newCount: Int) {
        let updatedState = collectionManager.updateVolumes(newCount: newCount, currentReadingVolume: tempReadingVolume)
        tempVolumesOwned = updatedState.updatedVolumes
        tempReadingVolume = updatedState.updatedReadingVolume
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var completeCollection = false
    @Previewable @State var volumesOwned: [Int] = []
    @Previewable @State var readingVolume: Int? = nil

    MyCollectionManagementSection(
        completeCollection: $completeCollection,
        volumesOwned: $volumesOwned,
        readingVolume: $readingVolume,
        totalVolumes: Manga.preview.volumes,
        manga: .preview
    )
}
