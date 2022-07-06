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
        if UserDefaults.standard.bool(forKey: DatabaseHelper.keyFirstTimev1s0) == false { initializeV1s0() }
        if UserDefaults.standard.bool(forKey: DatabaseHelper.keyFirstTimev1s1) == false { initializeV1s1() }
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
            context.refreshAllObjects()
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
            
            if let journal = targetObject as? Journal {
                deletePhotos(journal: journal)
            }
            
            context.delete(targetObject)
            try context.save()
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func saveContext() {
        do {
            try context.save()
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func rollbackContext() {
        context.rollback()
    }
}

//INITIALIZER
extension DatabaseHelper {
    func initializeV1s0() {
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
        activity1.addToHas(benefit1)
        activity1.addToHas(benefit2)
        activity1.addToHas(benefit3)
        insert(activity1)
        
        let activity2 = Activity(context: context)
        activity2.name = "Affirmation Messages"
        activity2.estimatedTime = 30
        activity2.explanation = "Through this activity, parents can exercise how to motivate their children with encouraging messages and confidence in believing their inner potential and future growth. Parents and children can brainstorm together on things they believe are a strong trait for their children."
        activity2.partOf = category1
        activity2.addToHas(benefit1)
        activity2.addToHas(benefit2)
        activity2.addToHas(benefit3)
        insert(activity2)
        
        UserDefaults.standard.set(true, forKey: DatabaseHelper.keyFirstTimev1s0)
    }
    
    func initializeV1s1() {
        deleteAllJournals()
        
        //Category
        getCategory(id: 5)?.name = "Decision Making"
        saveContext()
        
        //Benefit 4-7
        let benefit4 = Benefit(context: context)
        benefit4.name = "Communication"
        benefit4.explanation = "This activity helps children communicate and understand both themselves and other people."
        insert(benefit4)
        
        let benefit5 = Benefit(context: context)
        benefit5.name = "Social Initiation"
        benefit5.explanation = "This activity helps children to initiate or begin interactions with other people."
        insert(benefit5)
        
        let benefit6 = Benefit(context: context)
        benefit6.name = "Empathy"
        benefit6.explanation = "This activity helps children recognize emotion in others."
        insert(benefit6)
        
        let benefit7 = Benefit(context: context)
        benefit7.name = "Critical Thinking"
        benefit7.explanation = "This activity helps children analyze and think objectively."
        insert(benefit7)
        
        
        //Activity
        let activity3 = Activity(context: context)
        activity3.name = "Ways to Say Sorry"
        activity3.estimatedTime = 30
        activity3.explanation = "Saying sorry is not an easy task for many kids, even for adults. However learning how to say sorry and eventually mean it is an important skill that children needs to have. Through this activity, you can help your children make an apology."
        activity3.partOf = getCategory(id: 3)
        activity3.addToHas(benefit6)
        activity3.addToHas(benefit5)
        activity3.addToHas(benefit4)
        insert(activity3)
        
        let activity4 = Activity(context: context)
        activity4.name = "Letter to My Friend"
        activity4.estimatedTime = 30
        activity4.explanation = "Making friends during pandemic can be really challenging during remote learning, let alone keeping them. This activity will help your children learn how to maintain friendships and stay connected even when they can not see their friends in person."
        activity4.partOf = getCategory(id: 4)
        activity4.addToHas(benefit6)
        activity4.addToHas(benefit5)
        activity4.addToHas(benefit4)
        insert(activity4)
        
        let activity5 = Activity(context: context)
        activity5.name = "Action & Consequences"
        activity5.estimatedTime = 30
        activity5.explanation = "Making friends during pandemic can be really challenging during remote learning, let alone keeping them. This activity will help your children learn how to maintain friendships and stay connected even when they can not see their friends in person."
        activity5.partOf = getCategory(id: 5)
        activity5.addToHas(benefit7)
        activity5.addToHas(getBenefit(id: 2)!)
        activity5.addToHas(getBenefit(id: 3)!)
        insert(activity5)
        
        UserDefaults.standard.set(true, forKey: DatabaseHelper.keyFirstTimev1s1)
    }
}
