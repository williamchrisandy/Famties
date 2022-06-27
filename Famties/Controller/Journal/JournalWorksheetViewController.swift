//
//  JournalDetailViewController.swift
//  Famties
//
//  Created by Hilmy Veradin on 20/06/22.
//

import UIKit

protocol JournalMediaPickerDelegate{
    func pickImage()
    func pickVideo()
}

protocol JournalMediaDeleterDelegate{
    func deleteImage(currentIndex: Int)
}


class JournalWorksheetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, JournalMediaPickerDelegate, JournalMediaDeleterDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var journalWorksheetTableView: UITableView!
    
    let DBHelper = DatabaseHelper()
    var journal: Journal?
    let moodList = ["Emoji1", "Emoji2", "Emoji3", "Emoji4", "Emoji5", "Emoji6", "Emoji7", "Emoji8", "Emoji9"]
    var rowHeight: [CGFloat] = [182, 550, 182, 182]
    var moodCount: Int!
    var photos: [UIImage] = []
    var video: NSURL!
    var selectCell = MoodCollectionViewCell()
    var cellIdentifier: String!
    var photoIsHidden: Bool! = true
    var videoIsHidden: Bool! = true
    
    
    //MARK: Initialization
    override func viewDidLoad() {
        initDesign()
        initVar()
    }
    
    func initDesign(){
        
    }
    
    func initVar(){
        journalWorksheetTableView.dataSource = self
        journalWorksheetTableView.delegate = self
        
        photoIsHidden = true
        videoIsHidden = true
        
        moodCount = moodList.count
    }
    
    
    //MARK: Functions
    func updateTableCell(){
        
        if photos.count > 0 {
            photoIsHidden = false
            videoIsHidden = false
        } else {
            photoIsHidden = true
            videoIsHidden = true
        }
        if video != nil {
            videoIsHidden = false
        }
        
        journalWorksheetTableView.reloadData()
        journalWorksheetTableView.frame = CGRect(x: journalWorksheetTableView.frame.origin.x, y: journalWorksheetTableView.frame.origin.y, width: journalWorksheetTableView.frame.size.width, height: journalWorksheetTableView.contentSize.height)
        journalWorksheetTableView.reloadData()
    }
    
    func pickImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        if photos.count < 6 {
            present(imagePicker, animated: true)
        } else {
            // popup
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[.originalImage] as! UIImage
        photos.append(img)
        self.dismiss(animated: true, completion: nil)
        updateTableCell()
    }
    
    func pickVideo() {
        //video
    }
    
    func deleteImage(currentIndex: Int){
        photos.remove(at: currentIndex)
        updateTableCell()
    }
    

    //MARK: Overrides
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // mood
            cellIdentifier = "moodJournalCell"
            let cell = journalWorksheetTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MoodJournalWorksheetTableViewCell
            return cell
            
        } else if indexPath.row == 1 {
            // learned
            cellIdentifier = "learnedJournalCell"
            let cell = journalWorksheetTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LearnedJournalWorksheetTableViewCell
            return cell
            
        } else if indexPath.row == 2 {
            // photo
            if photoIsHidden {
                rowHeight[2] = 182
                cellIdentifier = "photoHiddenJournalCell"
                let cell = journalWorksheetTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PhotoHiddenJournalWorksheetTableViewCell
                cell.delegates = self
                return cell
                
            } else {
                rowHeight[2] = 364
                cellIdentifier = "photoExpandedJournalCell"
                let cell = journalWorksheetTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PhotoExpandedJournalWorksheetTableViewCell
                cell.delegates = self
                cell.photoUploadCount = photos.count
                cell.photos = photos
                cell.deleterDelegate = self
                cell.photoExpandedCollectionView.reloadData()
                return cell
            }
        } else if indexPath.row == 3 {
            // video
            if videoIsHidden {
                rowHeight[3] = 182
                cellIdentifier = "videoHiddenJournalCell"
                let cell = journalWorksheetTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! VideoHiddenJournalWorksheetTableViewCell
                cell.delegates = self
                return cell
            } else {
                rowHeight[3] = 364
                cellIdentifier = "videoExpandedJournalCell"
                let cell = journalWorksheetTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! VideoExpandedJournalWorksheetTableViewCell
                cell.videoExpandedImageView.image = photos[0]
                return cell
            }
        } else {
            return journalWorksheetTableView.dequeueReusableCell(withIdentifier: "learnedJournalCell", for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight[indexPath.row]
    }
    
}

extension JournalWorksheetViewController: EmbeddedViewControllerDelegate {
    func showLeftView() {
        self.view.isHidden = true
    }
    
    func showRightView() {
        self.view.isHidden = false
    }
    
    func saveJournalData() {
        DBHelper.save(images: photos, journal: journal!)
        
    }
    
}
