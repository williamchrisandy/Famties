//
//  PhotoPreviewCollectionViewCell.swift
//  Famties
//
//  Created by Hocky on 26/06/22.
//

import UIKit

class PhotoPreviewCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    @IBOutlet weak var photoPreviewImageView: UIImageView!
    @IBOutlet weak var photoDeleteButton: UIButton!
    
    weak var deleterDelegate: JournalMediaDeleterDelegate?
    var currentIndex: Int!
    
    //MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        initDesign()
    }
    
    func initDesign(){
        photoDeleteButton.layer.cornerRadius = 17
        photoPreviewImageView.layer.cornerRadius = 10
    }
    
    //MARK: Actions
    @IBAction func deleteSelectedPhoto(_ sender: Any) {
        deleterDelegate?.deleteImage(currentIndex: currentIndex)
    }
}
