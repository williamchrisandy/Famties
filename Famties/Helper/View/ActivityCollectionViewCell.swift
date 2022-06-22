//
//  MainCollectionViewCell.swift
//  Famties
//
//  Created by Hilmy Veradin on 13/06/22.
//

import UIKit

class ActivityCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isFavorite: UIButton!
    @IBOutlet weak var estimatedTimeLabel: UILabel!
    @IBOutlet weak var activityPreview: UIImageView!
    @IBOutlet weak var timeDurationView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        categoryView.layer.masksToBounds = true
        categoryView.layer.cornerRadius = 10
    }
}
