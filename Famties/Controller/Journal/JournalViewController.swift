//
//  WorksheetDetailViewController.swift
//  Famties
//
//  Created by Hilmy Veradin on 19/06/22.
//

import UIKit

class JournalViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var WorksheetUISwitcher: UISegmentedControl!
    @IBOutlet weak var worksheetContainer: UIView!
    @IBOutlet weak var journalContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupConstraint() {
        
        let frameHeight = view.frame.height
        let frameWidth = view.frame.width
        let topAnchor = view.topAnchor
        let bottomAnchor = view.bottomAnchor
        let leftAnchor = view.leftAnchor
        let rightAnchor = view.rightAnchor
        
        WorksheetUISwitcher.anchor(top: topAnchor, paddingTop: frameHeight * 0.0981,
                                   bottom: bottomAnchor, paddingBottom: frameHeight * 0.8785,
                                   left: leftAnchor, paddingLeft: frameWidth * 0.1114,
                                   right: rightAnchor, paddingRight: frameWidth * 0.1163)
        
        worksheetContainer.anchor(top: topAnchor, paddingTop: frameHeight * 0.1326,
                                   bottom: bottomAnchor, paddingBottom: frameHeight * 0.1523,
                                   left: leftAnchor, paddingLeft: 0,
                                   right: rightAnchor, paddingRight: 0)
        
    }
}
