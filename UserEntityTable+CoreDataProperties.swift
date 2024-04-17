//
//  UserEntityTable+CoreDataProperties.swift
//  swiftUiFirebase
//
//  Created by Ground 2 on 16/04/24.
//
//

import Foundation
import CoreData


extension UserEntityTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntityTable> {
        return NSFetchRequest<UserEntityTable>(entityName: "UserEntityTable")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?

}

extension UserEntityTable : Identifiable {

}
