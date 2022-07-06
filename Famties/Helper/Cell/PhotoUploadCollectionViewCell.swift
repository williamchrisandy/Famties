//
//  PhotoUploadCollectionViewCell.swift
//  Famties
//
//  Created by Hocky on 26/06/22.
//

import UIKit

class PhotoUploadCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: Properties
    @IBOutlet weak var photoUploadButton: UIButton!
    
    weak var delegates: JournalMediaPickerDelegate?
    
    
    //MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        initDesign()
    }

    func initDesign(){
        photoUploadButton.layer.cornerRadius = 10
    }
    
    
    //MARK: Actions
    @IBAction func uploadPhoto(_ sender: Any) {
        delegates?.pickImage()
    }
    
}
