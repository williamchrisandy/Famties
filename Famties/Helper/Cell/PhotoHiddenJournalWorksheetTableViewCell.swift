//
//  PhotoHiddenJournalWorksheetTableViewCell.swift
//  Famties
//
//  Created by Hocky on 26/06/22.
//

import UIKit

class PhotoHiddenJournalWorksheetTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var photoHiddenHeaderLabel: UILabel!
    @IBOutlet weak var photoHiddenDescriptionLabel: UILabel!
    @IBOutlet weak var photoHiddenUploadButton: UIButton!
    
    var delegates: JournalMediaPickerDelegate?
    
    
    //MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        initDesign()
    }

    func initDesign(){
        photoHiddenUploadButton.layer.cornerRadius = 10
    }
    
    
    //MARK: Actions
    @IBAction func uploadPhoto(_ sender: Any) {
        delegates?.pickImage()
    }
    
}

//extension PhotoHiddenJournalWorksheetTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        let img = info[.originalImage] as! UIImage
//
//        self.dismiss(animated: true, completion: nil)
//        print("hi")
//    }
//}

//extension PhotoHiddenJournalWorksheetTableViewCell: JournalImagePickerDelegate{
//
//    func pickImage() -> UIImagePickerController {
//        let imagePicker = UIImagePickerController()
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.delegate = self
//        return imagePicker
//    }
//}
