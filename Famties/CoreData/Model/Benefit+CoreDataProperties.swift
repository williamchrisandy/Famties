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

    @nonobjc public class func fetchRequest(id: Int) -> NSFetchRequest<Benefit> {
        let fetchRequest = NSFetchRequest<Benefit>(entityName: "Benefit")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        return fetchRequest
    }

    @NSManaged public var symbolName: String?
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var explanation: String?
    @NSManaged public var of: NSSet?

}

// MARK: Generated accessors for for
extension Benefit {

    @objc(addForObject:)
    @NSManaged public func addToFor(_ value: ActivityBenefit)

    @objc(removeForObject:)
    @NSManaged public func removeFromFor(_ value: ActivityBenefit)

    @objc(addFor:)
    @NSManaged public func addToFor(_ values: NSSet)

    @objc(removeFor:)
    @NSManaged public func removeFromFor(_ values: NSSet)

}

extension Benefit : Identifiable {

}
