//
//  TextField+Ext.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/11/23.
//

import UIKit
import Foundation

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
    
    func setPasswordToggleImage(_ button: UIButton) {
        if isSecureTextEntry {
            button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            button.tintColor = UIColor(hexString: "#797979")
        } else {
            button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            button.tintColor = UIColor(hexString: "#797979")
        }
    }
}

class MonetaryTextField : UITextField, UITextFieldDelegate {
    
    var placeHolderText : String? = "0.00"
    var cashOutTextContainer : CashOutTextContainer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let placeholder = NSAttributedString(string: self.placeHolderText!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(1.0)])
        self.attributedPlaceholder = placeholder
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .center
        self.textColor = .white
        self.font = UIFont.segoeUIBold(size: 32)
        self.allowsEditingTextAttributes = true
        self.autocorrectionType = .no
        self.delegate = self
        self.backgroundColor = .clear
        self.keyboardAppearance = UIKeyboardAppearance.dark
        self.returnKeyType = UIReturnKeyType.done
        self.keyboardType = .decimalPad
        self.leftViewMode = .always
        self.isSecureTextEntry = false
        self.layer.masksToBounds = false
        self.textContentType = nil //no prefilled fields
        self.tintColor = .white
        self.layer.borderColor = UIColor .clear.cgColor
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if ((string == "0" || string == "") && (textField.text! as NSString).range(of: ".").location < range.location) {
            return true
        }
        
        // First check whether the replacement string's numeric...
        let cs = NSCharacterSet(charactersIn: "0123456789.").inverted
        let filtered = string.components(separatedBy: cs)
        let component = filtered.joined(separator: "")
        let isNumeric = string == component
        
        if isNumeric {
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 8
            
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let numberWithOutCommas = newString.replacingOccurrences(of: ",", with: "")
            let number = formatter.number(from: numberWithOutCommas)
            if number != nil {
                var formattedString = formatter.string(from: number!)
                
                if string == "." && range.location == textField.text?.count {
                    formattedString = formattedString?.appending(".")
                }
                
                textField.text = formattedString
                
            } else {
                
                textField.text = nil
            }
        }
        return false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
