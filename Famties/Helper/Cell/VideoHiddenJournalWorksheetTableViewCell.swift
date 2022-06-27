//
//  VideoHiddenJournalWorksheetTableViewCell.swift
//  Famties
//
//  Created by Hocky on 26/06/22.
//

import UIKit

class VideoHiddenJournalWorksheetTableViewCell: UITableViewCell {
    
    
    //MARK: Properties
    @IBOutlet weak var videoHiddenHeaderLabel: UILabel!
    @IBOutlet weak var videoHiddenDescriptionLabel: UILabel!
    @IBOutlet weak var videoHiddenUploadButton: UIButton!
    
    var delegates: JournalMediaPickerDelegate?

    
    //MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        initDesign()
    }

    func initDesign(){
        videoHiddenUploadButton.layer.cornerRadius = 10
    }
    
    //MARK: Actions
    @IBAction func uploadVideo(_ sender: Any) {
        delegates?.pickVideo()
    }

}
