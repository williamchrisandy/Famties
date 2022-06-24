//
//  HomeDetailViewController.swift
//  Famties
//
//  Created by Hilmy Veradin on 12/06/22.
//

import UIKit

class JournalRecapViewController: UIViewController {

    var journalRecapCollectionViewCell = "JournalRecapCollectionViewCell"
    
    @IBOutlet weak var journalTitle: UILabel!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

extension JournalRecapViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
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
        return cell
    }
    
    
    
}
