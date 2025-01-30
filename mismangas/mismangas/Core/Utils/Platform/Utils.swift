//
//  Utils.swift
//  mismangas
//
//  Created by Michel Marques on 19/1/25.
//

import Foundation
import SwiftUI

enum DeviceType {
    case iPhone, iPad, mac
}

@MainActor
var currentDeviceType: DeviceType {
    #if os(iOS)
    if UIDevice.current.userInterfaceIdiom == .pad {
        return .iPad
    } else {
        return .iPhone
    }
    #elseif os(macOS)
    return .mac
    #else
    fatalError("Unsupported platform")
    #endif
}

@MainActor var isSplitViewSupported: Bool {
    #if os(macOS)
    true
    #else
    UIDevice.current.userInterfaceIdiom == .pad
    #endif
}

@MainActor var isMac: Bool {
    return currentDeviceType == .mac
}

@MainActor var isPad: Bool {
    return currentDeviceType == .iPad
}

@MainActor var isPhone: Bool {
    return currentDeviceType == .iPhone
}
