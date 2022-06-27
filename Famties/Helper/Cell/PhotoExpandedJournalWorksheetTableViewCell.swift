//
//  PhotoExpandedJournalWorksheetTableViewCell.swift
//  Famties
//
//  Created by Hocky on 26/06/22.
//

import UIKit

class PhotoExpandedJournalWorksheetTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //MARK: Properties
    @IBOutlet weak var photoExpandedHeaderLabel: UILabel!
    @IBOutlet weak var photoExpandedDescriptionLabel: UILabel!
    @IBOutlet weak var photoExpandedCollectionView: UICollectionView!
    
    let DBHelper = DatabaseHelper()
    var journal: Journal?
    var photoUploadCount: Int!
    var delegates: JournalMediaPickerDelegate?
    var deleterDelegate: JournalMediaDeleterDelegate?
    var photos: [UIImage]!
    
    
    //MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        initDesign()
        initVar()
    }

    func initDesign(){
        // layouts
    }
    
    func initVar(){
        // declares
        photoExpandedCollectionView.delegate = self
        photoExpandedCollectionView.dataSource = self
        photoExpandedCollectionView.reloadData()
    }
    
    
    //MARK: Overrides
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if photoUploadCount < 6 {
            return 1 + photoUploadCount
        } else {
            return photoUploadCount
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if photoUploadCount < 6 {
            if indexPath.row == 0 {
                return CGSize(width: 150, height: 240)
            } else {
                return CGSize(width: 330, height: 240)
            }
        } else {
            return CGSize(width: 330, height: 240)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if photoUploadCount < 6 {
            if indexPath.row == 0 {
                let cell = photoExpandedCollectionView.dequeueReusableCell(withReuseIdentifier: "photoUploadCell", for: indexPath) as! PhotoUploadCollectionViewCell
                cell.delegates = delegates
                return cell
            } else {
                let cell = photoExpandedCollectionView.dequeueReusableCell(withReuseIdentifier: "photoPreviewCell", for: indexPath) as! PhotoPreviewCollectionViewCell
                cell.photoPreviewImageView.image = photos[indexPath.row - 1]
                cell.deleterDelegate = deleterDelegate
                cell.currentIndex = indexPath.row - 1
                return cell
            }
        } else {
            let cell = photoExpandedCollectionView.dequeueReusableCell(withReuseIdentifier: "photoPreviewCell", for: indexPath) as! PhotoPreviewCollectionViewCell
            cell.photoPreviewImageView.image = photos[indexPath.row]
            cell.deleterDelegate = deleterDelegate
            cell.currentIndex = indexPath.row
            return cell
        }
    }

}
