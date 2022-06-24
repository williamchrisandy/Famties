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

    @nonobjc public class func fetchRequest(id: Int) -> NSFetchRequest<Worksheet> {
        let fetchRequest = NSFetchRequest<Worksheet>(entityName: "Worksheet")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        return fetchRequest
    }

    @nonobjc public class func fetchRequest(journalId: Int) -> NSFetchRequest<Worksheet> {
        let fetchRequest = NSFetchRequest<Worksheet>(entityName: "Worksheet")
        fetchRequest.predicate = NSPredicate(format: "journal.id == %i", journalId)
        return fetchRequest
    }
    
    @NSManaged public var data: Data?
    @NSManaged public var id: Int64
    @NSManaged public var index: Int16
    @NSManaged public var journal: Journal?

}

extension Worksheet : Identifiable {

}
