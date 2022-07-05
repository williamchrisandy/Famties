//
//  CanvasViewViewCell.swift
//  Famties
//
//  Created by Hilmy Veradin on 04/07/22.
//

import UIKit
import PencilKit

class CanvasViewViewCell: UICollectionViewCell {


    @IBOutlet weak var canvasView: PKCanvasView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
