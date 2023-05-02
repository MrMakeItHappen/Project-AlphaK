//
//  CashOutMainHeader.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 5/1/23.
//

import Foundation
import UIKit

class CashOutMainHeader : BaseView {
    
    var cashOutMain : CashOutMain?
    
    let backButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        let image = UIImage(named: "back_arrow_long")?.withRenderingMode(.alwaysOriginal)
        cbf.setImage(image, for: UIControl.State.normal)
        cbf.tintColor = UIColor.brown
        return cbf
        
    }()
    
    var backDescriptionLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = ""
        hfl.textColor = UIColor.kwiksTextBlack
        hfl.textAlignment = .left
        hfl.adjustsFontSizeToFitWidth = true //with right anchor on screen width
        hfl.font = UIFont.segoeUISemiBold(size: 25)
        
        return hfl
    }()
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.triggerRefs() //no lazy
        self.addViews()
        
    }
    
    func triggerRefs() {
        self.backButton.addTarget(self, action: #selector(self.handleBackButton), for: .touchUpInside)
    }
    
    func addViews() {
        
        self.addSubview(self.backButton)
        self.addSubview(self.backDescriptionLabel)

        self.backButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        self.backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.backDescriptionLabel.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor).isActive = true
        self.backDescriptionLabel.leftAnchor.constraint(equalTo: self.backButton.rightAnchor, constant: 10).isActive = true
        self.backDescriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true//just incase for super long names
        self.backDescriptionLabel.sizeToFit()
        
    }
    
    @objc func handleBackButton() {
        self.cashOutMain?.handleDismiss()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
