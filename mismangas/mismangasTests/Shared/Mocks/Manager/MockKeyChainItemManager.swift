//
//  MockKeyChainItemManager.swift
//  mismangas
//
//  Created by Michel Marques on 29/1/25.
//

import Foundation
@testable import mismangas

actor MockKeyChainItemManager: KeyChainItemManager {
    
    private var storage: [String: String] = [:]
    private var shouldThrowDeleteError = false
    
    func setShouldThrowDeleteError(_ value: Bool) async {
        shouldThrowDeleteError = value
    }
    
    // MARK: - Protocol methods
    
    // Save a new item
    func save(item: String) async throws {
        storage["token"] = item
    }
    
    // Load an item
    func load() async throws -> String? {
        return storage["token"]
    }
    
    // Delete an item
    func delete() async throws {
        if shouldThrowDeleteError {
            throw APIError.custom(message: "Deletion failed")
        }
        storage.removeValue(forKey: "token")
    }
}
