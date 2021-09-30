import Foundation
import CoreData

protocol EntityCreateProtocol {
    var viewContext: NSManagedObjectContext { get }
    func createEntity<T: NSManagedObject>() -> T
}

extension EntityCreateProtocol {
    func createEntity<T: NSManagedObject>() -> T {
        T(context: viewContext)
    }
}
