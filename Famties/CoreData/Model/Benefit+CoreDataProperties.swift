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
        return NSFetchRequest<Benefit>(entityName: "Benefit")
    }

    @NSManaged public var symbolName: String?
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var explanation: String?
    @NSManaged public var for: NSSet?

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
