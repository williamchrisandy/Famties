//
//  HomeDetailViewController.swift
//  Famties
//
//  Created by Hilmy Veradin on 12/06/22.
//

import UIKit

class JournalRecapViewController: UIViewController {

    var journalRecapCollectionViewCell = "JournalRecapCollectionViewCell"
    
    @IBOutlet weak var journalTitle: UILabel!
    @IBOutlet weak var journalKidName: UILabel!
    @IBOutlet weak var journalCollectionView: UICollectionView! {
        didSet {
            journalCollectionView.delegate = self
            journalCollectionView.dataSource = self
            journalCollectionView.register(UINib(nibName: "JournalRecapCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: journalRecapCollectionViewCell)
        }
    }
    @IBOutlet weak var lastEditedJournalText: UILabel!
    @IBOutlet weak var createdAtJournalText: UILabel!
    @IBOutlet weak var slideRightButton: UIButton!
    @IBOutlet weak var slideLeftButton: UIButton!
    
    var currentIndex = 0
    var imageArray: [UIImage] = []
    var nameArray: [String] = []
    var titleArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        journalCollectionView.layer.cornerRadius = 15
        
        imageArray.append((UIImage(named: "Activity1_Journal")!))
        imageArray.append((UIImage(named: "Activity16_Journal")!))
        imageArray.append((UIImage(named: "Activity17_Journal")!))
        imageArray.append((UIImage(named: "Activity22_Journal")!))
        
        titleArray.append("Making Dream Comes\n True with Nano")
        titleArray.append("Lovely Gift Creating\n with Zoya")
        titleArray.append("Lovely Gift Creating\n Creating Creating")
        titleArray.append("Expressing Agreement or\n Disagreement Together")
        
        nameArray.append("Nano")
        nameArray.append("Zoya")
        nameArray.append("Budi")
        nameArray.append("Joji")
        
        journalTitle.text = titleArray[0]
        journalKidName.text = nameArray[0]
    }
    
    @IBAction func slideRightButtonTapped(_ sender: Any) {
        currentIndex += 1
        if currentIndex > imageArray.count-1 {
            currentIndex = 0
        }
        journalTitle.text = titleArray[currentIndex]
        journalKidName.text = nameArray[currentIndex]
        journalCollectionView.scrollToItem(at: IndexPath.init(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func slideLeftButtonTapped(_ sender: Any) {
        currentIndex -= 1
        if currentIndex < 0 {
            currentIndex = imageArray.count-1
        }
        journalTitle.text = titleArray[currentIndex]
        journalKidName.text = nameArray[currentIndex]
        journalCollectionView.scrollToItem(at: IndexPath.init(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
}

extension JournalRecapViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: journalRecapCollectionViewCell, for: indexPath) as! JournalRecapCollectionViewCell
        let cellImage = imageArray[indexPath.item].resized(to: cell.frame.size)
//
        cell.JournalCollectionImage.image = cellImage
//        cell.JournalCollectionImage.image = imageArray[indexPath.item]
//        cell.JournalCollectionImage.contentMode = .scaleAspectFill
        
//        cell.JournalCollectionImage.image = imageArray[indexPath.item]
//       cell.detailImageView.frame = CGRect(x: 0, y: 0, width: Int(collectionView.frame.width), height: Int(collectionView.frame.height))
        return cell
    }
}
