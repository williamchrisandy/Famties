//
//  HomeDetailViewController.swift
//  Famties
//
//  Created by Hilmy Veradin on 12/06/22.
//

import UIKit

class JournalRecapViewController: UIViewController {
    
    // MARK: - Properties
    // Identifier
    var journalRecapCollectionViewCell = "JournalRecapCollectionViewCell"
    
    // IBOutlet
    @IBOutlet weak var journalTitle: UILabel! {
        didSet {
            adjustTextSize(label: journalTitle)
            journalTitle.isUserInteractionEnabled = true
            let titleTapGesture = UITapGestureRecognizer(target: self, action: #selector(titleTapped))
            journalTitle.addGestureRecognizer(titleTapGesture)
            titleTapGesture.numberOfTapsRequired = 1
        }
    }
    @IBOutlet weak var journalKidName: UILabel! {
        didSet {
            journalKidName.isUserInteractionEnabled = true
            let nameTapGesture = UITapGestureRecognizer(target: self, action: #selector(nameTapped))
            nameTapGesture.numberOfTapsRequired = 1
            journalKidName.addGestureRecognizer(nameTapGesture)
        }
    }
    @IBOutlet weak var journalCollectionView: UICollectionView! {
        didSet {
            journalCollectionView.delegate = self
            journalCollectionView.dataSource = self
            journalCollectionView.register(UINib(nibName: "JournalRecapCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: journalRecapCollectionViewCell)
        }
    }
    @IBOutlet weak var lastEditedJournalText: UILabel!
    @IBOutlet weak var createdAtJournalText: UILabel!
    @IBOutlet weak var slideRightButton: UIButton!
    @IBOutlet weak var slideLeftButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    // Property Type
    var currentIndex = 0
    var journals: [Journal] = []
    var selectedJournal: Journal!
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        journalCollectionView.layer.cornerRadius = 15
        titleTextField.delegate = self
        nameTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
        loadTextViews(at: 0)
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
        titleTextField.isHidden = true
        nameTextField.isHidden = true
    }
    
    //MARK: - Helpers
    
    @objc private func titleTapped() {
        journalTitle.isHidden = true
        titleTextField.isHidden = false
        titleTextField.text = journalTitle.text
    }
    
    @objc private func nameTapped() {
        journalKidName.isHidden = true
        nameTextField.isHidden = false
        nameTextField.text = journalKidName.text
    }
    
    @IBAction func slideRightButtonTapped(_ sender: Any) {
        currentIndex += 1
        if currentIndex > journals.count - 1 { currentIndex = 0 }
        loadTextViews(at: currentIndex)
        journalCollectionView.scrollToItem(at: IndexPath.init(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func slideLeftButtonTapped(_ sender: Any) {
        currentIndex -= 1
        if currentIndex < 0 { currentIndex = journals.count - 1 }
        loadTextViews(at: currentIndex)
        journalCollectionView.scrollToItem(at: IndexPath.init(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    private func loadData() {
        let databaseHelper = DatabaseHelper()
        journals = databaseHelper.getJournals()
    }
    
    private func loadTextViews(at index: Int) {
        
        let createdText = dateToTexts(date: journals[index].createdTime!)
        let editedText = dateToTexts(date: journals[index].lastEdited!)
        
        journalTitle.text = journals[index].name
        journalKidName.text = "👧 \(journals[index].childName!)"
        createdAtJournalText.text = "Created At: \(createdText)"
        lastEditedJournalText.text = "Last Edited: \(editedText)"
    }
    
    private func adjustTextSize(label: UILabel) {
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
    }
    
    private func dateToTexts(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y"
        return formatter.string(from: date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "collectionToJournal" {
            let destination = segue.destination as! JournalViewController
            destination.journal = selectedJournal
            destination.mode = "Edit"
        }
    }
    
    @IBAction func unwindToJournalRecap(_ segue: UIStoryboardSegue) {
        if segue.identifier == "finishedFromJournalRecapWithSavedSegue" {
            
        }
    }
}

//MARK: - UICollectionView Data and Delegate
extension JournalRecapViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return journals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: journalRecapCollectionViewCell, for: indexPath) as! JournalRecapCollectionViewCell
        let journal = journals[indexPath.item]
        let cellImage = journal.activity?.coverImage!.resized(to: cell.frame.size)
        
        cell.journal = journal
        cell.JournalCollectionImage.image = cellImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! JournalRecapCollectionViewCell
        selectedJournal = cell.journal
        performSegue(withIdentifier: "collectionToJournal", sender: self)
    }
}

extension JournalRecapViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            titleTextField.resignFirstResponder()
            setDetailText(textField: textField, text: textField.text ?? journalTitle.text!)
            return true
        } else {
            nameTextField.resignFirstResponder()
            setDetailText(textField: textField, text: textField.text ?? "👧 \(journalKidName.text!)")
            return true
        }
    }
    
    private func setDetailText(textField: UITextField, text: String) {
        let databaseHelper = DatabaseHelper()
        if textField == titleTextField {
            journalTitle.text = text
            journals[currentIndex].name = text
            databaseHelper.saveContext()
            textField.isHidden = true
            journalTitle.isHidden = false
        } else {

            if text.contains("👧") {
                journalKidName.text = "\(text)"
            } else {
                journalKidName.text = "👧 \(text)"
            }
            journals[currentIndex].childName = text
            databaseHelper.saveContext()
            textField.isHidden = true
            journalKidName.isHidden = false
        }
    }
}
