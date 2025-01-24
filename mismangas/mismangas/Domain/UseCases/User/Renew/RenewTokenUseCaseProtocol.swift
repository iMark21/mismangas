//
//  RenewTokenUseCaseProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import Foundation

protocol RenewTokenUseCaseProtocol: Sendable {
    func execute() async throws -> Bool
}
