//
//  DatabaseHelper+Journal.swift
//  Famties
//
//  Created by William Chrisandy on 24/06/22.
//

import UIKit
import CoreData
import AVFoundation

extension DatabaseHelper {
    func getJournals() -> [Journal] {
        do {
            let fetchRequest: NSFetchRequest<Journal> = Journal.fetchRequest()
            return try context.fetch(fetchRequest)
        }
        catch let error {
            print(error.localizedDescription)
            return []
        }
    }
    
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
        createBlankWorksheet(for: journal)
        
        saveContext()
        
        
        
        return journal
    }
    
    func save(images: [UIImage], journal: Journal) {
        do {
            let rootURL = try FileManager.default.url(for: .picturesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let subDirectoryURL = rootURL.appendingPathComponent("Journal\(journal.id)")
            
            try FileManager.default.createDirectory(at: subDirectoryURL, withIntermediateDirectories: true)
            try FileManager.default.removeItem(at: subDirectoryURL)
            try FileManager.default.createDirectory(at: subDirectoryURL, withIntermediateDirectories: true)
            
            for index in 0..<images.count {
                let saveURL = subDirectoryURL.appendingPathComponent("Journal\(journal.id)_Photo\(index+1).png")
                
                if let pngData = images[index].pngData() {
                    try pngData.write(to: saveURL)
                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func deletePhotos(journal: Journal) {
        do {
            let rootURL = try FileManager.default.url(for: .picturesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let subDirectoryURL = rootURL.appendingPathComponent("Journal\(journal.id)")
            try FileManager.default.removeItem(at: subDirectoryURL)
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
