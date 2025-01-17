//
//  CollectionManagementSection.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//


import SwiftUI

struct CollectionManagementSection: View {
    @Binding var completeCollection: Bool
    @Binding var volumesOwned: [Int]
    @Binding var readingVolume: Int?
    let totalVolumes: Int?

    var body: some View {
        Form {
            Toggle("Complete Collection", isOn: $completeCollection)

            if let volumes = totalVolumes {
                Stepper("Volumes Owned: \(volumesOwned.count)", value: Binding(get: { volumesOwned.count }, set: { updateVolumes($0) }), in: 0...volumes)

                if !completeCollection {
                    Picker("Currently Reading", selection: $readingVolume) {
                        Text("None").tag(nil as Int?)
                        ForEach(1...volumes, id: \.self) { volume in
                            Text("Volume \(volume)").tag(volume as Int?)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
        }
    }

    private func updateVolumes(_ newCount: Int) {
        volumesOwned = Array(1...newCount)
        if let reading = readingVolume, reading > newCount {
            readingVolume = nil
        }
    }
}

#Preview {
    @Previewable @State var completeCollection = false
    @Previewable @State var volumesOwned: [Int] = []
    @Previewable @State var readingVolume: Int? = nil

    return CollectionManagementSection(
        completeCollection: $completeCollection,
        volumesOwned: $volumesOwned,
        readingVolume: $readingVolume,
        totalVolumes: 42
    )
}
