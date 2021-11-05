//
//  CoreDataManagerMock.swift
//  BrocoliSeTests
//
//  Created by Samuel Sales on 07/10/21.
//

import Foundation
import CoreData
@testable import BrocoliSe

class CoreDataManagerMock: CoreDataManagerProtocol {
    private let container: NSPersistentContainer
    static var shared: CoreDataManagerProtocol = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return self.container.viewContext
    }
    
    init() {
        self.container = NSPersistentContainer(name: "DataModel")
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        self.container.persistentStoreDescriptions = [description]
        self.container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
