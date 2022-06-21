//
//  DatabaseHelper.swift
//  Famties
//
//  Created by William Chrisandy on 17/06/22.
//

import UIKit
import CoreData

class DatabaseHelper {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        if UserDefaults.standard.bool(forKey: DatabaseHelper.keyFirstTimev1) == false { initializeV1() }
    }
    
    func insert<T: Identifiable>(_ object: T) {
        do {
            guard let newObject = object as? NSManagedObject else {
                print("Object is not a type of NSManagedObject")
                return
            }
            
            if let objectWithKeyLastId = newObject as? HasKeyLastId {
                let keyLastId = type(of: objectWithKeyLastId).keyLastId
                
                guard var objectWithId = objectWithKeyLastId as? HasId else {
                    print("Object does not have an id")
                    return
                }
                
                objectWithId.id = Int64(UserDefaults.standard.integer(forKey: keyLastId) + 1)
                UserDefaults.standard.set(objectWithId.id, forKey: keyLastId)
            }
            
            context.insert(newObject)
            try context.save()
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func delete<T>(_ object: T) {
        do {
            guard let targetObject = object as? NSManagedObject else {
                print("Object is not a type of NSManagedObject")
                return
            }
            context.delete(targetObject)
            try context.save()
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
}

//INITIALIZER
extension DatabaseHelper {
    func initializeV1() {
        //Category
        let category1 = Category(context: context)
        category1.name = "Self Awareness"
        insert(category1)
        
        let category2 = Category(context: context)
        category2.name = "Self Management"
        insert(category2)
        
        let category3 = Category(context: context)
        category3.name = "Social Awareness"
        insert(category3)
        
        let category4 = Category(context: context)
        category4.name = "Relationship Skills"
        insert(category4)
        
        let category5 = Category(context: context)
        category5.name = "Responsible Decision Making"
        insert(category5)
        
        
        //Benefit
        let benefit1 = Benefit(context: context)
        benefit1.name = "Emotion Regulation"
        benefit1.explanation = "This activity helps children control their emotional state."
        insert(benefit1)
        
        let benefit2 = Benefit(context: context)
        benefit2.name = "Innovative"
        benefit2.explanation = "This activity helps children create and adapt to change."
        insert(benefit2)
        
        let benefit3 = Benefit(context: context)
        benefit3.name = "Impulse Control"
        benefit3.explanation = "This activity helps children resist from engaging in certain behaviors."
        insert(benefit3)
        
        
        //Activity
        let activity1 = Activity(context: context)
        activity1.name = "Creating Your Own Luck!"
        activity1.estimatedTime = 30
        activity1.explanation = "Many children believe results are often a matter of luck. By doing this activity, we want to help parents teach their children how to create their own luck. Through this activity, parents can encourage their children to dream big and turn them a reality by setting goals and making plans."
        activity1.partOf = category2
        insert(activity1)
        
        let activity1Benefit1 = ActivityBenefit(context: context)
        activity1.addToHas(activity1Benefit1)
        benefit1.addToFor(activity1Benefit1)
        insert(activity1Benefit1)
        
        let activity1Benefit2 = ActivityBenefit(context: context)
        activity1.addToHas(activity1Benefit2)
        benefit2.addToFor(activity1Benefit2)
        insert(activity1Benefit2)
        
        let activity1Benefit3 = ActivityBenefit(context: context)
        activity1.addToHas(activity1Benefit3)
        benefit3.addToFor(activity1Benefit3)
        insert(activity1Benefit3)
        
        
        UserDefaults.standard.set(true, forKey: DatabaseHelper.keyFirstTimev1)
    }
}
