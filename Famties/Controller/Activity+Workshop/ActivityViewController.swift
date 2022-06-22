//
//  HomeViewController.swift
//  Famties
//
//  Created by Hilmy Veradin on 12/06/22.
//

import UIKit

class ActivityViewController: UIViewController {
    
    //MARK: - Properties
    
    let collectionViewCell = "ActivityCollectionViewCell"
    
    let favoriteCellIdentifier = "favoriteCellIdentifier"
    let recommendedCellIdentifier = "recommendedCellIdentifier"
    let awarenessCellIdentifier = "awarenessCellIdentifier"
    let socialCellIdentifier = "socialCellIdentifier"
    let managementCellIdentifier = "managementCellIdentifier"
    let relationsihpCellIdentifier = "relationsihpCellIdentifier"
    let responsibleCellIdentifier = "responsibleCellIdentifier"
    
    let objects = ["1", "2", "3", "0"]
    let objects2 = ["1", "2"]
    var count1 = 2
    var count2 = 3
    var index1: [Int] = [0]
    var index2: [Int] = [1]

    @IBOutlet weak var favoriteCollectionView: UICollectionView! {
        didSet {
            favoriteCollectionView.delegate = self
            favoriteCollectionView.dataSource = self
            favoriteCollectionView.register(UINib(nibName: collectionViewCell, bundle: nil), forCellWithReuseIdentifier: favoriteCellIdentifier)
        }
    }
    @IBOutlet weak var recommendedCollectionView: UICollectionView! {
        didSet {
            recommendedCollectionView.delegate = self
            recommendedCollectionView.dataSource = self
            recommendedCollectionView.register(UINib(nibName: collectionViewCell, bundle: nil), forCellWithReuseIdentifier: recommendedCellIdentifier)
        }
    }
    @IBOutlet weak var awarenessCollectionView: UICollectionView! {
        didSet {
            awarenessCollectionView.delegate = self
            awarenessCollectionView.dataSource = self
            awarenessCollectionView.register(UINib(nibName: collectionViewCell, bundle: nil), forCellWithReuseIdentifier: awarenessCellIdentifier)
        }
    }
    @IBOutlet weak var managementCollectionView: UICollectionView! {
        didSet {
            managementCollectionView.delegate = self
            managementCollectionView.dataSource = self
            managementCollectionView.register(UINib(nibName: collectionViewCell, bundle: nil), forCellWithReuseIdentifier: managementCellIdentifier)
        }
    }
    @IBOutlet weak var socialCollectionView: UICollectionView! {
        didSet {
            socialCollectionView.delegate = self
            socialCollectionView.dataSource = self
            socialCollectionView.register(UINib(nibName: collectionViewCell, bundle: nil), forCellWithReuseIdentifier: socialCellIdentifier)
        }
    }
    @IBOutlet weak var relationshipCollectionView: UICollectionView!{
        didSet {
            relationshipCollectionView.delegate = self
            relationshipCollectionView.dataSource = self
            relationshipCollectionView.register(UINib(nibName: collectionViewCell, bundle: nil), forCellWithReuseIdentifier: relationsihpCellIdentifier)
        }
    }
    @IBOutlet weak var responsibleCollectionView: UICollectionView! {
        didSet {
            responsibleCollectionView.delegate = self
            responsibleCollectionView.dataSource = self
            responsibleCollectionView.register(UINib(nibName: collectionViewCell, bundle: nil), forCellWithReuseIdentifier: responsibleCellIdentifier)
        }
    }
    
    //MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
}

extension ActivityViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionView1 = self.favoriteCollectionView
        let collectionView2 = self.recommendedCollectionView
        let collectionView3 = self.awarenessCollectionView
        let collectionView4 = self.managementCollectionView
        let collectionView5 = self.socialCollectionView
        let collectionView6 = self.relationshipCollectionView
        let collectionView7 = self.responsibleCollectionView
        
        var cell: ActivityCollectionViewCell!
        
        if collectionView == collectionView1 {
            cell = (collectionView.dequeueReusableCell(withReuseIdentifier: favoriteCellIdentifier, for: indexPath) as! ActivityCollectionViewCell)
        } else if collectionView == collectionView2 {
            cell = (collectionView.dequeueReusableCell(withReuseIdentifier: recommendedCellIdentifier, for: indexPath) as! ActivityCollectionViewCell)
        } else if collectionView == collectionView3 {
            cell = (collectionView.dequeueReusableCell(withReuseIdentifier: awarenessCellIdentifier, for: indexPath) as! ActivityCollectionViewCell)
        } else if collectionView == collectionView4 {
            cell = (collectionView.dequeueReusableCell(withReuseIdentifier: managementCellIdentifier, for: indexPath) as! ActivityCollectionViewCell)
        } else if collectionView == collectionView5 {
            cell = (collectionView.dequeueReusableCell(withReuseIdentifier: socialCellIdentifier, for: indexPath) as! ActivityCollectionViewCell)
        } else if collectionView == collectionView6 {
            cell = (collectionView.dequeueReusableCell(withReuseIdentifier: relationsihpCellIdentifier, for: indexPath) as! ActivityCollectionViewCell)
        } else if collectionView == collectionView7 {
            cell = (collectionView.dequeueReusableCell(withReuseIdentifier: responsibleCellIdentifier, for: indexPath) as! ActivityCollectionViewCell)
        } else {
            fatalError()
        }
        
        changeCellImage(cell: cell)
        cell.layer.cornerRadius = 15
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.favoriteCollectionView {
            return 10
        } else {
            return count2
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ActivityViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.favoriteCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! ActivityCollectionViewCell
            changeCellImage(cell: cell)
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! ActivityCollectionViewCell
            changeCellImage(cell: cell)
        }
        performSegue(withIdentifier: "activityToDetail", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "activityToDetail" {
//            let nav = segue.destination as! UINavigationController
//            let activityDetail = nav.topViewController as! ActivityDetailViewController
//            activityDetail.string = "AAA"
//        }
//       
//    }
}

extension ActivityViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}

extension ActivityViewController {
    
    private func changeCellImage(cell: ActivityCollectionViewCell) {
        
    }
    

}
