//
//  UILabel+Ext.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/23/23.
//

import Foundation
import UIKit

extension UILabel {
    static func createSettingsHeaderLabel(with name: String) -> UILabel {
        let label = UILabel()
        label.text = name
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 15)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }
    
    static func createSettingsLabel(with name: String) -> UILabel {
        let label = UILabel()
        label.text = name
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }
}
