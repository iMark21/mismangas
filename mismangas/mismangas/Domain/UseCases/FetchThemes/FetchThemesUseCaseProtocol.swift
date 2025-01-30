//
//  FetchThemesUseCaseProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 16/1/25.
//

import Foundation

protocol FetchThemesUseCaseProtocol: FetchItemsUseCaseProtocol {
    func execute() async throws -> [Theme]
}
