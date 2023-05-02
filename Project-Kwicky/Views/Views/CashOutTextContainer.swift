//
//  CashoutTextContainer.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 5/1/23.
//

import Foundation
import UIKit

class CashOutTextContainer : BaseView, UITextFieldDelegate {
    
    var cashOutMain : CashOutMain?
    
    //top container - this will house most of the components
    let containerView : UIView = {
        
        let ff = UIView()
        ff.translatesAutoresizingMaskIntoConstraints = false
        ff.backgroundColor = .clear
        ff.isUserInteractionEnabled = true
        ff.layer.masksToBounds = true
        ff.layer.cornerRadius = 25
        ff.backgroundColor = UIColor.kwiksGreen
        
        return ff
    }()
    
    var enterAmountLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Enter Amount"
        hfl.textColor = UIColor.white
        hfl.textAlignment = .left
        hfl.adjustsFontSizeToFitWidth = true
        hfl.font = UIFont.segoeUISemiBold(size: 20)
        
        return hfl
    }()
    
    let amountPrefixLabel : UILabel = {
        
        let dcl = UILabel()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.text = "$"
        dcl.font = UIFont.segoeUIBold(size: 32)
        dcl.textColor = UIColor.white
        
        return dcl
    }()
    
    let monetaryTextField : MonetaryTextField = {
        
        let mtf = MonetaryTextField()
        mtf.placeHolderText = "0.00"
        return mtf
    }()
    
    var usdEmblem : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = UIColor.emblemBrown.withAlphaComponent(0.6)
        hfl.text = "USD"
        hfl.textColor = UIColor.white
        hfl.textAlignment = .center
        hfl.layer.masksToBounds = true
        hfl.font = UIFont.segoeUISemiBold(size: 12)
        
        return hfl
    }()
    
    let moneyImageIcon : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.contentMode = .scaleAspectFill
        dcl.isUserInteractionEnabled = false
        dcl.clipsToBounds = true
        let image = UIImage(named: "kwiks_white_dollar_sign")?.withRenderingMode(.alwaysOriginal)
        dcl.image = image
        
        return dcl
    }()
    
    var coinConversionLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = ""
        hfl.textColor = UIColor.white
        hfl.textAlignment = .left
        hfl.adjustsFontSizeToFitWidth = true
        hfl.font = UIFont.segoeUISemiBold(size: 14)
        
        return hfl
    }()
    
    let dividerLine : LineView = {
        
        let ff = LineView()
        ff.translatesAutoresizingMaskIntoConstraints = false
        ff.backgroundColor = .clear
        ff.isUserInteractionEnabled = false
        ff.contentMode = .scaleToFill
        ff.clipsToBounds = true
        ff.lineColor = UIColor.white
        ff.lineWidth = 1.0
        return ff
    }()
    
    let footer : UIView = {
        
        let ff = UIView()
        ff.translatesAutoresizingMaskIntoConstraints = false
        ff.backgroundColor = .clear
        ff.isUserInteractionEnabled = true
        
        return ff
    }()
    
    var availableBalanceLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = ""
        hfl.textColor = UIColor.white
        hfl.textAlignment = .left
        hfl.adjustsFontSizeToFitWidth = true
        hfl.font = UIFont.segoeUISemiBold(size: 14)
        
        return hfl
    }()
    
    var totalValueLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = ""
        hfl.textColor = UIColor.white
        hfl.textAlignment = .right
        hfl.adjustsFontSizeToFitWidth = true
        hfl.font = UIFont.segoeUISemiBold(size: 14)
        
        return hfl
    }()
    
    var minLabel : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.segoeUISemiBold(size: 14)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = UIColor.black
        cbf.backgroundColor = UIColor.kwiksGrey
        cbf.tintColor = UIColor.black
        
        return cbf
        
    }()
    
    lazy var toolBar : UIToolbar = {
        
        let bar = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.resignation))
        bar.items = [space, done]
        bar.tintColor = UIColor.white
        bar.sizeToFit()
        
        return bar
        
    }()
   
    func triggerRefs() {
        self.monetaryTextField.cashOutTextContainer = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addViews()
        self.triggerRefs()
        self.monetaryTextField.inputAccessoryView = self.toolBar
        
    }
  
    func addViews() {
        
        self.addSubview(self.containerView)
        self.addSubview(self.enterAmountLabel)
        self.addSubview(self.monetaryTextField)
        self.addSubview(self.usdEmblem)
        self.addSubview(self.moneyImageIcon)
        self.addSubview(self.coinConversionLabel)
        self.addSubview(self.dividerLine)
        self.addSubview(self.footer)
        self.addSubview(self.totalValueLabel)

        self.addSubview(self.availableBalanceLabel)
        self.addSubview(self.minLabel)
        self.addSubview(self.amountPrefixLabel)

        self.containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true
        self.containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
        self.containerView.heightAnchor.constraint(equalToConstant: 208).isActive = true
        
        self.enterAmountLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 15).isActive = true
        self.enterAmountLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 25).isActive = true
        self.enterAmountLabel.sizeToFit()
        
        self.amountPrefixLabel.leftAnchor.constraint(equalTo: self.enterAmountLabel.leftAnchor, constant: 0).isActive = true
        self.amountPrefixLabel.topAnchor.constraint(equalTo: self.enterAmountLabel.bottomAnchor, constant: 20).isActive = true
        self.amountPrefixLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.amountPrefixLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.monetaryTextField.centerYAnchor.constraint(equalTo: self.amountPrefixLabel.centerYAnchor, constant: 0).isActive = true
        self.monetaryTextField.leftAnchor.constraint(equalTo: self.amountPrefixLabel.rightAnchor, constant: 5).isActive = true
        self.monetaryTextField.heightAnchor.constraint(equalToConstant: 43).isActive = true
        self.monetaryTextField.sizeToFit()
        
        self.usdEmblem.centerYAnchor.constraint(equalTo: self.monetaryTextField.centerYAnchor).isActive = true
        self.usdEmblem.leftAnchor.constraint(equalTo: self.monetaryTextField.rightAnchor, constant: 10).isActive = true
        self.usdEmblem.heightAnchor.constraint(equalToConstant: 22).isActive = true
        self.usdEmblem.widthAnchor.constraint(equalToConstant: 44).isActive = true
        self.usdEmblem.layer.cornerRadius = 22/2
        
        self.moneyImageIcon.leftAnchor.constraint(equalTo: self.amountPrefixLabel.leftAnchor, constant: 3).isActive = true
        self.moneyImageIcon.topAnchor.constraint(equalTo: self.monetaryTextField.bottomAnchor, constant: 8).isActive = true
        self.moneyImageIcon.heightAnchor.constraint(equalToConstant: 18).isActive = true
        self.moneyImageIcon.widthAnchor.constraint(equalToConstant: 12).isActive = true
        
        self.coinConversionLabel.leftAnchor.constraint(equalTo: self.moneyImageIcon.rightAnchor, constant: 7).isActive = true
        self.coinConversionLabel.centerYAnchor.constraint(equalTo: self.moneyImageIcon.centerYAnchor).isActive = true
        self.coinConversionLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -30).isActive = true
        self.coinConversionLabel.sizeToFit()
        
        self.dividerLine.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -50).isActive = true
        self.dividerLine.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
        self.dividerLine.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true
        self.dividerLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.footer.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
        self.footer.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
        self.footer.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true
        self.footer.topAnchor.constraint(equalTo: self.dividerLine.bottomAnchor).isActive = true
        
        self.totalValueLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -18).isActive = true
        self.totalValueLabel.centerYAnchor.constraint(equalTo: self.footer.centerYAnchor).isActive = true
        self.totalValueLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.totalValueLabel.sizeToFit()
        
        self.availableBalanceLabel.centerYAnchor.constraint(equalTo: self.footer.centerYAnchor).isActive = true
        self.availableBalanceLabel.leftAnchor.constraint(equalTo: self.moneyImageIcon.leftAnchor, constant: 0).isActive = true
        self.availableBalanceLabel.rightAnchor.constraint(equalTo: self.totalValueLabel.leftAnchor, constant: -30).isActive = true
        self.availableBalanceLabel.sizeToFit()
        
        self.minLabel.topAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 22).isActive = true
        self.minLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.minLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        self.minLabel.widthAnchor.constraint(equalToConstant: 91).isActive = true
        self.minLabel.layer.cornerRadius = 21/2

    }
 
    @objc func resignation() {
        self.monetaryTextField.resignFirstResponder()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
