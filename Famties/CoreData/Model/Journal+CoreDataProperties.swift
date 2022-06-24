//
//  Journal+CoreDataProperties.swift
//  Famties
//
//  Created by William Chrisandy on 24/06/22.
//
//

import Foundation
import CoreData


extension Journal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Journal> {
        return NSFetchRequest<Journal>(entityName: "Journal")
    }

    @nonobjc public class func fetchRequest(id: Int) -> NSFetchRequest<Journal> {
        let fetchRequest = NSFetchRequest<Journal>(entityName: "Journal")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdTime", ascending: false)]
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(activityId: Int) -> NSFetchRequest<Journal> {
        let fetchRequest = NSFetchRequest<Journal>(entityName: "Journal")
        fetchRequest.predicate = NSPredicate(format: "activity.id == %i", activityId)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdTime", ascending: false)]
        return fetchRequest
    }
    
    @NSManaged public var childName: String?
    @NSManaged public var createdTime: Date?
    @NSManaged public var id: Int64
    @NSManaged public var lastEdited: Date?
    @NSManaged public var lessonLearned: String?
    @NSManaged public var mood: Int16
    @NSManaged public var name: String?
    @NSManaged public var activity: Activity?
    @NSManaged public var worksheets: NSSet?

}

// MARK: Generated accessors for worksheets
extension Journal {

    @objc(addWorksheetsObject:)
    @NSManaged public func addToWorksheets(_ value: Worksheet)

    @objc(removeWorksheetsObject:)
    @NSManaged public func removeFromWorksheets(_ value: Worksheet)

    @objc(addWorksheets:)
    @NSManaged public func addToWorksheets(_ values: NSSet)

    @objc(removeWorksheets:)
    @NSManaged public func removeFromWorksheets(_ values: NSSet)

}

extension Journal : Identifiable {

}
