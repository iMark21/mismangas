//
//  UseCaseProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//

import Foundation

protocol FetchMangasUseCaseProtocol: Sendable {
    func execute(page: Int, perPage: Int) async throws -> [Manga]
}
