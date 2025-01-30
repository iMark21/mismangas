//
//  PlatformTextFieldModifier.swift
//  mismangas
//
//  Created by Michel Marques on 26/1/25.
//

import SwiftUI

struct PlatformTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        if isPad {
            content
                .frame(width: 450, height: 50)
                .font(.title)
        } else if isMac {
            content
                .frame(width: 450)
                .font(.body)
        }else {
            content
                .font(.body)
        }
    }
}

extension View {
    func platformTextFieldStyle() -> some View {
        modifier(PlatformTextFieldModifier())
    }
}
