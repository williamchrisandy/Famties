//
//  MoodJournalWorksheetTableViewCell.swift
//  Famties
//
//  Created by Hocky on 26/06/22.
//

import UIKit

class MoodJournalWorksheetTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: Properties
    @IBOutlet weak var moodHeaderLabel: UILabel!
    @IBOutlet weak var moodDescriptionLabel: UILabel!
    @IBOutlet weak var moodCollectionView: UICollectionView!
    
    let DBHelper = DatabaseHelper()
    var journal: Journal?
    let moodList = ["Emoji1", "Emoji2", "Emoji3", "Emoji4", "Emoji5", "Emoji6", "Emoji7", "Emoji8", "Emoji9"]
    var moodCount: Int!
    var selectCell = MoodCollectionViewCell()
    var moodCellWidth: CGFloat!
    var moodCellHeight: CGFloat!
    var moodCellSpacing: CGFloat!
    
    
    //MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        initVar()
        initDesign()
    }

    func initDesign(){
        
    }
    
    func initVar(){
        moodCount = 9
        moodCellWidth = 68.0
        moodCellHeight = 68.0
        moodCellSpacing = 15.0
        
        moodCollectionView.delegate = self
        moodCollectionView.dataSource = self
    }
    
    
    //MARK: Functions
    func saveData(moodNum: Int16){
        journal?.mood = moodNum
//        DBHelper.saveContext()
    }
    
    
    //MARK: Overrides
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moodCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moodCollectionView.dequeueReusableCell(withReuseIdentifier: "moodCell", for: indexPath) as! MoodCollectionViewCell
        cell.moodBackground.backgroundColor = UIColor(named: "ManagementColor")
        cell.moodBackground.layer.cornerRadius = cell.frame.height/2
        cell.moodEmoji.image = UIImage(named: moodList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0...(moodCount-1){
            selectCell = collectionView.cellForItem(at: IndexPath(row: i, section: 0)) as! MoodCollectionViewCell
            selectCell.moodBackground.backgroundColor = UIColor(named: "ManagementColor")
        }
        
        selectCell = collectionView.cellForItem(at: indexPath) as! MoodCollectionViewCell
        selectCell.moodBackground.backgroundColor = UIColor(named: "ActivityTitleColor")
        saveData(moodNum: Int16(indexPath.row))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: moodCellWidth, height: moodCellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalWidth = moodCellWidth * CGFloat(moodCount)
        let totalSpacingWidth = moodCellSpacing * CGFloat(moodCount - 1)
        let leftInset = max(0.0,(moodCollectionView.frame.size.width - CGFloat(totalWidth + totalSpacingWidth)) / 2)
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }

}
