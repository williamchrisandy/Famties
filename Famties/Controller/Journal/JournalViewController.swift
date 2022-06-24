//
//  WorksheetDetailViewController.swift
//  Famties
//
//  Created by Hilmy Veradin on 19/06/22.
//

import UIKit

protocol EmbeddedViewControllerDelegate {
    func showLeftView()
    func showRightView()
    func loadBothView()
}

class JournalViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var journalView: UIView!
    
    var delegates: [EmbeddedViewControllerDelegate?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for delegate in delegates {
            delegate?.loadBothView()
        }
        
    }
    
    @IBAction func switchView(_ sender: UISegmentedControl) {
        
        for delegate in delegates {
            if sender.selectedSegmentIndex == 0 {
                delegate?.showLeftView()
            } else {
                delegate?.showRightView()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ActivityWorksheetViewSegue" {
            let destination = segue.destination as! ActivityWorksheetViewController
            delegates.append(destination)
        }
        else if segue.identifier == "JournalWorksheetViewSegue" {
            let destination = segue.destination as! JournalWorksheetViewController
            delegates.append(destination)
        }
    }
    //    private func setupConstraint() {
//
//        let frameHeight = view.frame.height
//        let frameWidth = view.frame.width
//        let topAnchor = view.topAnchor
//        let bottomAnchor = view.bottomAnchor
//        let leftAnchor = view.leftAnchor
//        let rightAnchor = view.rightAnchor
//
//        WorksheetUISwitcher.anchor(top: topAnchor, paddingTop: frameHeight * 0.0981,
//                                   bottom: bottomAnchor, paddingBottom: frameHeight * 0.8785,
//                                   left: leftAnchor, paddingLeft: frameWidth * 0.1114,
//                                   right: rightAnchor, paddingRight: frameWidth * 0.1163)
//
//        worksheetContainer.anchor(top: topAnchor, paddingTop: frameHeight * 0.1326,
//                                   bottom: bottomAnchor, paddingBottom: frameHeight * 0.1523,
//                                   left: leftAnchor, paddingLeft: 0,
//                                   right: rightAnchor, paddingRight: 0)
//
//    }
}
