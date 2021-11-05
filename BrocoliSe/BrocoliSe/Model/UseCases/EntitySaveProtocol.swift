import Foundation
import CoreData

protocol EntitySaveProtocol {
    var viewContext: NSManagedObjectContext { get }
    func save()
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
