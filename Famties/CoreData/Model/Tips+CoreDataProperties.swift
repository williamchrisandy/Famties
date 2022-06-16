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

    @nonobjc public class func fetchRequest(activityId: Int) -> NSFetchRequest<Tips> {
        let fetchRequest = NSFetchRequest<Tips>(entityName: "Tips")
        fetchRequest.predicate = NSPredicate(format: "activityId == %i", activityId)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "index", ascending: true)]
        return fetchRequest
    }

    @NSManaged public var index: Int16
    @NSManaged public var tips: String?
    @NSManaged public var activityId: Int16
    @NSManaged public var of: Activity?

}

extension Tips : Identifiable {

}
