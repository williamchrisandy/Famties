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
    @IBOutlet weak var moodImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        topView.layer.borderWidth = 1
        topView.layer.borderColor = UIColor(named: "BenefitTitleColor")?.cgColor
        topView.layer.cornerRadius = 5
        
        bottomView.layer.borderWidth = 1
        bottomView.layer.borderColor = UIColor(named: "BenefitTitleColor")?.cgColor
        bottomView.layer.cornerRadius = 5
    }

}
