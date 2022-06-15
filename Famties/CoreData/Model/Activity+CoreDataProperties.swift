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

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var estimatedTime: Int16
    @NSManaged public var explanation: String?
    @NSManaged public var point: Double
    @NSManaged public var isFavorited: Bool
    @NSManaged public var partOf: Category?
    @NSManaged public var has: NSSet?
    @NSManaged public var hasTips: NSSet?

}

// MARK: Generated accessors for has
extension Activity {

    @objc(addHasObject:)
    @NSManaged public func addToHas(_ value: ActivityBenefit)

    @objc(removeHasObject:)
    @NSManaged public func removeFromHas(_ value: ActivityBenefit)

    @objc(addHas:)
    @NSManaged public func addToHas(_ values: NSSet)

    @objc(removeHas:)
    @NSManaged public func removeFromHas(_ values: NSSet)

}

// MARK: Generated accessors for hasTips
extension Activity {

    @objc(addHasTipsObject:)
    @NSManaged public func addToHasTips(_ value: Tips)

    @objc(removeHasTipsObject:)
    @NSManaged public func removeFromHasTips(_ value: Tips)

    @objc(addHasTips:)
    @NSManaged public func addToHasTips(_ values: NSSet)

    @objc(removeHasTips:)
    @NSManaged public func removeFromHasTips(_ values: NSSet)

}

extension Activity : Identifiable {

}
