//
//  MainCollectionViewCell.swift
//  Famties
//
//  Created by Hilmy Veradin on 13/06/22.
//

import UIKit

protocol ActivityCollectionViewCellDelegate: AnyObject {
    func favoriteClicked(activity: Activity)
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
        
        titleLabel.minimumScaleFactor = 0.1    //or whatever suits your need
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.lineBreakMode = .byClipping
        titleLabel.numberOfLines = 0
    }
    
    @IBAction func favoriteClicked(_ sender: UIButton) {
        let databaseHelper = DatabaseHelper()
        databaseHelper.toogleFavoritesActivity(activity!)
        setFavoriteButtonImage()
        delegate?.favoriteClicked(activity: activity!)
    }
    
    func setFavoriteButtonImage() {
        isFavorite.setImage(UIImage(systemName: (activity?.isFavorited == false ? "heart" : "heart.fill")), for: .normal)
    }
    
    func setUpData(categoryColor: UIColor, categoryBorderColor: UIColor) {
        categoryName.text = activity?.partOf?.name
        titleLabel.text = activity?.name
        estimatedTimeLabel.text = "\(activity?.estimatedTime ?? 0) minutes"
        activityPreview.image = activity?.coverImage
        
        categoryView.backgroundColor = categoryColor
        categoryView.layer.borderColor = categoryBorderColor.cgColor
        categoryView.layer.borderWidth = 1
        setFavoriteButtonImage()
    }
    
}
