//
//  Activity+CoreDataClass.swift
//  Famties
//
//  Created by William Chrisandy on 16/06/22.
//
//

import UIKit
import CoreData

@objc(Activity)
public class Activity: NSManagedObject {
    
    lazy var bannerImage: UIImage? = UIImage(named: "Activity\(id)_Banner")
    
    lazy var coverImage: UIImage? = UIImage(named: "Activity\(id)_Preview")
    
    lazy var journalImage: UIImage? = UIImage(named: "Activity\(id)_Journal")
    
    lazy var howToImage: [UIImage] = {
        var result: [UIImage] = []
        var i = 1
        while let image = UIImage(named: "Activity\(id)_HowTo\(i)") {
            result.append(image)
            i += 1
        }
        return result
    }()
    
    lazy var worksheetImage: [UIImage] = {
        var result: [UIImage] = []
        var i = 1
        while let image = UIImage(named: "Activity\(id)_Worksheet\(i)") {
            result.append(image)
            i += 1
        }
        return result
    }()
    
    func updateTotalPoint() {
        totalPoint = point + partOf!.point
    }
}
