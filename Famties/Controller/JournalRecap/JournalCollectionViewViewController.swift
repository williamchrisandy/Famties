//
//  JournalCollectionViewViewController.swift
//  Famties
//
//  Created by Hilmy Veradin on 04/07/22.
//

import UIKit

class JournalCollectionViewViewController: UIViewController {
    //MARK: - Properties
    let canvasViewIdentifier = "CanvasViewIdentifier"
    let moodViewIdentifier = "MoodViewIdentifier"
    let photosViewIdentifier = "PhotosViewIdentifier"
    
    @IBOutlet weak var JournalViewCollectionView: UICollectionView! {
        didSet {
            JournalViewCollectionView.delegate = self
            JournalViewCollectionView.dataSource = self
            JournalViewCollectionView.register(UINib(nibName: "CanvasViewViewCell", bundle: nil), forCellWithReuseIdentifier: canvasViewIdentifier)
            JournalViewCollectionView.register(UINib(nibName: "MoodViewViewCell", bundle: nil), forCellWithReuseIdentifier: moodViewIdentifier)
            JournalViewCollectionView.register(UINib(nibName: "PhotosViewViewCell", bundle: nil), forCellWithReuseIdentifier: photosViewIdentifier)
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var kidNameLabel: UILabel!
    @IBOutlet weak var pageController: UIPageControl!
    
    var journal: Journal!
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        pageController.numberOfPages = 3
        pageController.currentPage = 0
    }
    //MARK: - Helpers
    @IBAction func editButtonTapped(_ sender: Any) {
        
    }
}

//MARK: - CollectionView Data Source and Delegate
extension JournalCollectionViewViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK: Data Source
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let visibleRectangleDaily = CGRect(origin: JournalViewCollectionView.contentOffset, size: JournalViewCollectionView.bounds.size)
        if let visibleIndexPath = self.JournalViewCollectionView.indexPathForItem(at: CGPoint(x: visibleRectangleDaily.midX, y: visibleRectangleDaily.midY)) {
            pageController.currentPage = visibleIndexPath.item
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: canvasViewIdentifier, for: indexPath) as! CanvasViewViewCell
            
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: moodViewIdentifier, for: indexPath) as! MoodViewViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photosViewIdentifier, for: indexPath) as! PhotosViewViewCell
            cell.journal = journal
            return cell
        }
        return UICollectionViewCell()
    }
}

