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
                let rootURL = try FileManager.default.url(for: .picturesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let subDirectoryURL = rootURL.appendingPathComponent("Journal\(id)")
                
                try FileManager.default.createDirectory(at: subDirectoryURL, withIntermediateDirectories: false)
                
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
}
