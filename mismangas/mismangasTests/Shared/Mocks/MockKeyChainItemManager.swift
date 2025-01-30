//
//  MockKeyChainItemManager.swift
//  mismangasTests
//
//  Created by Michel Marques on 29/01/25.
//

import Foundation
@testable import mismangas

final class MockKeyChainItemManager: KeyChainItemManager {
    
    private var storage: [String: String] = [:]
    
    func save(item: String) throws {
        // Guardar el item en un diccionario simulado
        storage["token"] = item
    }
    
    func load() throws -> String? {
        // Simular carga del item
        return storage["token"]
    }
    
    func delete() throws {
        // Simular eliminación del item
        storage.removeValue(forKey: "token")
    }
}