//
//  PlatformBackgroundModifier.swift
//  mismangas
//
//  Created by Michel Marques on 27/1/25.
//


import SwiftUI

struct PlatformBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        #if os(iOS)
        content
            .background(Color(.systemGroupedBackground))
        #else
        content
        #endif
    }
}

extension View {
    func platformBackground() -> some View {
        modifier(PlatformBackgroundModifier())
    }
}
