//
//  FetchGenresUseCaseProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 13/1/25.
//

import Foundation

protocol FetchGenresUseCaseProtocol: FetchItemsUseCaseProtocol {
    func execute() async throws -> [Genre]
}
