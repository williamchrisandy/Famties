//
//  Category+CoreDataProperties.swift
//  Famties
//
//  Created by William Chrisandy on 16/06/22.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var point: Double
    @NSManaged public var has: NSSet?

}

// MARK: Generated accessors for has
extension Category {

    @objc(addHasObject:)
    @NSManaged public func addToHas(_ value: Activity)

    @objc(removeHasObject:)
    @NSManaged public func removeFromHas(_ value: Activity)

    @objc(addHas:)
    @NSManaged public func addToHas(_ values: NSSet)

    @objc(removeHas:)
    @NSManaged public func removeFromHas(_ values: NSSet)

}

extension Category : Identifiable {

}
