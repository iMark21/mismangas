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

    @State var viewModel: MyCollectionManagementViewModel

    var body: some View {
        VStack {
            Form {
                completeCollectionToggle

                if let totalVolumes = viewModel.manga?.volumes {
                    volumesOwnedStepper(totalVolumes: totalVolumes)
                    currentlyReadingPicker(totalVolumes: totalVolumes)
                }
            }
            .hideFormBackground()
            .platformBackground()

            HStack {
                Spacer()
                Button("Cancel") {
                    dismiss()
                }
                .buttonStyle(.bordered)

                Button("Save") {
                    Task {
                        do {
                            try await viewModel.saveChanges(using: modelContext)
                            dismiss()
                        } catch {
                            Logger.logErrorMessage("Failed to save changes: \(error.localizedDescription)")
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.top)
        }
        .padding()
        .onAppear {
            viewModel.loadCollection(using: modelContext)
        }
    }

    // MARK: - Components

    private var completeCollectionToggle: some View {
        Toggle("Complete Collection", isOn: $viewModel.tempCompleteCollection)
    }

    private func volumesOwnedStepper(totalVolumes: Int) -> some View {
        Stepper(
            "Volumes Owned: \(viewModel.tempVolumesOwned.count)",
            onIncrement: {
                if viewModel.tempVolumesOwned.count < totalVolumes {
                    viewModel.tempVolumesOwned.append(viewModel.tempVolumesOwned.count + 1)
                    viewModel.updateVolumes()
                }
            },
            onDecrement: {
                if viewModel.tempVolumesOwned.count > 0 {
                    viewModel.tempVolumesOwned.removeLast()
                    viewModel.updateVolumes()
                }
            }
        )
    }
    
    private func currentlyReadingPicker(totalVolumes: Int) -> some View {
        Menu {
            Button("None") { viewModel.tempReadingVolume = nil }
            
            ForEach(1...totalVolumes, id: \.self) { volume in
                Button("Volume \(volume)") {
                    viewModel.tempReadingVolume = volume
                }
                .disabled(!viewModel.tempVolumesOwned.contains(volume))
                .foregroundColor(viewModel.tempVolumesOwned.contains(volume) ? .primary : .gray)
            }
        } label: {
            HStack {
                Text(viewModel.tempReadingVolume.map { "Reading volume: \($0)" } ?? "No volumes readed")
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
    }
}

// MARK: - Preview

#Preview {
    MyCollectionManagementSection(viewModel: MyCollectionManagementViewModel(manga: .preview))
}
