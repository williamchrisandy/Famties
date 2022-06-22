//
//  MainCollectionViewCell.swift
//  Famties
//
//  Created by Hilmy Veradin on 13/06/22.
//

import UIKit

protocol ActivityCollectionViewCellDelegate: AnyObject {
    func favoriteClicked()
}

class ActivityCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isFavorite: UIButton!
    @IBOutlet weak var estimatedTimeLabel: UILabel!
    @IBOutlet weak var activityPreview: UIImageView!
    @IBOutlet weak var timeDurationView: UIView!
    
    weak var delegate: ActivityCollectionViewCellDelegate?
    var activity: Activity?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        categoryView.layer.masksToBounds = true
        categoryView.layer.cornerRadius = 10
    }
    
    @IBAction func favoriteClicked(_ sender: UIButton) {
        let databaseHelper = DatabaseHelper()
        databaseHelper.toogleFavoritesActivity(activity!)
        isFavorite.imageView?.image = UIImage(systemName: (activity?.isFavorited == false ? "heart" : "heart.fill"))
        delegate?.favoriteClicked()
    }
    
    func setUpData() {
        categoryName.text = activity?.partOf?.name
        titleLabel.text = activity?.name
        isFavorite.imageView?.image = UIImage(systemName: (activity?.isFavorited == false ? "heart" : "heart.fill"))
        estimatedTimeLabel.text = "\(activity?.estimatedTime ?? 0) minutes"
        activityPreview.image = activity?.coverImage
    }
    
}
