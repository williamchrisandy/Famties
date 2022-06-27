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
    func saveJournalData()
}

class JournalViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var journalView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    let DBHelper = DatabaseHelper()
    var journal: Journal?
    var delegates: [EmbeddedViewControllerDelegate?] = []
    var worksheetImage: [UIImage]!
    var worksheetPageCount: Int!
    var imageTemp: UIImage!
    
    
    //MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        initDesign()
        initVar()
    }
    
    func initDesign() {
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        
        // TODO: UIColor for segmented
    }
    
    func initVar(){
        for delegate in delegates {
            delegate?.showLeftView()
        }
        
        navigationItem.title = journal?.activity?.name
    }
    
    
    //MARK: Actions
    @IBAction func saveJournal(_ sender: Any) {
        for delegate in delegates {
            delegate?.saveJournalData()
        }
        DBHelper.saveContext()
        
    }
    
    @IBAction func switchView(_ sender: UISegmentedControl) {
        for delegate in delegates {
            if sender.selectedSegmentIndex == 0 {
                journalView.isHidden = true
                activityView.isHidden = false
                delegate?.showLeftView()
            } else {
                activityView.isHidden = true
                journalView.isHidden = false
                delegate?.showRightView()
            }
        }
    }
    
    
    //MARK: Overrides
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        initVar()
        
        if segue.identifier == "ActivityWorksheetViewSegue" {
            let destination = segue.destination as! ActivityWorksheetViewController
            delegates.append(destination)
            destination.journal = journal
        } else if segue.identifier == "JournalWorksheetViewSegue" {
            let destination = segue.destination as! JournalWorksheetViewController
            delegates.append(destination)
            destination.journal = journal
        }
    }
}
