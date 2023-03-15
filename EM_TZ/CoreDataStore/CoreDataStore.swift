//
//  CoreDataStore.swift
//  TZ
//
//  Created by Pavel Krivtsov on 15.03.2023.
//

import Foundation
import CoreData

final class CoreDataStore {
    
    static var shared = CoreDataStore()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveUser(firstName: String, lastName: String, email: String) {
        let user = User(context: context)
        user.firstName = firstName
        user.lastName = lastName
        user.email = email
        saveContext()
    }
}
