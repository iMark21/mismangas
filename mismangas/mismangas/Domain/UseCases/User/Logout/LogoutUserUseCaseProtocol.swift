//
//  LogoutUserUseCaseProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 25/1/25.
//

import Foundation

protocol LogoutUserUseCaseProtocol: Sendable {
    func execute() async throws
}
