//  CashoutConfirmationPopUp.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 5/1/23.
//

import Foundation
import UIKit

class CashoutConfirmationPopUp : UIView {
    
    var popupHeight : CGFloat = 406,
        cashOutMain : CashOutMain?,
        swipeDown = UISwipeGestureRecognizer(),
        singleTap = UITapGestureRecognizer()
    
    var smokeView : UIView = {
        
        let bc = UIView()
        bc.translatesAutoresizingMaskIntoConstraints = true
        bc.layer.masksToBounds = true
        bc.frame = CGRect(x: 0, y: 0, width: globalDeviceWidth, height: globalDeviceHeight)
        bc.backgroundColor = UIColor.kwiksPopupTint
        bc.isUserInteractionEnabled = true
        bc.alpha = 0.0
        return bc
    }()
    
    var popupContainer : UIButton = {
        
        let bc = UIButton()
        bc.translatesAutoresizingMaskIntoConstraints = true
        bc.backgroundColor = UIColor.white
        bc.layer.masksToBounds = true
        bc.isUserInteractionEnabled = true
        bc.contentMode = .scaleAspectFit
        bc.backgroundColor = UIColor.white
        bc.imageView?.contentMode = .bottom
        bc.layer.cornerRadius = 24
      
        return bc
    }()
    
    let headerButton : UIButton = {
        
        let sii = UIButton(type: .system)
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.contentMode = .scaleAspectFit
        sii.isUserInteractionEnabled = true
        let image = UIImage(named: "credit_card_icon_popup")?.withRenderingMode(.alwaysOriginal)
        sii.setImage(image, for: UIControl.State.normal)
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.isUserInteractionEnabled = true
        sii.imageView?.contentMode = .scaleAspectFill
        sii.backgroundColor = .white
        sii.layer.borderColor = UIColor.kwiksGreen.cgColor
        sii.layer.borderWidth = 1
        return sii
        
    }()
    
    var headerLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Cashout Confirmation"
        hfl.textColor = UIColor.kwiksTextBlack
        hfl.textAlignment = .center
        hfl.font = UIFont.segoeUIBold(size: 24)
        
        return hfl
    }()
    
    var sendNowButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Okay, Send Now", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.segoeUISemiBold(size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = UIColor.white
        cbf.backgroundColor = UIColor.kwiksGreen
        cbf.tintColor = UIColor.white
        
        return cbf
        
    }()
    
    var centerContainer : UIView = {
        
        let cc = UIView()
        cc.translatesAutoresizingMaskIntoConstraints = false
        cc.backgroundColor = UIColor.clear
        return cc
    }()
    
    var receivingWalletLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Receiving Wallet"
        hfl.textColor = UIColor.kwiksTextBlack
        hfl.textAlignment = .left
        hfl.font = UIFont.segoeUIRegular(size: 14)
        
        return hfl
    }()
    
    var accountNumberLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Account No"
        hfl.textColor = UIColor.kwiksTextBlack
        hfl.textAlignment = .right
        hfl.font = UIFont.segoeUIRegular(size: 14)

        return hfl
    }()
    
    var bankAccountLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Account No"
        hfl.textColor = UIColor.black
        hfl.textAlignment = .left
        hfl.font = UIFont.segoeUISemiBold(size: 16)

        return hfl
    }()
    
    var bankAccountNumberLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = ""
        hfl.textColor = UIColor.black
        hfl.textAlignment = .right
        hfl.font = UIFont.segoeUISemiBold(size: 16)

        return hfl
    }()
    
    let dividerLineTop : LineView = {
        
        let ff = LineView()
        ff.translatesAutoresizingMaskIntoConstraints = false
        ff.backgroundColor = .clear
        ff.isUserInteractionEnabled = false
        ff.contentMode = .scaleToFill
        ff.clipsToBounds = true
        ff.lineColor = UIColor.kwiksTextBlack
        ff.lineWidth = 1.0
        return ff
    }()
    
    var transactionFeeLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Transaction fee"
        hfl.textColor = UIColor.kwiksGrey
        hfl.textAlignment = .left
        hfl.font = UIFont.segoeUISemiBold(size: 16)

        return hfl
    }()
    
    var transactionFeeAmountLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = ""
        hfl.textColor = UIColor.kwiksGrey
        hfl.textAlignment = .right
        hfl.font = UIFont.segoeUISemiBold(size: 16)

        return hfl
    }()
    
    let dividerLineBottom : LineView = {
        
        let ff = LineView()
        ff.translatesAutoresizingMaskIntoConstraints = false
        ff.backgroundColor = .clear
        ff.isUserInteractionEnabled = false
        ff.contentMode = .scaleToFill
        ff.clipsToBounds = true
        ff.lineColor = UIColor.black
        ff.lineWidth = 1.0
        return ff
    }()
    
    var totalAmountLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Total Amount"
        hfl.textColor = UIColor.black
        hfl.textAlignment = .left
        hfl.font = UIFont.segoeUISemiBold(size: 18)
        
        return hfl
    }()
    
    var totalAmountNumberLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "$50.00"
        hfl.textColor = UIColor.black
        hfl.textAlignment = .right
        hfl.font = UIFont.segoeUISemiBold(size: 18)

        return hfl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = true
        
        self.addViews()
        self.triggerRefs()
        
    }
    
    func triggerRefs() {
        self.sendNowButton.addTarget(self, action: #selector(self.handleSendNowButton), for: .touchUpInside)
    }
    
    func fillValues(totalAmount : String, transactionFeeAmount : String, cardNumber : String) {
        
        self.totalAmountNumberLabel.text = totalAmount
        self.transactionFeeAmountLabel.text = totalAmount
        self.bankAccountNumberLabel.text = cardNumber

    }
    
    func addViews() {
        
        self.addSubview(self.smokeView)
        self.addSubview(self.popupContainer)
        self.addSubview(self.headerButton)
        self.addSubview(self.headerLabel)
        self.addSubview(self.sendNowButton)
        self.addSubview(self.centerContainer)
        
        self.addSubview(self.receivingWalletLabel)
        self.addSubview(self.accountNumberLabel)
        self.addSubview(self.bankAccountLabel)
        self.addSubview(self.bankAccountNumberLabel)
        self.addSubview(self.dividerLineTop)
        self.addSubview(self.transactionFeeLabel)
        self.addSubview(self.transactionFeeAmountLabel)
        self.addSubview(self.dividerLineBottom)
        
        self.addSubview(self.totalAmountLabel)
        self.addSubview(self.totalAmountNumberLabel)


        self.popupContainer.frame = CGRect(x: ((globalDeviceWidth - (globalDeviceWidth - 60)) / 2), y: globalDeviceHeight, width: globalDeviceWidth - 60, height: self.popupHeight)
        ///convenient dismiss action
        self.swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.closeFlag))
        self.swipeDown.direction = .down
        
        self.singleTap = UITapGestureRecognizer(target: self, action: #selector(self.closeFlag))
        
        self.smokeView.addGestureRecognizer(singleTap)
        self.smokeView.addGestureRecognizer(swipeDown)
        
        self.headerButton.centerYAnchor.constraint(equalTo: self.popupContainer.topAnchor, constant: 0).isActive = true
        self.headerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.headerButton.heightAnchor.constraint(equalToConstant: 88).isActive = true
        self.headerButton.widthAnchor.constraint(equalToConstant: 88).isActive = true
        self.headerButton.layer.cornerRadius = 88/2
        
        self.headerLabel.topAnchor.constraint(equalTo: self.headerButton.bottomAnchor, constant: 20).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.popupContainer.leftAnchor, constant: 20).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.popupContainer.rightAnchor, constant: -20).isActive = true
        self.headerLabel.sizeToFit()
        
        self.sendNowButton.bottomAnchor.constraint(equalTo: self.popupContainer.bottomAnchor, constant: -30).isActive = true
        self.sendNowButton.leftAnchor.constraint(equalTo: self.popupContainer.leftAnchor, constant: 30).isActive = true
        self.sendNowButton.rightAnchor.constraint(equalTo: self.popupContainer.rightAnchor, constant: -30).isActive = true
        self.sendNowButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.sendNowButton.layer.cornerRadius = 25
        
        self.centerContainer.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 5).isActive = true
        self.centerContainer.leftAnchor.constraint(equalTo: self.popupContainer.leftAnchor, constant: 0).isActive = true
        self.centerContainer.rightAnchor.constraint(equalTo: self.popupContainer.rightAnchor, constant: 0).isActive = true
        self.centerContainer.bottomAnchor.constraint(equalTo: self.sendNowButton.topAnchor, constant: -5).isActive = true
        
        self.accountNumberLabel.rightAnchor.constraint(equalTo: self.popupContainer.rightAnchor, constant: -30).isActive = true
        self.accountNumberLabel.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 29).isActive = true
        self.accountNumberLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 10).isActive = true
        self.accountNumberLabel.sizeToFit()
        
        self.receivingWalletLabel.centerYAnchor.constraint(equalTo: self.accountNumberLabel.centerYAnchor, constant: 0).isActive = true
        self.receivingWalletLabel.leftAnchor.constraint(equalTo: self.popupContainer.leftAnchor, constant: 30).isActive = true
        self.receivingWalletLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -10).isActive = true
        self.receivingWalletLabel.sizeToFit()
        
        self.bankAccountLabel.topAnchor.constraint(equalTo: self.receivingWalletLabel.bottomAnchor, constant: 8).isActive = true
        self.bankAccountLabel.leftAnchor.constraint(equalTo: self.receivingWalletLabel.leftAnchor, constant: 0).isActive = true
        self.bankAccountLabel.rightAnchor.constraint(equalTo: self.receivingWalletLabel.rightAnchor, constant: 0).isActive = true
        self.bankAccountLabel.sizeToFit()
        
        self.bankAccountNumberLabel.centerYAnchor.constraint(equalTo: self.bankAccountLabel.centerYAnchor, constant: 0).isActive = true
        self.bankAccountNumberLabel.leftAnchor.constraint(equalTo: self.accountNumberLabel.leftAnchor, constant: 0).isActive = true
        self.bankAccountNumberLabel.rightAnchor.constraint(equalTo: self.accountNumberLabel.rightAnchor, constant: 0).isActive = true
        self.bankAccountNumberLabel.sizeToFit()
        
        self.dividerLineTop.topAnchor.constraint(equalTo: self.bankAccountLabel.bottomAnchor, constant: 20).isActive = true
        self.dividerLineTop.leftAnchor.constraint(equalTo: self.bankAccountLabel.leftAnchor, constant: 0).isActive = true
        self.dividerLineTop.rightAnchor.constraint(equalTo: self.bankAccountNumberLabel.rightAnchor, constant: 0).isActive = true
        self.dividerLineTop.heightAnchor.constraint(equalToConstant: 1.0).isActive = true

        self.transactionFeeLabel.leftAnchor.constraint(equalTo: self.bankAccountLabel.leftAnchor, constant: 0).isActive = true
        self.transactionFeeLabel.topAnchor.constraint(equalTo: self.dividerLineTop.bottomAnchor, constant: 18).isActive = true
        self.transactionFeeLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -10).isActive = true
        self.transactionFeeLabel.sizeToFit()
        
        self.transactionFeeAmountLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 10).isActive = true
        self.transactionFeeAmountLabel.centerYAnchor.constraint(equalTo: self.transactionFeeLabel.centerYAnchor, constant: 0).isActive = true
        self.transactionFeeAmountLabel.rightAnchor.constraint(equalTo: self.bankAccountNumberLabel.rightAnchor, constant: 0).isActive = true
        self.transactionFeeAmountLabel.sizeToFit()
        
        self.dividerLineBottom.topAnchor.constraint(equalTo: self.transactionFeeLabel.bottomAnchor, constant: 20).isActive = true
        self.dividerLineBottom.leftAnchor.constraint(equalTo: self.bankAccountLabel.leftAnchor, constant: 0).isActive = true
        self.dividerLineBottom.rightAnchor.constraint(equalTo: self.bankAccountNumberLabel.rightAnchor, constant: 0).isActive = true
        self.dividerLineBottom.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        self.totalAmountLabel.leftAnchor.constraint(equalTo: self.bankAccountLabel.leftAnchor, constant: 0).isActive = true
        self.totalAmountLabel.topAnchor.constraint(equalTo: self.dividerLineBottom.bottomAnchor, constant: 18).isActive = true
        self.totalAmountLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -10).isActive = true
        self.totalAmountLabel.sizeToFit()
        
        self.totalAmountNumberLabel.rightAnchor.constraint(equalTo: self.bankAccountNumberLabel.rightAnchor, constant: 0).isActive = true
        self.totalAmountNumberLabel.centerYAnchor.constraint(equalTo: self.totalAmountLabel.centerYAnchor, constant: 0).isActive = true
        self.totalAmountNumberLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 10).isActive = true
        self.totalAmountNumberLabel.sizeToFit()

    }
    
    func runFlag() {
        
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn) {
            self.smokeView.alpha = 1.0
        } completion: { complete in
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear) {
                self.popupContainer.frame = CGRect(x: ((globalDeviceWidth - (globalDeviceWidth - 60)) / 2), y: (0), width: globalDeviceWidth - 60, height: self.popupHeight)
                self.popupContainer.center.y = self.center.y
                self.layoutIfNeeded()
            } completion: { complete in
                print("🟢 Animations in")
            }
        }
    }
    
    @objc func closeFlag() {
     
        UIDevice.vibrateLight()
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
            self.popupContainer.frame = CGRect(x: ((globalDeviceWidth - (globalDeviceWidth - 60)) / 2), y: globalDeviceHeight, width: globalDeviceWidth - 60, height: self.popupHeight)
            self.smokeView.alpha = 0.0
            self.layoutIfNeeded()
        } completion: { complete in
            self.removeFromSuperview()
        }
    }
    
    @objc func handleSendNowButton() {
//        self.walletController?.handleSendNowButton()
        self.closeFlag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
