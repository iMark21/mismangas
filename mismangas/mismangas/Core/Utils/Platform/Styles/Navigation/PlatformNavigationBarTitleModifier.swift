//
//  PlatformNavigationBarTitleModifier.swift
//  mismangas
//
//  Created by Michel Marques on 26/1/25.
//

import SwiftUI

struct PlatformNavigationBarTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        #if os(iOS)
        content.navigationBarTitleDisplayMode(.inline)
        #else
        content
        #endif
    }
}

extension View {
    func platformNavigationBarTitle() -> some View {
        self.modifier(PlatformNavigationBarTitleModifier())
    }
}
