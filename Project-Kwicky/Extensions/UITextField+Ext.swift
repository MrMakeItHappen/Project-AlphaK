//
//  TextField+Ext.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/11/23.
//

import UIKit

extension UITextField {
    //Enable & Configure Left Padding
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let frameHeight = self.frame.size.height
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frameHeight))
        
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount: CGFloat){
        let frameHeight = self.frame.size.height
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frameHeight))
        
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
