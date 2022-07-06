//
//  LearnedJournalWorksheetTableViewCell.swift
//  Famties
//
//  Created by Hocky on 26/06/22.
//

import UIKit

class LearnedJournalWorksheetTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var learnedHeaderLabel: UILabel!
    @IBOutlet weak var learnedDescriptionLabel: UILabel!
    @IBOutlet weak var learnedTextView: UITextView!
    
    let DBHelper = DatabaseHelper()
    var journal: Journal?
    var doneFirstTime: Bool!
    var editDelegate: EditControllerDelegate?
    
    
    //MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        initDesign()
        initVar()
    }

    func initDesign(){
        learnedTextView.layer.cornerRadius = 10
        learnedTextView.layer.borderWidth = 1
    }
    
    func initVar(){
        learnedTextView.delegate = self
        doneFirstTime = false
    }
    
    //MARK: Functions
    func saveData(){
        journal?.lessonLearned = learnedTextView.text
//        DBHelper.saveContext()
    }
    
    func loadData(){
        if journal?.lessonLearned != "" {
            learnedTextView.text = journal?.lessonLearned
            doneFirstTime = true
            learnedTextView.textColor = UIColor(named: "ActivityTitleColor")
        }
        
    }
}

extension LearnedJournalWorksheetTableViewCell: UITextViewDelegate{
    
    @objc func dismissKeyboard()
        {
            self.endEditing(true)
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            dismissKeyboard()
        }
        
        func textViewDidEndEditing(_ textView: UITextView)
        {
            dismissKeyboard()
            saveData()
        }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (!doneFirstTime){
            learnedTextView.text = ""
            learnedTextView.textColor = UIColor(named: "ActivityTitleColor")
        }
        doneFirstTime = true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        editDelegate?.updateEditStatus()
    }
}
