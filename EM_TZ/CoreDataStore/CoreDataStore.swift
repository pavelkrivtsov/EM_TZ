//
//  CoreDataStore.swift
//  TZ
//
//  Created by Pavel Krivtsov on 15.03.2023.
//

import Foundation
import CoreData

protocol CoreDataStoreProtocol {
    func isUserRegistered(name: String) -> Bool
    func isUserRegistered(firstName: String, lastName: String, email: String) -> Bool
}

final class CoreDataStore {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private lazy var context = persistentContainer.viewContext
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataStore: CoreDataStoreProtocol {
    
    func isUserRegistered(firstName: String, lastName: String, email: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)
        fetchRequest.predicate = NSPredicate(format: "firstName = %@", firstName)
        fetchRequest.predicate = NSPredicate(format: "lastName = %@", lastName)
        
        if let users = try? context.fetch(fetchRequest) as? [User], !users.isEmpty {
            return true
        } else {
            let user = User(context: context)
            user.firstName = firstName
            user.lastName = lastName
            user.email = email
            saveContext()
            return false
        }
    }
    
    func isUserRegistered(name: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "firstName = %@", name)
        
        if let users = try? context.fetch(fetchRequest) as? [User], !users.isEmpty {
            return true
        } else {
            return false
        }
    }
}
