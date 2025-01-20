//
//  Utils.swift
//  mismangas
//
//  Created by Michel Marques on 19/1/25.
//

import Foundation
import UIKit

@MainActor var iPad: Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}
