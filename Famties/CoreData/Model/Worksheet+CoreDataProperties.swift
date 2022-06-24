//
//  Worksheet+CoreDataProperties.swift
//  Famties
//
//  Created by William Chrisandy on 24/06/22.
//
//

import Foundation
import CoreData

extension Worksheet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Worksheet> {
        return NSFetchRequest<Worksheet>(entityName: "Worksheet")
    }

    @NSManaged public var data: Data?
    @NSManaged public var id: Int64
    @NSManaged public var index: Int16
    @NSManaged public var journal: Journal?

}

extension Worksheet : Identifiable {

}
