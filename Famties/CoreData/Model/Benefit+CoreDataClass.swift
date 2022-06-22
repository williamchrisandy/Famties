//
//  Benefit+CoreDataClass.swift
//  Famties
//
//  Created by William Chrisandy on 16/06/22.
//
//

import UIKit
import CoreData

@objc(Benefit)
public class Benefit: NSManagedObject {
    lazy var image: UIImage? = UIImage(named: "Benefit\(id)")
}
