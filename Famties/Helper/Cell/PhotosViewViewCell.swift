//
//  PhotosViewViewCell.swift
//  Famties
//
//  Created by Hilmy Veradin on 04/07/22.
//

import UIKit

class PhotosViewViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let cellIdentifier = "PhotoIdentifier"
    
    @IBOutlet weak var photoCollectionView: UICollectionView! {
        didSet {
            photoCollectionView.delegate = self
            photoCollectionView.dataSource = self
            photoCollectionView.register(UINib(nibName: "DetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        }
    }
    
    var journal: Journal!
    var photos: [UIImage]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        photos = journal.photo
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        photoCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        //TODO: set collectionviewsize
        return CGSize(width:widthPerItem, height:100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! DetailCollectionViewCell
        cell.detailImageView.image = photos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

}
