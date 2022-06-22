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
    @IBOutlet weak var timeDurationView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var benefitView1: UIView!
    @IBOutlet weak var benefitView2: UIView!
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
    
    var string: String?
    var imgArray: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraint()
//        let button = UIBarButtonItem(title: "< Activity", style: .done, target: self, action: #selector(goBack))
//        self.navigationItem.leftBarButtonItem = button
        imgArray = ["heart", "heart.fill", "heart", "heart.fill", "heart", "heart.fill", "heart.fill"]
        stepsPageController.currentPage = 0
        stepsPageController.numberOfPages = imgArray!.count
    }
    
    @objc private func goBack() {
        dismiss(animated: true)
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
                            right: rightAnchor, paddingRight: frameWidth * 0.8184)
        
        timeDurationView.anchor(top: topAnchor, paddingTop: frameHeight * 0.5198,
                                bottom: bottomAnchor, paddingBottom: frameHeight * 0.4671,
                                left: leftAnchor, paddingLeft: frameWidth * 0.0391 ,
                                right: rightAnchor, paddingRight: frameWidth * 0.8653)
        
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

extension ActivityDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCollectionViewCell, for: indexPath) as! DetailCollectionViewCell
        cell.detailImageView.image = UIImage(systemName: imgArray![indexPath.row])
//        cell.detailImageView.contentMode = .scaleToFill
//        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.backgroundColor = .purple
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        stepsPageController.currentPage = indexPath.row
    }
}

