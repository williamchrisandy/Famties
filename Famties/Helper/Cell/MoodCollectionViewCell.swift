//
//  MoodCollectionViewCell.swift
//  Famties
//
//  Created by Hocky on 23/06/22.
//

import UIKit

class MoodCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moodBackground: UIView!
    @IBOutlet weak var moodEmoji: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initDesign()
    }

    func initDesign(){
        // layouts
    }
}
