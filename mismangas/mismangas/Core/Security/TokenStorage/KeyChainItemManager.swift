//
//  TokenStorageProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//


protocol KeyChainItemManager: Sendable {
    func save(item: String) async throws
    func load() async throws -> String?
    func delete() async throws
}
