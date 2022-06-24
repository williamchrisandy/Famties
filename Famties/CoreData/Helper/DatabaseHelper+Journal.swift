//
//  DatabaseHelper+Journal.swift
//  Famties
//
//  Created by William Chrisandy on 24/06/22.
//

import CoreData

extension DatabaseHelper {
    func getJournals(activityId: Int) -> [Journal] {
        do {
            let fetchRequest: NSFetchRequest<Journal> = Journal.fetchRequest(activityId: activityId)
            return try context.fetch(fetchRequest)
        }
        catch let error {
            print(error.localizedDescription)
            return []
        }
    }
    
    func getJournal(id: Int) -> Journal? {
        do {
            let fetchRequest: NSFetchRequest<Journal> = Journal.fetchRequest(id: id)
            let result = try context.fetch(fetchRequest)
            return result.isEmpty == true ? nil : result[0]
        }
        catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func createBlankJournal(from activity: Activity) -> Journal {
        let journal = Journal(context: context)
        journal.createdTime = Date()
        journal.lastEdited = Date()
        journal.activity = activity
        insert(journal)
        
        journal.name = "Journal \(journal.id)"
        journal.childName = "Unnamed"
        saveContext()
        
        return journal
    }
}
