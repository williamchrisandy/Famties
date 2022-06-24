//
//  ActivityDetailViewController.swift
//  Famties
//
//  Created by Hilmy Veradin on 16/06/22.
//

import Foundation
import UIKit

class ActivityDetailViewController: UIViewController {
    
    //MARK: Properties
    var detailCollectionViewCell = "detailCollectionCell"
    
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryTextLabel: UILabel!
    @IBOutlet weak var timeDurationView: UIView!
    @IBOutlet weak var timeDurationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var benefitView1: UIView!
    @IBOutlet weak var benefitTitleLabel1: UILabel!
    @IBOutlet weak var benefitDescriptionLabel1: UILabel!
    @IBOutlet weak var benefitView2: UIView!
    @IBOutlet weak var benefitTitleLabel2: UILabel!
    @IBOutlet weak var benefitDescriptionLabel2: UILabel!
    @IBOutlet weak var benefitTitleLabel3: UILabel!
    @IBOutlet weak var benefitDescriptionLabel3: UILabel!
    @IBOutlet weak var benefitView3: UIView!
    @IBOutlet weak var howToDoActivitiesLabel: UILabel!
    @IBOutlet weak var stepsCollectionView: UICollectionView! {
        didSet {
            stepsCollectionView.dataSource = self
            stepsCollectionView.delegate = self
            stepsCollectionView.register(UINib(nibName: "DetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: detailCollectionViewCell)
        }
    }
    @IBOutlet weak var stepsPageController: UIPageControl!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var startJournalingButton: UIButton!
    
    weak var delegate: ActivityCollectionViewCellDelegate?
    var detailActivity: Activity?
    var detailBenefits: [Benefit]?
    var categoryColor: UIColor!
    var categoryBorderColor: UIColor!
    
    var string: String?
    var imgArray: [UIImage] = []
    
    override func viewDidLoad() {
        tabBarController?.tabBar.isHidden = true
        super.viewDidLoad()
        setupConstraint()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = "Activity"
        
        let rightButton = UIBarButtonItem(image: UIImage(systemName: (detailActivity?.isFavorited == false ? "heart" : "heart.fill")), style: .done, target: self, action: #selector(addActivityToFavorite))
        rightButton.tintColor = UIColor(named: "CardsFavoriteColor")
        self.navigationItem.rightBarButtonItem = rightButton
        
        imgArray = detailActivity!.howToImage
        stepsPageController.currentPage = 0
        stepsPageController.numberOfPages = imgArray.count
        
        setupDetailData()
    }
    
    private func setupDetailData() {
        prepareCardsColor(activity: detailActivity!)
        detailBenefits = detailActivity?.has?.allObjects as! [Benefit]
        
        titleLabel.text = detailActivity?.name
        descriptionLabel.text = detailActivity?.explanation
        previewImage.image = detailActivity?.coverImage
        timeDurationLabel.text = "\(detailActivity?.estimatedTime ?? 0) minutes"
        categoryTextLabel.text = detailActivity?.partOf?.name
        
        benefitTitleLabel1.text = detailBenefits?[0].name
        benefitDescriptionLabel1.text = detailBenefits?[0].explanation
        benefitTitleLabel2.text = detailBenefits?[1].name
        benefitDescriptionLabel2.text = detailBenefits?[1].explanation
        benefitTitleLabel3.text = detailBenefits?[2].name
        benefitDescriptionLabel3.text = detailBenefits?[2].explanation
        
        categoryView.backgroundColor = categoryColor
        categoryView.layer.borderColor = categoryBorderColor.cgColor
        categoryView.layer.borderWidth = 1
        categoryView.layer.cornerRadius = 15
        
        stepsCollectionView.layer.cornerRadius = 10
        
        startJournalingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        startJournalingButton.layer.cornerRadius = 10
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        self.hidesBottomBarWhenPushed = false
    }
    
    @objc private func addActivityToFavorite() {
        let databaseHelper = DatabaseHelper()
        databaseHelper.toogleFavoritesActivity(detailActivity!)
        if navigationItem.rightBarButtonItem?.image == UIImage(systemName: "heart") {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
        }
        delegate?.favoriteClicked(activity: detailActivity!)
    }
    
    private func prepareCardsColor(activity: Activity) {
        let activityCategoryName = activity.partOf?.name
        if activityCategoryName == "Self Awareness" {
            categoryColor = UIColor(named: "AwarenessColor")
            categoryBorderColor = UIColor(named: "AwarenessBorderColor")
        } else if activityCategoryName == "Self Management" {
            categoryColor = UIColor(named: "ManagementColor")
            categoryBorderColor = UIColor(named: "ManagementBorderColor")
        } else if activityCategoryName == "Social Awareness" {
            categoryColor = UIColor(named: "SocialColor")
            categoryBorderColor = UIColor(named: "SocialBorderColor")
        } else if activityCategoryName == "Relationship Skills" {
            categoryColor = UIColor(named: "RelationshipColor")
            categoryBorderColor = UIColor(named: "RelationshipBorderColor")
        } else {
            categoryColor = UIColor(named: "DecisionColor")
            categoryBorderColor = UIColor(named: "DecisionBorderColor")
        }
    }
    
    //MARK: Helpers
    private func setupConstraint() {
        let frameHeight = view.frame.height
        let frameWidth = view.frame.width
        let topAnchor = view.topAnchor
        let bottomAnchor = view.bottomAnchor
        let leftAnchor = view.leftAnchor
        let rightAnchor = view.rightAnchor
        
        previewImage.anchor(top: topAnchor, paddingTop: frameHeight * 0.0981,
                            bottom: bottomAnchor, paddingBottom: frameHeight * 0.6311,
                            left: leftAnchor, paddingLeft: frameWidth * 0.0313 ,
                            right: rightAnchor, paddingRight: frameWidth * 0.67)
        previewImage.layer.cornerRadius = 20
        
        howToDoActivitiesLabel.anchor(top: topAnchor, paddingTop: frameHeight * 0.0981,
                                      bottom: bottomAnchor, paddingBottom: frameHeight * 0.8844,
                                      left: leftAnchor, paddingLeft: frameWidth * 0.3995 ,
                                      right: rightAnchor, paddingRight: frameWidth * 0.2686)
        
        stepsCollectionView.anchor(top: topAnchor, paddingTop: frameHeight * 0.134,
                                   bottom: bottomAnchor, paddingBottom: frameHeight * 0.399,
                                   left: leftAnchor, paddingLeft: frameWidth * 0.4083 ,
                                   right: rightAnchor, paddingRight: frameWidth * 0.0391)
        
        stepsPageController.anchor(top: topAnchor, paddingTop: frameHeight * 0.6069,
                                   bottom: bottomAnchor, paddingBottom: frameHeight * 0.361,
                                   left: leftAnchor, paddingLeft: frameWidth * 0.4952 ,
                                   right: rightAnchor, paddingRight: frameWidth * 0.1241)
        
        titleLabel.anchor(top: topAnchor, paddingTop: frameHeight * 0.391,
                          bottom: bottomAnchor, paddingBottom: frameHeight * 0.5242,
                          left: leftAnchor, paddingLeft: frameWidth * 0.0391 ,
                          right: rightAnchor, paddingRight: frameWidth * 0.6827)
        
        categoryView.anchor(top: topAnchor, paddingTop: frameHeight * 0.492,
                            bottom: bottomAnchor, paddingBottom: frameHeight * 0.492,
                            left: leftAnchor, paddingLeft: frameWidth * 0.0401 ,
                            right: rightAnchor, paddingRight: frameWidth * 0.8)
        
        timeDurationView.anchor(top: topAnchor, paddingTop: frameHeight * 0.5198,
                                bottom: bottomAnchor, paddingBottom: frameHeight * 0.4671,
                                left: leftAnchor, paddingLeft: frameWidth * 0.0391 ,
                                right: rightAnchor, paddingRight: frameWidth * 0.85)
        
        descriptionLabel.anchor(top: topAnchor, paddingTop: frameHeight * 0.555,
                                bottom: bottomAnchor, paddingBottom: frameHeight * 0.3485,
                                left: leftAnchor, paddingLeft: frameWidth * 0.0401 ,
                                right: rightAnchor, paddingRight: frameWidth * 0.6739)
        
        benefitView1.anchor(top: topAnchor, paddingTop: frameHeight * 0.6765,
                            bottom: bottomAnchor, paddingBottom: frameHeight * 0.2753,
                            left: leftAnchor, paddingLeft: frameWidth * 0.0479 ,
                            right: rightAnchor, paddingRight: frameWidth * 0.6641)
        
        benefitView2.anchor(top: topAnchor, paddingTop: frameHeight * 0.7482,
                            bottom: bottomAnchor, paddingBottom: frameHeight * 0.2036,
                            left: leftAnchor, paddingLeft: frameWidth * 0.0479 ,
                            right: rightAnchor, paddingRight: frameWidth * 0.6641)
        
        benefitView3.anchor(top: topAnchor, paddingTop: frameHeight * 0.817,
                            bottom: bottomAnchor, paddingBottom: frameHeight * 0.1186,
                            left: leftAnchor, paddingLeft: frameWidth * 0.0479 ,
                            right: rightAnchor, paddingRight: frameWidth * 0.6641)
        
        startJournalingButton.anchor(top: topAnchor, paddingTop: frameHeight * 0.9217,
                                     bottom: bottomAnchor, paddingBottom: frameHeight * 0.0345,
                                     left: leftAnchor, paddingLeft: frameWidth * 0.0499 ,
                                     right: rightAnchor, paddingRight: frameWidth * 0.0499)
        
        lineView.anchor(top: topAnchor, paddingTop: frameHeight * 0.0985,
                        bottom: bottomAnchor, paddingBottom: frameHeight * 0.1117,
                        left: leftAnchor, paddingLeft: frameWidth * 0.3687 ,
                        width: 1)
    }
}

extension ActivityDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCollectionViewCell, for: indexPath) as! DetailCollectionViewCell
        cell.detailImageView.image = imgArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let visibleRectangleDaily = CGRect(origin: stepsCollectionView.contentOffset, size: stepsCollectionView.bounds.size)
        if let visibleIndexPath = self.stepsCollectionView.indexPathForItem(at: CGPoint(x: visibleRectangleDaily.midX, y: visibleRectangleDaily.midY)) {
            stepsPageController.currentPage = visibleIndexPath.item
        }
    }
    
}
