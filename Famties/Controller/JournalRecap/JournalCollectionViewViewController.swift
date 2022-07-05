//
//  JournalCollectionViewViewController.swift
//  Famties
//
//  Created by Hilmy Veradin on 04/07/22.
//

import UIKit
import PencilKit

class JournalCollectionViewViewController: UIViewController {
    //MARK: - Properties
    let canvasViewIdentifier = "CanvasViewIdentifier"
    let moodViewIdentifier = "MoodViewIdentifier"
    let photosViewIdentifier = "PhotosViewIdentifier"
    
    @IBOutlet weak var journalViewCollectionView: UICollectionView! {
        didSet {
            journalViewCollectionView.delegate = self
            journalViewCollectionView.dataSource = self
            journalViewCollectionView.register(UINib(nibName: "CanvasViewViewCell", bundle: nil), forCellWithReuseIdentifier: canvasViewIdentifier)
            journalViewCollectionView.register(UINib(nibName: "MoodViewViewCell", bundle: nil), forCellWithReuseIdentifier: moodViewIdentifier)
            journalViewCollectionView.register(UINib(nibName: "PhotosViewViewCell", bundle: nil), forCellWithReuseIdentifier: photosViewIdentifier)
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var kidNameLabel: UILabel!
    @IBOutlet weak var pageController: UIPageControl!
    
    let databaseHelper = DatabaseHelper()
    
    var journal: Journal!
    var canvasDrawing: [PKDrawing] = []
    var pageCount: Int = 0
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        for worksheet in journal?.worksheets?.allObjects as! [Worksheet] {
            do {
                try canvasDrawing.append(PKDrawing(data: worksheet.data!))
            } catch {
                print(error)
            }
        }
       
        pageCount += canvasDrawing.count + 1
        if journal.photo.isEmpty == false {
            pageCount += 1
        }
        pageController.numberOfPages = pageCount
        pageController.currentPage = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        self.title = journal.activity?.name!
        
    }
    //MARK: - Helpers
    @IBAction func editButtonTapped(_ sender: Any) {
        
    }
    
    private func convertMoodNumberToText(index: Int) -> String {
        //TODO: Fill Mood Name
        var mood: String!
        if index == 0 {
            
        } else if index == 1 {
            
        }
        return "mood"
    }
    
    private func convertMoodNumberToImage(index: Int) -> UIImage {
        //TODO: Fill Mood Name
        var emoji: String!
        if index == 0 {
            
        } else if index == 1 {
            
        }
        return UIImage(named: "Emoji1")!
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let visibleRectangleDaily = CGRect(origin: journalViewCollectionView.contentOffset, size: journalViewCollectionView.bounds.size)
        if let visibleIndexPath = self.journalViewCollectionView.indexPathForItem(at: CGPoint(x: visibleRectangleDaily.midX, y: visibleRectangleDaily.midY)) {
            pageController.currentPage = visibleIndexPath.item
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.item == pageCount - 1 && journal.photo.isEmpty == true) || (indexPath.item == pageCount - 2 && journal.photo.isEmpty == false) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: moodViewIdentifier, for: indexPath) as! MoodViewViewCell
            cell.moodLabel.text = convertMoodNumberToText(index: Int(journal.mood))
            cell.moodImage.image = convertMoodNumberToImage(index: Int(journal.mood))
            cell.learnTitleLabel.text = journal.name
            cell.descriptionLabel.text = journal.lessonLearned
            return cell
        } else if indexPath.item == pageCount - 1 && journal.photo.isEmpty == false {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photosViewIdentifier, for: indexPath) as! PhotosViewViewCell
            cell.photos = journal.photo
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: canvasViewIdentifier, for: indexPath) as! CanvasViewViewCell
            cell.canvasView.drawing = canvasDrawing[indexPath.item]
            
            let width = collectionView.visibleSize.width
            let height = collectionView.visibleSize.height
            var size: CGSize = CGSize(width: width, height: width * 1.25)
            if width * 1.25 > height { size  = CGSize(width: height * 0.8, height: height) }
            
            cell.imageView.image = journal.activity?.worksheetImage[indexPath.item].resized(to: size)
            cell.canvasView.frame.size = size
            return cell
        }
    }
}

