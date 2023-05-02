//
//  CashOutBodyBank.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 5/1/23.
//

import Foundation
import UIKit

class CashOutBodyBank : BaseView {
    
    var cashOutMain : CashOutMain?
    
    let bankIcon : UIButton = {
        
        let sii = UIButton(type: .system)
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.contentMode = .scaleAspectFit
        sii.isUserInteractionEnabled = true
        let image = UIImage(named: "bank_icon")?.withRenderingMode(.alwaysOriginal)
        sii.setImage(image, for: UIControl.State.normal)
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.isUserInteractionEnabled = true
        sii.imageView?.contentMode = .scaleAspectFit
        sii.backgroundColor = UIColor.kwiksGrey
        
        return sii
        
    }()
   
    var headerLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Bank Account"
        hfl.textColor = UIColor.kwiksTextBlack
        hfl.textAlignment = .left
        hfl.adjustsFontSizeToFitWidth = true //with right anchor on screen width
        hfl.font = UIFont.segoeUISemiBold(size: 16)
        
        return hfl
    }()
    
    var subHeaderLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Account ending with 6374"
        hfl.textColor = UIColor.fontBrown
        hfl.textAlignment = .left
        hfl.adjustsFontSizeToFitWidth = true //with right anchor on screen width
        hfl.font = UIFont.segoeUIRegular(size: 14)
        
        return hfl
    }()
    
    lazy var addAccountButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("+ Add Account", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.segoeUIRegular(size: 14)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = UIColor.kwiksGrey
        cbf.backgroundColor = .clear
        cbf.tintColor = UIColor.kwiksGrey
        cbf.addTarget(self, action: #selector(self.handleAddAccountButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    let containerView : UIView = {
        
        let ff = UIView()
        ff.translatesAutoresizingMaskIntoConstraints = false
        ff.backgroundColor = UIColor.white
        ff.isUserInteractionEnabled = true
        ff.layer.cornerRadius = 10
        ff.layer.masksToBounds = true
        ff.clipsToBounds = false
        ff.layer.masksToBounds = false
        ff.layer.shadowColor = UIColor.kwiksGrey.withAlphaComponent(0.5).cgColor
        ff.layer.shadowOpacity = 1.0
        ff.layer.shadowOffset = CGSize(width: 0, height: 12)
        ff.layer.shadowRadius = 32
        ff.layer.shouldRasterize = false
        
        return ff
    }()
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.triggerRefs() //no lazy
        self.addViews()
        
    }
    
    func triggerRefs() {
    }
    
    func addViews() {
        
        self.addSubview(self.containerView)
        self.addSubview(self.addAccountButton)
        
        self.containerView.addSubview(self.bankIcon)
        self.containerView.addSubview(self.headerLabel)
        self.containerView.addSubview(self.subHeaderLabel)

        self.containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.containerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.addAccountButton.topAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 15).isActive = true
        self.addAccountButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.addAccountButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.addAccountButton.heightAnchor.constraint(equalToConstant: 44).isActive = true

        self.bankIcon.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 20).isActive = true
        self.bankIcon.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor).isActive = true
        self.bankIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.bankIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.bankIcon.layer.cornerRadius = 20
        
        self.headerLabel.centerYAnchor.constraint(equalTo: self.bankIcon.centerYAnchor, constant: -11).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.bankIcon.rightAnchor, constant: 11).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        self.headerLabel.sizeToFit()
        
        self.subHeaderLabel.centerYAnchor.constraint(equalTo: self.bankIcon.centerYAnchor, constant: 11).isActive = true
        self.subHeaderLabel.leftAnchor.constraint(equalTo: self.bankIcon.rightAnchor, constant: 11).isActive = true
        self.subHeaderLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        self.subHeaderLabel.sizeToFit()

    }
    
    @objc func handleAddAccountButton() {
        self.cashOutMain?.handleAddAccountButton()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
