//
//  ActivityBenefit+CoreDataProperties.swift
//  Famties
//
//  Created by William Chrisandy on 16/06/22.
//
//

import Foundation
import CoreData


extension ActivityBenefit {

    @nonobjc public class func fetchRequest(activityId: Int) -> NSFetchRequest<ActivityBenefit> {
        let fetchRequest = NSFetchRequest<ActivityBenefit>(entityName: "ActivityBenefit")
        fetchRequest.predicate = NSPredicate(format: "activityId == %i", activityId)
        return fetchRequest
    }

    @NSManaged public var benefitId: Int16
    @NSManaged public var activityId: Int16
    @NSManaged public var ofActivity: Activity?
    @NSManaged public var ofBenefit: Benefit?

}

extension ActivityBenefit : Identifiable {

}
