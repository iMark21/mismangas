//
//  HideFormBackgroundModifier.swift
//  mismangas
//
//  Created by Michel Marques on 27/1/25.
//

import SwiftUI

struct HideFormBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        #if os(iOS)
        content
            .scrollContentBackground(.hidden)
        #else
        content
        #endif
    }
}

extension View {
    func hideFormBackground() -> some View {
        modifier(HideFormBackgroundModifier())
    }
}
