//
//  WalletCell.swift
//  Project-Kwicky
//
//  Created by Charlie Arcodia on 5/2/23.
//

import Foundation
import UIKit

class WalletFeeder : UITableViewCell {
    
    var walletTable : WalletTable?
    
    let leftIcon : UIButton = {
        
        let dcl = UIButton()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.contentMode = .scaleAspectFill
        dcl.isUserInteractionEnabled = false
        dcl.clipsToBounds = true
        dcl.backgroundColor = UIColor.kwiksGrey
        dcl.layer.masksToBounds = true
        dcl.layer.cornerRadius = 20
        let image = UIImage(named: "wallet_add_money_icon")?.withRenderingMode(.alwaysOriginal)
        dcl.setImage(image, for: .normal)
        
        return dcl
    }()
    
    var increasePriceLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "+465"
        hfl.textColor = UIColor.kwiksTextBlack
        hfl.textAlignment = .right
        hfl.font = UIFont.segoeUIBold(size: 18)
        
        
        return hfl
    }()
    
    var headerLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Cashback from Kwiks"
        hfl.textColor = UIColor.kwiksTextBlack
        hfl.textAlignment = .left
        hfl.font = UIFont.segoeUISemiBold(size: 16)
        
        return hfl
    }()
    
    var subHeaderLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "23-02-2023"
        hfl.textColor = UIColor.kwiksGrey
        hfl.textAlignment = .left
        hfl.font = UIFont.segoeUIRegular(size: 14)
        
        return hfl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor .clear
        self.contentView.isUserInteractionEnabled = false
        self.addViews()
        
    }
    
    func addViews() {
        
        self.addSubview(self.leftIcon)
        self.addSubview(self.increasePriceLabel)
        self.addSubview(self.headerLabel)
        self.addSubview(self.subHeaderLabel)

        self.leftIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.leftIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 27).isActive = true
        self.leftIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.leftIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.increasePriceLabel.centerYAnchor.constraint(equalTo: self.leftIcon.centerYAnchor, constant: 0).isActive = true
        self.increasePriceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.increasePriceLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.increasePriceLabel.sizeToFit()
        
        self.headerLabel.centerYAnchor.constraint(equalTo: self.leftIcon.centerYAnchor, constant: -10).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.leftIcon.rightAnchor, constant: 11).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.increasePriceLabel.leftAnchor, constant: -20).isActive = true
        self.headerLabel.sizeToFit()
        
        self.subHeaderLabel.centerYAnchor.constraint(equalTo: self.leftIcon.centerYAnchor, constant: 10).isActive = true
        self.subHeaderLabel.leftAnchor.constraint(equalTo: self.leftIcon.rightAnchor, constant: 11).isActive = true
        self.subHeaderLabel.rightAnchor.constraint(equalTo: self.increasePriceLabel.leftAnchor, constant: -20).isActive = true
        self.subHeaderLabel.sizeToFit()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

