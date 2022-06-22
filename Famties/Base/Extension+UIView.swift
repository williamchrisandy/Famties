//
//  Extension+UIView.swift
//  Famties
//
//  Created by Hilmy Veradin on 16/06/22.
//

import UIKit

extension UIView {
    
    func anchor (top: NSLayoutYAxisAnchor? = nil,
                 paddingTop: CGFloat = 0,
                 bottom: NSLayoutYAxisAnchor? = nil,
                 paddingBottom: CGFloat = 0,
                 left: NSLayoutXAxisAnchor? = nil,
                 paddingLeft: CGFloat = 0,
                 right: NSLayoutXAxisAnchor? = nil,
                 paddingRight: CGFloat = 0,
                 width: CGFloat = 0,
                 height: CGFloat = 0,
                 centerX: NSLayoutXAxisAnchor? = nil,
                 centerY: NSLayoutYAxisAnchor? = nil,
                 enableInsets: Bool = false) {
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        
        if #available(iOS 11, *), enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom
            
            print("Top: \(topInset)")
            print("bottom: \(bottomInset)")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
    }
}
