//
//  Activity+CoreDataProperties.swift
//  Famties
//
//  Created by William Chrisandy on 16/06/22.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest(showAll: Bool) -> NSFetchRequest<Activity> {
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "totalPoint", ascending: false)]
        if showAll == false { fetchRequest.fetchLimit = DatabaseHelper.limitedDataMaxCount }
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequestFavorited(showAll: Bool) -> NSFetchRequest<Activity> {
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        fetchRequest.predicate = NSPredicate(format: "isFavorited == %@", NSNumber(value: true))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "totalPoint", ascending: false)]
        if showAll == false { fetchRequest.fetchLimit = DatabaseHelper.limitedDataMaxCount }
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(id: Int) -> NSFetchRequest<Activity> {
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(categoryId: Int, showAll: Bool) -> NSFetchRequest<Activity> {
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        fetchRequest.predicate = NSPredicate(format: "partOf.id == %i", categoryId)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "totalPoint", ascending: false)]
        if showAll == false { fetchRequest.fetchLimit = DatabaseHelper.limitedDataMaxCount }
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(contains: String) -> NSFetchRequest<Activity>
    {
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        fetchRequest.predicate = NSPredicate(format: "name like [c] %@", "*\(contains)*")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "totalPoint", ascending: false)]
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(contains: String, categoryId: Int) -> NSFetchRequest<Activity>
    {
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        fetchRequest.predicate = NSPredicate(format: "name like [c] %@ and partOf.id == %i", "*\(contains)*", categoryId)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "totalPoint", ascending: false)]
        return fetchRequest
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var estimatedTime: Int16
    @NSManaged public var explanation: String?
    @NSManaged public var point: Double
    @NSManaged public var totalPoint: Double
    @NSManaged public var isFavorited: Bool
    @NSManaged public var partOf: Category?
    @NSManaged public var has: NSSet?

}

// MARK: Generated accessors for has
extension Activity {

    @objc(addHasObject:)
    @NSManaged public func addToHas(_ value: Benefit)

    @objc(removeHasObject:)
    @NSManaged public func removeFromHas(_ value: Benefit)

    @objc(addHas:)
    @NSManaged public func addToHas(_ values: NSSet)

    @objc(removeHas:)
    @NSManaged public func removeFromHas(_ values: NSSet)

}

extension Activity: Identifiable {

}

extension Activity: HasKeyLastId {
    static var keyLastId: String = "activityLastId"
}

extension Activity: HasId {
    
}
