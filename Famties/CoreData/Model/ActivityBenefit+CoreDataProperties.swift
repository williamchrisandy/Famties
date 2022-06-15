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

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivityBenefit> {
        return NSFetchRequest<ActivityBenefit>(entityName: "ActivityBenefit")
    }

    @NSManaged public var benefitId: Int16
    @NSManaged public var activityId: Int16
    @NSManaged public var ofActivity: Activity?
    @NSManaged public var ofBenefit: Benefit?

}

extension ActivityBenefit : Identifiable {

}
