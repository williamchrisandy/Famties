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
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(id: Int) -> NSFetchRequest<Category> {
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        return fetchRequest
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
