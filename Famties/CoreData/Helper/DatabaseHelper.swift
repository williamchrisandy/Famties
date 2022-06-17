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
    
    init() {}
    
    func insert<T>(object: T) {
        do {
            guard let newObject = object as? NSManagedObject else {
                print("Object is not a type of NSManagedObject")
                return
            }
            context.insert(newObject)
            try context.save()
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func delete<T>(object: T) {
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
    
    func get<T>(object: T) {
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
