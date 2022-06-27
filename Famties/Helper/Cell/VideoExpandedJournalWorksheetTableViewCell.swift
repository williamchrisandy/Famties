//
//  VideoExpandedJournalWorksheetTableViewCell.swift
//  Famties
//
//  Created by Hocky on 26/06/22.
//

import UIKit

class VideoExpandedJournalWorksheetTableViewCell: UITableViewCell {
    
    
    //MARK: Properties
    @IBOutlet weak var videoExpandedHeaderLabel: UILabel!
    @IBOutlet weak var videoExpandedDescriptionLabel: UILabel!
    @IBOutlet weak var videoExpandedImageView: UIImageView!
    
    
    //MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        initDesign()
    }

    func initDesign(){
        videoExpandedImageView.layer.cornerRadius = 10
    }

}
