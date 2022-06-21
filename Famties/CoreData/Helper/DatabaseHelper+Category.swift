//
//  DatabaseHelper+Category.swift
//  Famties
//
//  Created by William Chrisandy on 17/06/22.
//

import CoreData

extension DatabaseHelper {
    
    func getCategories() -> [Category]
    {
        do {
            let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
            return try context.fetch(fetchRequest)
        }
        catch let error {
            print(error.localizedDescription)
            return []
        }
    }
    
    func getCategory(id: Int) -> Category? {
        do {
            let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest(id: id)
            let result = try context.fetch(fetchRequest)
            return result.isEmpty == true ? nil : result[0]
        }
        catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
