//
//  Journal+CoreDataClass.swift
//  Famties
//
//  Created by William Chrisandy on 24/06/22.
//
//

import UIKit
import CoreData

@objc(Journal)
public class Journal: NSManagedObject {
    var photo: [UIImage] {
        get {
            var result: [UIImage] = []
            do {
                let rootURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let subDirectoryURL = rootURL.appendingPathComponent("Journal\(id)")
                
                
                for index in 0...5 {
                    let saveURL = subDirectoryURL.appendingPathComponent("Journal\(id)_Photo\(index+1).png")
                    
                    if let image = UIImage(contentsOfFile: saveURL.path) {
                        result.append(image)
                    }
                }
            }
            catch {
                print(error.localizedDescription)
            }
            return result
        }
    }
    
    
    /*
     Per journal start
     categoryPoint += journalId * 0.3
     activityPoint += journalId * 0,1

     Per journal end:
     categoryPoint += journalId * mood * 0,05
     activityPoint += journalId * mood * 0,1
     */
    
    func addActivityPoint() {
        activity?.point += Double(id) * Double(mood) * 0.1
        activity?.partOf?.point += Double(id) * Double(mood) * 0.05
        activity?.updateTotalPoint()
    }
}
