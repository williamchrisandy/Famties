//
//  DatabaseHelper+Benefit.swift
//  Famties
//
//  Created by William Chrisandy on 17/06/22.
//

import CoreData

extension DatabaseHelper {
    func getBenefit(id: Int) -> Benefit? {
        do {
            let fetchRequest: NSFetchRequest<Benefit> = Benefit.fetchRequest(id: id)
            let result = try context.fetch(fetchRequest)
            return result.isEmpty == true ? nil : result[0]
        }
        catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
