//
//  UIButton+Ext.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/18/23.
//

import Foundation
import UIKit

extension UIButton {
    static func createCloseButton() -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.tintColor = .kwiksGreen
        button.setImage(UIImage(named: "CloseIcon"), for: .normal)
        button.width(16)
        button.height(16)
        return button
    }
}
