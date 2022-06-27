//
//  ActivityDetailViewController.swift
//  Famties
//
//  Created by Hilmy Veradin on 16/06/22.
//

import Foundation
import UIKit

class ActivityDetailViewController: UIViewController {
    
    //MARK: - Properties
    // Identifier
    var detailCollectionViewCell = "detailCollectionCell"
    
    //IBOutlet
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            adjustTextSize(label: titleLabel)
        }
    }
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryTextLabel: UILabel! {
        didSet {
            adjustTextSize(label: categoryTextLabel)
        }
    }
    @IBOutlet weak var timeDurationView: UIView!
    @IBOutlet weak var timeDurationLabel: UILabel! {
        didSet {
            adjustTextSize(label: timeDurationLabel)
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            adjustTextSize(label: descriptionLabel)
        }
    }
    @IBOutlet weak var benefitView1: UIView!
    @IBOutlet weak var benefitTitleLabel1: UILabel! {
        didSet {
            adjustTextSize(label: benefitTitleLabel1)
        }
    }
    @IBOutlet weak var benefitDescriptionLabel1: UILabel! {
        didSet {
            adjustTextSize(label: benefitDescriptionLabel1)
        }
    }
    @IBOutlet weak var benefitView2: UIView!
    @IBOutlet weak var benefitTitleLabel2: UILabel! {
        didSet {
            adjustTextSize(label: benefitTitleLabel2)
        }
    }
    @IBOutlet weak var benefitDescriptionLabel2: UILabel!{
        didSet {
            adjustTextSize(label: benefitDescriptionLabel2)
        }
    }
    @IBOutlet weak var benefitTitleLabel3: UILabel!{
        didSet {
            adjustTextSize(label: benefitTitleLabel3)
        }
    }
    @IBOutlet weak var benefitDescriptionLabel3: UILabel!{
        didSet {
            adjustTextSize(label: benefitDescriptionLabel3)
        }
    }
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
    
    // PropertyType
    weak var delegate: ActivityCollectionViewCellDelegate?
    var detailActivity: Activity?
    var detailBenefits: [Benefit]?
    var categoryColor: UIColor!
    var categoryBorderColor: UIColor!
    var string: String?
    var imgArray: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = "Activity"
        
        let rightButton = UIBarButtonItem(image: UIImage(systemName: (detailActivity?.isFavorited == false ? "heart" : "heart.fill")), style: .done, target: self, action: #selector(addActivityToFavorite))
        rightButton.tintColor = UIColor(named: "CardsFavoriteColor")
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startJournalingButton.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
        startJournalingButton.layer.cornerRadius = 10
        
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
        categoryView.layer.cornerRadius = categoryView.frame.height * 1/2
        
        stepsCollectionView.layer.cornerRadius = 10
        previewImage.layer.cornerRadius = 10
    }
    
    private func adjustTextSize(label: UILabel) {
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        self.hidesBottomBarWhenPushed = false
    }
    
    @IBAction func createNewJournal(_ sender: UIButton) {
        performSegue(withIdentifier: "goToJournalSegue", sender: self)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToJournalSegue" {
            let databaseHelper = DatabaseHelper()
            let journal = databaseHelper.createBlankJournal(from: detailActivity!)
            
            let destination = segue.destination as! JournalViewController
            destination.journal = journal
            destination.mode = "New"
            
        }
    }
}

//MARK: - UICollectionView Data and Delegate
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
