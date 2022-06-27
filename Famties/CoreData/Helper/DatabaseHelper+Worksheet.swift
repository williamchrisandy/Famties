//
//  DatabaseHelper+Worksheet.swift
//  Famties
//
//  Created by William Chrisandy on 24/06/22.
//

import PencilKit
import CoreData

extension DatabaseHelper {
    func createBlankWorksheet(for journal: Journal) {
        for index in 0..<(journal.activity?.worksheetImage.count ?? 0) {
            let worksheet = Worksheet(context: context)
            worksheet.index = Int16(index)
            worksheet.data = PKDrawing().dataRepresentation()
            worksheet.journal = journal
            insert(worksheet)
        }
    }
}
