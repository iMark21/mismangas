//
//  FetchDemographicsUseCaseProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 16/1/25.
//


import Foundation

protocol FetchDemographicsUseCaseProtocol: FetchItemsUseCaseProtocol {
    func execute(query: String?, page: Int?, perPage: Int?) async throws -> [Demographic]
}