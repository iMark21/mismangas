//
//  MockModelContext.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
import SwiftData
@testable import mismangas

// MARK: - Mock Implementation

final class MockModelContext: ModelContextProtocol {
    
    // MARK: - Properties
    
    var insertedObjects: [ObjectIdentifier: any PersistentModel] = [:]
    var deletedObjects: [ObjectIdentifier: any PersistentModel] = [:]
    private(set) var stubbedData: [any PersistentModel] = []
    var shouldThrowError = false
    
    // MARK: - Context Methods
    
    func insert<T: PersistentModel>(_ object: T) {
        let id = ObjectIdentifier(object)
        insertedObjects[id] = object
    }
    
    func delete<T: PersistentModel>(_ object: T) {
        let id = ObjectIdentifier(object)
        insertedObjects.removeValue(forKey: id)
        deletedObjects[id] = object
    }
    
    func save() throws {
        if shouldThrowError {
            throw NSError(domain: "MockModelContextError", code: -1)
        }
    }
    
    func fetch<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) throws -> [T] {
        if shouldThrowError {
            throw NSError(domain: "MockModelContextError", code: -2)
        }
        
        return (stubbedData + insertedObjects.values)
            .compactMap { $0 as? T }
    }
    
    // MARK: - Test Helpers
    
    func contains<T: PersistentModel>(_ object: T) -> Bool {
        insertedObjects.keys.contains(ObjectIdentifier(object))
    }
    
    func reset() {
        insertedObjects.removeAll()
        deletedObjects.removeAll()
        stubbedData.removeAll()
        shouldThrowError = false
    }
}
