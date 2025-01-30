//
//  DemographicRepositoryProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 16/1/25.
//

import Foundation

protocol DemographicRepositoryProtocol: Sendable {
    func fetchDemographics() async throws -> [Demographic]
}
