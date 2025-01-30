import Foundation
@testable import mismangas

class MockModelContext: ModelContext {
    var insertedObjects: [Any] = []
    var deletedObjects: [Any] = []
    
    func insert<T>(_ object: T) {
        insertedObjects.append(object)
    }
    
    func delete<T>(_ object: T) {
        deletedObjects.append(object)
    }
    
    func fetch<T>(_ descriptor: FetchDescriptor<T>) throws -> [T] {
        // Simulate fetching data based on the type of descriptor
        return [] // Return an empty list for simplicity or mock data as needed
    }
    
    func save() throws {
        // Simulate saving data (no actual DB operation)
    }
}