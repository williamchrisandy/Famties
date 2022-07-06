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
        
        let editBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editJournal))
        self.navigationItem.rightBarButtonItem  = editBarButtonItem
        
        let worksheets = journal?.worksheets?.allObjects as! [Worksheet]
        for worksheet in worksheets.sorted(by: { $0.index < $1.index }) {
            do{
                canvasDrawing.append(try PKDrawing(data: worksheet.data!))
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
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
        self.title = journal.activity?.name
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        for worksheet in journal?.worksheets?.allObjects as! [Worksheet] {
            let sx = journalViewCollectionView.visibleSize.width / worksheet.width
            let sy = journalViewCollectionView.visibleSize.height / worksheet.height
            canvasDrawing[Int(worksheet.index)].transform(using: CGAffineTransform(scaleX: sx, y: sy))
        }
        journalViewCollectionView.reloadData()
    }
    //MARK: - Helpers
    
    @objc func editJournal(){
         performSegue(withIdentifier: "viewToEdit", sender: self)
    }
    
    private func convertMoodNumberToText(index: Int) -> String {
        //TODO: Fill Mood Name
        var mood: String!
        if index == 0 {
            mood = "We had a mixed feelings."
        } else if index == 1 {
            mood = "It was quite fun."
        } else if index == 2 {
            mood = "It was super amusing."
        } else if index == 3 {
            mood = "The activity gave us excitement."
        } else if index == 4 {
            mood = "We both feel loved."
        } else if index == 5 {
            mood = "We laughed a lot while doing this activity."
        } else if index == 6 {
            mood = "So inspired."
        } else if index == 7 {
            mood = "We needed to work some things out."
        } else {
            mood = "It was the time of celebration. Woohoooo."
        }
        return mood
    }
    
    private func convertMoodNumberToImage(index: Int) -> UIImage {
        //TODO: Fill Mood Name
        var emoji: String!
        if index == 0 {
            emoji = "Emoji1"
        } else if index == 1 {
            emoji = "Emoji2"
        } else if index == 2 {
            emoji = "Emoji3"
        } else if index == 3 {
            emoji = "Emoji4"
        } else if index == 4 {
            emoji = "Emoji5"
        } else if index == 5 {
            emoji = "Emoji6"
        } else if index == 6 {
            emoji = "Emoji7"
        } else if index == 7 {
            emoji = "Emoji8"
        } else {
            emoji = "Emoji9"
        }
        return UIImage(named: emoji)!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewToEdit" {
            let destination = segue.destination as! JournalViewController
            destination.journal = journal
            destination.mode = "Edit"
        }
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
            cell.imageView.image = journal.activity?.worksheetImage[indexPath.item].resized(to: collectionView.visibleSize)
            
            return cell
        }
    }
}

