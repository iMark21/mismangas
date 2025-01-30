//
//  PlatformAdaptiveButtonStyle.swift
//  mismangas
//
//  Created by Michel Marques on 26/1/25.
//


import SwiftUI

struct PlatformButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        if isMac || isPad {
            configuration.label
                .font(.title)
                .bold()
                .frame(width: 400)
                #if os(macOS)
                .buttonStyle(.borderless)
                #endif
        } else {
            configuration.label
        }
    }
}

struct PlatformBorderLessStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        if isMac {
            configuration.label
                #if os(macOS)
                .buttonStyle(.borderless)
                #endif
        } else {
            configuration.label
        }
    }
}
