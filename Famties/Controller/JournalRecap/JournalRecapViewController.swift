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
        }
    }
    @IBOutlet weak var journalKidName: UILabel!
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
    
    // Property Type
    var currentIndex = 0
    var imageArray: [UIImage] = []
    var nameArray: [String] = []
    var titleArray: [String] = []
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        let databaseHelper = DatabaseHelper()
        
        journalCollectionView.layer.cornerRadius = 15
        
        imageArray.append((UIImage(named: "Activity1_Journal")!))
        imageArray.append((UIImage(named: "Activity16_Journal")!))
        imageArray.append((UIImage(named: "Activity17_Journal")!))
        imageArray.append((UIImage(named: "Activity22_Journal")!))
        
        titleArray.append("Making Dream Comes True with Nano")
        titleArray.append("Lovely Gift Creating with Zoya")
        titleArray.append("Lovely Gift Creating Creating Creating")
        titleArray.append("Expressing Agreement or Disagreement Together")
        
        nameArray.append("Nano")
        nameArray.append("Zoya")
        nameArray.append("Budi")
        nameArray.append("Joji")
        
        journalTitle.text = titleArray[0]
        journalKidName.text = nameArray[0]
    }
    
    //MARK: - Helpers
    @IBAction func slideRightButtonTapped(_ sender: Any) {
        currentIndex += 1
        if currentIndex > imageArray.count - 1 { currentIndex = 0 }
        journalTitle.text = titleArray[currentIndex]
        journalKidName.text = nameArray[currentIndex]
        journalCollectionView.scrollToItem(at: IndexPath.init(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func slideLeftButtonTapped(_ sender: Any) {
        currentIndex -= 1
        if currentIndex < 0 { currentIndex = imageArray.count - 1 }
        journalTitle.text = titleArray[currentIndex]
        journalKidName.text = nameArray[currentIndex]
        journalCollectionView.scrollToItem(at: IndexPath.init(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    private func adjustTextSize(label: UILabel) {
        label.minimumScaleFactor = 0.95
        label.adjustsFontSizeToFitWidth = true
    }
}

//MARK: - UICollectionView Data and Delegate
extension JournalRecapViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
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
        let cellImage = imageArray[indexPath.item].resized(to: cell.frame.size)
        cell.JournalCollectionImage.image = cellImage
        return cell
    }
}
