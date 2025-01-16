//
//  FetchAuthorsUseCaseProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 6/1/25.
//

import Foundation

protocol FetchAuthorsUseCaseProtocol: FetchItemsUseCaseProtocol {
    func execute(query: String?, page: Int?, perPage: Int?) async throws -> [Author]
}


protocol FetchItemsUseCaseProtocol: Sendable {
    associatedtype Item: Identifiable & Hashable & Sendable
    func execute(query: String?, page: Int?, perPage: Int?) async throws -> [Item]
}
