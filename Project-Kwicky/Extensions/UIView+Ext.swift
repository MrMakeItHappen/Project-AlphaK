//
//  UIView+Ext.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/12/23.
//

import Foundation
import UIKit

extension UIView {
    enum RoundCornersAt{
        case topRight
        case topLeft
        case bottomRight
        case bottomLeft
    }
    
    func roundCorners(corners:[RoundCornersAt], radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [
            corners.contains(.topRight) ? .layerMaxXMinYCorner:.init(),
            corners.contains(.topLeft) ? .layerMinXMinYCorner:.init(),
            corners.contains(.bottomRight) ? .layerMaxXMaxYCorner:.init(),
            corners.contains(.bottomLeft) ? .layerMinXMaxYCorner:.init(),
        ]
    }
}
