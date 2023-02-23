//
//  UIImageView+Ext.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/23/23.
//

import Foundation
import UIKit

extension UIImageView {
    static func createChevron() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(12)
        imageView.width(12)
        
        let image = UIImage(named: "GreyNextIcon")
        imageView.image = image
        return imageView
    }
}
