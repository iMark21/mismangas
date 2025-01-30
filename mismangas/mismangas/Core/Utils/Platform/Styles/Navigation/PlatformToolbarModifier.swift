//
//  PlatformToolbarModifier.swift
//  mismangas
//
//  Created by Michel Marques on 26/1/25.
//

import SwiftUI

struct PlatformToolbarModifier: ViewModifier {
    var logoutAction: (() -> Void)?
    var isSyncing: Bool = false
    var syncAction: (() -> Void)?
    var showFilterView: Binding<Bool>? = nil
    var cancelAction: (() -> Void)?

    func body(content: Content) -> some View {
        #if os(iOS)
        content
            .toolbar {
                // Leading toolbar items
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        if let cancelAction = cancelAction {
                            Button("Cancel", action: cancelAction)
                                .foregroundColor(.red)
                        }

                        if let logoutAction = logoutAction {
                            Button(role: .destructive, action: logoutAction) {
                                Label("Logout", systemImage: "power")
                            }
                        }
                    }
                }

                // Trailing toolbar items
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if let syncAction = syncAction {
                        Button(action: syncAction) {
                            Label("Sync", systemImage: "arrow.triangle.2.circlepath")
                        }
                        .disabled(isSyncing)
                    }

                    if isSyncing {
                        ProgressView()
                    } else if let showFilterView = showFilterView {
                        Button {
                            showFilterView.wrappedValue = true
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .font(.title2)
                        }
                    }
                }
            }
        #elseif os(macOS)
        content
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    if let logoutAction = logoutAction {
                        Button(action: logoutAction) {
                            Label("Logout", systemImage: "power")
                        }
                        .keyboardShortcut("Q", modifiers: [.command])
                    }
                }

                ToolbarItemGroup {
                    if let syncAction = syncAction {
                        Button(action: syncAction) {
                            Label("Sync", systemImage: "arrow.triangle.2.circlepath")
                        }
                        .disabled(isSyncing)
                    }

                    if isSyncing {
                        ProgressView()
                    } else if let showFilterView = showFilterView {
                        Button {
                            showFilterView.wrappedValue = true
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .font(.title2)
                        }
                    }
                }
            }
        #endif
    }
}

// MARK: - View Extension

extension View {
    func platformToolbar(logoutAction: (() -> Void)? = nil,
                         isSyncing: Bool = false,
                         syncAction: (() -> Void)? = nil,
                         showFilterView: Binding<Bool>? = nil,
                         cancelAction: (() -> Void)? = nil) -> some View {
        self.modifier(PlatformToolbarModifier(
            logoutAction: logoutAction,
            isSyncing: isSyncing,
            syncAction: syncAction,
            showFilterView: showFilterView,
            cancelAction: cancelAction
        ))
    }
}
