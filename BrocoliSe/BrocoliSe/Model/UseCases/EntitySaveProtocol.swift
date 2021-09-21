import Foundation
import CoreData

protocol EntitySaveProtocol {
    var viewContext: NSManagedObjectContext { get }
    func save()
    func saveSync()
}

extension EntitySaveProtocol {
    func save() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

extension EntitySaveProtocol {
    func saveSync() {
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = viewContext
        privateContext.perform {
            do {
                try privateContext.save()
                viewContext.performAndWait {
                    do {
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        print("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
            } catch {
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
