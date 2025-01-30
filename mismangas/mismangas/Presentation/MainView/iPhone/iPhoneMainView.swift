//
//  iPhoneMainView.swift
//  mismangas
//
//  Created by Michel Marques on 25/1/25.
//

import SwiftUI

struct iPhoneMainView: View {
    @Binding var isUserAuthenticated: Bool

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            MangaListView()
                .tabItem {
                    Label("All Mangas", systemImage: "book")
                }
            MyCollectionListView(isUserAuthenticated: $isUserAuthenticated)
                .tabItem {
                    Label("My Collection", systemImage: "heart.fill")
                }
        }
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var isUserAuthenticated: Bool = true

    iPhoneMainView(isUserAuthenticated: $isUserAuthenticated)
}
