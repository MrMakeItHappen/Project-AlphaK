//
//  UILabel+Ext.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/23/23.
//

import Foundation
import UIKit

extension UILabel {
    static func createSettingsSectionHeader(with name: String) -> UILabel {
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
    
    static func createSettingsTitleLabel(with name: String) -> UILabel {
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
    
    static func createSettingsSublabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 14)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#A9A9A9")
        return label
    }
    
}

extension UILabel { //color parts of a string, set the default on the label then adjust the word/phrase with the parameters
    func colorFontString(text: String?, coloredText: String?, color: UIColor? = .red, fontName : String? = "Arial", fontSize : Double? = 13) {
        
        let attributedString = NSMutableAttributedString(string: text!)
        let range = (text! as NSString).range(of: coloredText!)
        
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color!, NSAttributedString.Key.font: UIFont(name: fontName!, size: fontSize!) as Any],
                                       range: range)
        
        self.attributedText = attributedString
    }
}
