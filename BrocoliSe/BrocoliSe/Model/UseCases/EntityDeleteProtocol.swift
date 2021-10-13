import Foundation
import CoreData

protocol EntityDeleteProtocol {
    var viewContext: NSManagedObjectContext { get }
    func removeEntity(request: NSFetchRequest<NSFetchRequestResult>)
}

extension EntityDeleteProtocol {
    func removeEntity(request: NSFetchRequest<NSFetchRequestResult>) {
        do {
            let removeResquest = NSBatchDeleteRequest(fetchRequest: request)
            removeResquest.resultType = .resultTypeCount
            try viewContext.execute(removeResquest)
        } catch {
            fatalError("Couldnt Remove the enities" + error.localizedDescription)
        }
    }
}
