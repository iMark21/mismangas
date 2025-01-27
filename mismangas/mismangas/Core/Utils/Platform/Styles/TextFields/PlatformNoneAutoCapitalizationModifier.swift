//
//  PlatformNoneAutoCapitalizationModifier.swift
//  mismangas
//
//  Created by Michel Marques on 26/1/25.
//


import SwiftUI

struct PlatformNoneAutoCapitalizationModifier: ViewModifier {
    func body(content: Content) -> some View {
        #if os(iOS)
        content
            .autocapitalization(.none)
        #else
        content
        #endif
    }
}

extension View {
    func platformAutoCapitalization() -> some View {
        self.modifier(PlatformNoneAutoCapitalizationModifier())
    }
}
