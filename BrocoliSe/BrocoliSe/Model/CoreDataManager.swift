import Foundation
import CoreData

extension NSManagedObject {
    class var entityName: String {
        return String(describing: self).components(separatedBy: ".").last ?? "error"
    }
}

protocol CoreDataManagerProtocol: EntityCreateProtocol, EntitySaveProtocol, EntityFetchProtocol, EntityDeleteProtocol {
    var viewContext: NSManagedObjectContext { get }
    func save()
}

class CoreDataManager: CoreDataManagerProtocol {
    private let container: NSPersistentContainer
    static var shared: CoreDataManagerProtocol = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return self.container.viewContext
    }
    
    init() {
        self.container = NSPersistentContainer(name: "DataModel")
        self.container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
