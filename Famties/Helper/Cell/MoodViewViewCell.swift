//
//  MoodViewViewCell.swift
//  Famties
//
//  Created by Hilmy Veradin on 04/07/22.
//

import UIKit

class MoodViewViewCell: UICollectionViewCell {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var learnTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
