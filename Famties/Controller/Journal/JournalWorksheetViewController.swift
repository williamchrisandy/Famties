//
//  JournalDetailViewController.swift
//  Famties
//
//  Created by Hilmy Veradin on 20/06/22.
//

import UIKit

class JournalWorksheetViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let moodList = ["Emoji1", "Emoji2", "Emoji3", "Emoji4", "Emoji5", "Emoji6", "Emoji7", "Emoji8", "Emoji9"]
    var amountMood: Int!
    var selectCell = MoodCollectionViewCell()
    
    override func viewDidLoad() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        
        amountMood = moodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moodCell", for: indexPath) as! MoodCollectionViewCell
        cell.moodEmoji.image = UIImage(named: moodList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amountMood
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0...(amountMood-1){
            selectCell = collectionView.cellForItem(at: IndexPath(row: i, section: 0)) as! MoodCollectionViewCell
            selectCell.moodBackground.image = UIImage(named: "Activity1_Journal")
        }
        
        selectCell = collectionView.cellForItem(at: indexPath) as! MoodCollectionViewCell
        
        selectCell.moodBackground.image = UIImage(named: "Activity16_Journal")
        
        print("selected " + String(indexPath.row))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 82, height: 84)
    }
}

extension JournalWorksheetViewController: EmbeddedViewControllerDelegate {
    func showLeftView() {
        self.view.alpha = 0
    }
    
    func showRightView() {
        self.view.alpha = 1
    }
    
    func loadBothView() {
        self.view.alpha = 0
    }
    
}
