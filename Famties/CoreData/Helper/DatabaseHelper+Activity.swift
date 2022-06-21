//
//  DatabaseHelper+Activity.swift
//  Famties
//
//  Created by William Chrisandy on 17/06/22.
//

import CoreData

extension DatabaseHelper {
    
    func getActivities(showAll: Bool) -> [Activity] {
        do {
            let fetchRequest: NSFetchRequest<Activity> = Activity.fetchRequest(showAll: showAll)
            return try context.fetch(fetchRequest)
        }
        catch let error {
            print(error.localizedDescription)
            return []
        }
    }
    
    func getFavoriteActivities(showAll: Bool) -> [Activity] {
        do {
            let fetchRequest: NSFetchRequest<Activity> = Activity.fetchRequestFavorited(showAll: showAll)
            return try context.fetch(fetchRequest)
        }
        catch let error {
            print(error.localizedDescription)
            return []
        }
    }
    
    func getActivity(id: Int) -> Activity? {
        do {
            let fetchRequest: NSFetchRequest<Activity> = Activity.fetchRequest(id: id)
            let result = try context.fetch(fetchRequest)
            return result.isEmpty == true ? nil : result[0]
        }
        catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getActivities(categoryId: Int, showAll: Bool) -> [Activity] {
        do {
            let fetchRequest: NSFetchRequest<Activity> = Activity.fetchRequest(categoryId: categoryId, showAll: showAll)
            return try context.fetch(fetchRequest)
        }
        catch let error {
            print(error.localizedDescription)
            return []
        }
    }
    
    func getActivities(contains: String) -> [Activity] {
        do {
            let fetchRequest: NSFetchRequest<Activity> = Activity.fetchRequest(contains: contains)
            return try context.fetch(fetchRequest)
        }
        catch let error {
            print(error.localizedDescription)
            return []
        }
    }
    
    func getActivities(contains: String, from categoryId: Int) -> [Activity] {
        do {
            let fetchRequest: NSFetchRequest<Activity> = Activity.fetchRequest(contains: contains, categoryId: categoryId)
            return try context.fetch(fetchRequest)
        }
        catch let error {
            print(error.localizedDescription)
            return []
        }
    }
}
