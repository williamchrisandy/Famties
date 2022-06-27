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
    
    
    //MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        initDesign()
        initVar()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func initDesign() {
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor(named: "PageControlTintColor")!], for: .normal)
        
        // TODO: UIColor for segmented
    }
    
    func initVar(){
        for delegate in delegates {
            delegate?.showLeftView()
        }
        navigationItem.title = journal?.activity?.name
    }
    
    override func willMove(toParent parent: UIViewController?) {
        DBHelper.rollbackContext()
    }
    
    //MARK: Actions
    @IBAction func saveJournal(_ sender: Any) {
        for delegate in delegates {
            delegate?.saveJournalData()
        }
        
        journal?.lastEdited = Date()
        
        let titleFilled = journal?.name != "Journal \(journal?.id ?? -1)"
        let childNameFilled = journal?.childName != "Unnamed"
        
        if titleFilled == false || childNameFilled == false {
            let addJournalAlertController = UIAlertController(title: "Save Journal", message: "", preferredStyle: .alert)
            
            addJournalAlertController.addTextField {
                [unowned self] textField in
                textField.placeholder = "Journal Title"
                if journal?.name != "Journal \(journal?.id ?? -1)" { textField.text = journal?.name}
            }
            
            addJournalAlertController.addTextField {
                [unowned self] textField in
                textField.placeholder = "Your Child Name"
                if journal?.childName != "Unnamed" { textField.text = journal?.childName}
            }
            
            let saveAction = UIAlertAction(title: "Save", style: .default) {
                [unowned addJournalAlertController, unowned self] action in
                
                unowned let textFieldJournalName = addJournalAlertController.textFields![0]
                let journalName = textFieldJournalName.text!
                
                unowned let textFieldChildName = addJournalAlertController.textFields![1]
                let childName = textFieldChildName.text!
                
                if journalName.count > 0 { journal?.name = journalName }
                if childName.count > 0 { journal?.childName = childName }
                DBHelper.saveContext()
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            addJournalAlertController.addAction(saveAction)
            addJournalAlertController.addAction(cancelAction)
            present(addJournalAlertController, animated: true)
            
        }
        else {
            DBHelper.saveContext()
        }
        
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
