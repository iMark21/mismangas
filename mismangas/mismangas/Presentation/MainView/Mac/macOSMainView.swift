//
//  macOSMainView.swift
//  mismangas
//
//  Created by Michel Marques on 25/1/25.
//

import SwiftUI

struct macOSMainView: View {
    @Binding var selectedSection: AppSection?

    var body: some View {
        NavigationSplitView {
            List(selection: $selectedSection) {
                ForEach(AppSection.allCases, id: \.self) { section in
                    NavigationLink(value: section) {
                        Label(section.rawValue, systemImage: section.systemImageName)
                    }
                    .tag(section)
                }
            }
            .navigationTitle("Mismangas")
            .onAppear {
                if selectedSection == nil {
                    selectedSection = .home
                }
            }
        } detail: {
            if let section = selectedSection {
                switch section {
                case .home:
                    HomeView()
                case .allMangas:
                    MangaListView()
                case .myCollection:
                    MyCollectionListView(isUserAuthenticated: .constant(true))
                }
            } else {
                Text("Select a section")
                    .foregroundColor(.secondary)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var selectedSection: AppSection? = .home
    macOSMainView(selectedSection: $selectedSection)
}

