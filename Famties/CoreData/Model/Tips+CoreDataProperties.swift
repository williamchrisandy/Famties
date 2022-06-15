//
//  Tips+CoreDataProperties.swift
//  Famties
//
//  Created by William Chrisandy on 16/06/22.
//
//

import Foundation
import CoreData


extension Tips {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tips> {
        return NSFetchRequest<Tips>(entityName: "Tips")
    }

    @NSManaged public var index: Int16
    @NSManaged public var tips: String?
    @NSManaged public var activityId: Int16
    @NSManaged public var of: Activity?

}

extension Tips : Identifiable {

}
