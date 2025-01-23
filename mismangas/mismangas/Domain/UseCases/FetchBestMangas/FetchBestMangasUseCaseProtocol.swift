//
//  FetchBestMangasUseCaseProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 20/1/25.
//

import Foundation

protocol FetchBestMangasUseCaseProtocol: Sendable {
    func execute() async throws -> [Manga]
}
