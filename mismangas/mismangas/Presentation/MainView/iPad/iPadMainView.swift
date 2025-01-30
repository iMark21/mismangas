//
//  iPadMainView.swift
//  mismangas
//
//  Created by Michel Marques on 25/1/25.
//

import SwiftUI

struct iPadMainView: View {
    @Binding var selectedSection: AppSection?
    @Binding var isUserAuthenticated: Bool

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
        } detail: {
            if let section = selectedSection {
                switch section {
                case .home:
                    HomeView()
                case .allMangas:
                    MangaListView()
                case .myCollection:
                    MyCollectionListView(isUserAuthenticated: $isUserAuthenticated)
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
    @Previewable @State var isUserAuthenticated: Bool = true
    
    iPadMainView(selectedSection: $selectedSection,
                 isUserAuthenticated: $isUserAuthenticated)
}

