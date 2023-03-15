//
//  User+CoreDataProperties.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 15.03.2023.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

}

extension User : Identifiable {

}
