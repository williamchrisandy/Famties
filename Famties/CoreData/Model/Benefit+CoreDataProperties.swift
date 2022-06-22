//
//  Benefit+CoreDataProperties.swift
//  Famties
//
//  Created by William Chrisandy on 16/06/22.
//
//

import Foundation
import CoreData


extension Benefit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Benefit> {
        let fetchRequest = NSFetchRequest<Benefit>(entityName: "Benefit")
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(id: Int) -> NSFetchRequest<Benefit> {
        let fetchRequest = NSFetchRequest<Benefit>(entityName: "Benefit")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        return fetchRequest
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var explanation: String?
    @NSManaged public var of: NSSet?

}

// MARK: Generated accessors for of
extension Benefit {

    @objc(addOfObject:)
    @NSManaged public func addToOf(_ value: Activity)

    @objc(removeOfObject:)
    @NSManaged public func removeFromOf(_ value: Activity)

    @objc(addOf:)
    @NSManaged public func addToOf(_ values: NSSet)

    @objc(removeOf:)
    @NSManaged public func removeFromOf(_ values: NSSet)

}

extension Benefit: Identifiable {

}

extension Benefit: HasKeyLastId {
    static var keyLastId: String = "benefitLastId"
}

extension Benefit: HasId {
    
}
