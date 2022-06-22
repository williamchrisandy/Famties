//
//  Extension+UICollectionViewCell.swift
//  Famties
//
//  Created by Hilmy Veradin on 16/06/22.
//

import UIKit

extension UICollectionViewCell {
    func shadowDecorate() {
        let radius: CGFloat = 10
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
    }
}
