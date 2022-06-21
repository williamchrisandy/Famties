//
//  DatabaseHelper+Constants.swift
//  Famties
//
//  Created by William Chrisandy on 17/06/22.
//

import Foundation

protocol HasKeyLastId {
    static var keyLastId: String { get }
}

protocol HasId {
    var id: Int64 { get set }
}

extension DatabaseHelper {
    static let limitedDataMaxCount = 10
    static let keyFirstTimev1 = "firstTimev1.0"
}
