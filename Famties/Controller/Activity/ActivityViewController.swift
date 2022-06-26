//
//  HomeViewController.swift
//  Famties
//
//  Created by Hilmy Veradin on 12/06/22.
//

import UIKit

class ActivityViewController: UIViewController {

    // MARK: - Properties
    // Property Identifier
    let collectionViewCell = "ActivityCollectionViewCell"
    let collectionViewCellIdentifier = "activityCollectionViewCell"
    
    // Property type
    var data: [[Activity]] = []
    var selectedActivity: Activity?
    var categoryColor: UIColor!
    var categoryBorderColor: UIColor!

    // IBOutlets
    @IBOutlet weak var activityButton: UIButton! {
        didSet {
            let bannerImage = UIImage(named: "Acivity1_Banner")?.resized(to: activityButton.frame.size)
            activityButton.setImage(bannerImage, for: .normal)
        }
    }
    @IBOutlet weak var favoriteCollectionView: UICollectionView! {
        didSet {
            favoriteCollectionView.delegate = self
            favoriteCollectionView.dataSource = self
            favoriteCollectionView.register(UINib(nibName: collectionViewCell, bundle: nil), forCellWithReuseIdentifier: collectionViewCellIdentifier)
        }
    }
    @IBOutlet weak var recommendedCollectionView: UICollectionView! {
        didSet {
            recommendedCollectionView.delegate = self
            recommendedCollectionView.dataSource = self
            recommendedCollectionView.register(UINib(nibName: collectionViewCell, bundle: nil), forCellWithReuseIdentifier: collectionViewCellIdentifier)
        }
    }
    @IBOutlet weak var awarenessCollectionView: UICollectionView! {
        didSet {
            awarenessCollectionView.delegate = self
            awarenessCollectionView.dataSource = self
            awarenessCollectionView.register(UINib(nibName: collectionViewCell, bundle: nil), forCellWithReuseIdentifier: collectionViewCellIdentifier)
        }
    }
    @IBOutlet weak var managementCollectionView: UICollectionView! {
        didSet {
            managementCollectionView.delegate = self
            managementCollectionView.dataSource = self
            managementCollectionView.register(UINib(nibName: collectionViewCell, bundle: nil), forCellWithReuseIdentifier: collectionViewCellIdentifier)
        }
    }
    @IBOutlet weak var socialCollectionView: UICollectionView! {
        didSet {
            socialCollectionView.delegate = self
            socialCollectionView.dataSource = self
            socialCollectionView.register(UINib(nibName: collectionViewCell, bundle: nil), forCellWithReuseIdentifier: collectionViewCellIdentifier)
        }
    }
    @IBOutlet weak var relationshipCollectionView: UICollectionView!{
        didSet {
            relationshipCollectionView.delegate = self
            relationshipCollectionView.dataSource = self
            relationshipCollectionView.register(UINib(nibName: collectionViewCell, bundle: nil), forCellWithReuseIdentifier: collectionViewCellIdentifier)
        }
    }
    @IBOutlet weak var responsibleCollectionView: UICollectionView! {
        didSet {
            responsibleCollectionView.delegate = self
            responsibleCollectionView.dataSource = self
            responsibleCollectionView.register(UINib(nibName: collectionViewCell, bundle: nil), forCellWithReuseIdentifier: collectionViewCellIdentifier)
        }
    }

    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        initializeDatabaseHelper()
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Helpers
    @IBAction func bannerTapped(_ sender: Any) {
        selectedActivity = data[1][0]
        performSegue(withIdentifier: "activityToDetailSegue", sender: self)
    }
    
    private func initializeDatabaseHelper() {
        let databaseHelper = DatabaseHelper()
        data.append(databaseHelper.getFavoriteActivities(showAll: false))
        data.append(databaseHelper.getActivities(showAll: false))
        data.append(databaseHelper.getActivities(categoryId: 1, showAll: false))
        data.append(databaseHelper.getActivities(categoryId: 2, showAll: false))
        data.append(databaseHelper.getActivities(categoryId: 3, showAll: false))
        data.append(databaseHelper.getActivities(categoryId: 4, showAll: false))
        data.append(databaseHelper.getActivities(categoryId: 5, showAll: false))
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "activityToDetailSegue" {
            let destination = segue.destination as! ActivityDetailViewController
            destination.delegate = self
            destination.detailActivity = selectedActivity
        }
    }
}

//MARK: - UICollectionView Data and Delegate
extension ActivityViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath) as! ActivityCollectionViewCell

        var activities: [Activity] = []

        if collectionView == favoriteCollectionView { activities = data[0] }
        else if collectionView == recommendedCollectionView { activities = data[1] }
        else if collectionView == awarenessCollectionView { activities = data[2] }
        else if collectionView == managementCollectionView { activities = data[3] }
        else if collectionView == socialCollectionView { activities = data[4] }
        else if collectionView == relationshipCollectionView { activities = data[5] }
        else if collectionView == responsibleCollectionView { activities = data[6] }

        cell.activity = activities[indexPath.item]
        cell.delegate = self
        prepareCardsColor(activity: activities[indexPath.item])
        cell.setUpData(categoryColor: categoryColor, categoryBorderColor: categoryBorderColor)

        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 1.5
        cell.layer.borderColor = UIColor(named: "CardsDarkBlueColor")?.cgColor
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == favoriteCollectionView { return data[0].count }
        else if collectionView == recommendedCollectionView { return data[1].count }
        else if collectionView == awarenessCollectionView { return data[2].count }
        else if collectionView == managementCollectionView { return data[3].count }
        else if collectionView == socialCollectionView { return data[4].count }
        else if collectionView == relationshipCollectionView { return data[5].count }
        else if collectionView == responsibleCollectionView { return data[6].count }
        return 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ActivityViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ActivityCollectionViewCell
        selectedActivity = cell.activity
        performSegue(withIdentifier: "activityToDetailSegue", sender: self)
    }
}

extension ActivityViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}

extension ActivityViewController: ActivityCollectionViewCellDelegate {
    func favoriteClicked(activity: Activity) {
        let databaseHelper = DatabaseHelper()
        data[0] = databaseHelper.getFavoriteActivities(showAll: false)
        favoriteCollectionView.reloadData()

        let categoryId = Int((activity.partOf?.id)!)

        var targetCollectionView = [recommendedCollectionView]

        var targetData = [data[1]]
        targetData.append(data[categoryId+1])

        if categoryId == 1 { targetCollectionView.append(awarenessCollectionView) }
        else if categoryId == 2 { targetCollectionView.append(managementCollectionView) }
        else if categoryId == 3 { targetCollectionView.append(socialCollectionView) }
        else if categoryId == 4 { targetCollectionView.append(relationshipCollectionView) }
        else if categoryId == 5 { targetCollectionView.append(responsibleCollectionView) }

        for i in 0..<targetData.count {
            let data = targetData[i]
            for j in 0..<data.count {
                if data[j] == activity {
                    targetCollectionView[i]?.reloadItems(at: [IndexPath(item: j, section: 0)])
                }
            }
        }
    }
}
