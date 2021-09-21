import Foundation
import CoreData

protocol EntityFetchProtocol {
    var viewContext: NSManagedObjectContext { get }
    func fectch<T: NSManagedObject>(predicate: NSPredicate?,
                                    sortDescriptors: [NSSortDescriptor]?,
                                    limit: Int?,
                                    batchSize: Int?) -> [T]
}

extension EntityFetchProtocol {
    func fectch<T: NSManagedObject>(predicate: NSPredicate? = nil,
                                    sortDescriptors: [NSSortDescriptor]? = nil,
                                    limit: Int? = nil,
                                    batchSize: Int? = nil) -> [T] {
        let request = NSFetchRequest<T>(entityName: T.entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        if let limit = limit, limit > 0 {
            request.fetchLimit = limit
        }
        
        if let batchSize = batchSize, batchSize > 0 {
            request.fetchBatchSize = batchSize
        }
        
        do {
            let items = try viewContext.fetch(request)
            return items
        } catch {
            fatalError("Couldnt fetch the enities for \(T.entityName) " + error.localizedDescription)
        }
    }
}
