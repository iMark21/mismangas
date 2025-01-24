//
//  TokenStorageProtocol.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//


protocol KeyChainItemManager: Sendable {
    func save(item: String) throws
    func load() throws -> String?
    func delete() throws
}
