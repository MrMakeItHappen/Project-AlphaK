//  CashOutMain.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 5/1/23.
//

import Foundation
import UIKit

class CashOutMain : BaseViewController {
    
    enum Trajectory {
        case fromCashOut
        case fromAddMoney
    }
    
    var walletMain : WalletController?,
        trajectory = Trajectory.fromCashOut
    
    //subclass
    let cashOutMainHeader : CashOutMainHeader = {
        let wh = CashOutMainHeader(frame: .zero)
        return wh
    }()
    
    //subclass
    let cashOutTextContainer : CashOutTextContainer = {
        let wh = CashOutTextContainer(frame: .zero)
        return wh
    }()
    
    //subclass
    let cashOutBodyBank : CashOutBodyBank = {
        let wh = CashOutBodyBank(frame: .zero)
        return wh
    }()
    
    var nextButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Next", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.segoeUISemiBold(size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.backgroundColor = UIColor.kwiksGreen
        cbf.tintColor = UIColor.white
        
        return cbf
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addViews()
        self.fillValues()
        self.triggerRefs()
        
    }
    
    func triggerRefs() {
        self.cashOutMainHeader.cashOutMain = self
        self.cashOutTextContainer.cashOutMain = self
        self.nextButton.addTarget(self, action: #selector(self.handleNextButton), for: .touchUpInside)
    }
    
    func addViews() {
        
        self.view.addSubview(self.cashOutMainHeader)
        self.view.addSubview(self.cashOutTextContainer)
        self.view.addSubview(self.nextButton)
        self.view.addSubview(self.cashOutBodyBank)

        self.cashOutMainHeader.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        self.cashOutMainHeader.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.cashOutMainHeader.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.cashOutMainHeader.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.cashOutTextContainer.topAnchor.constraint(equalTo: self.cashOutMainHeader.bottomAnchor, constant: 5).isActive = true
        self.cashOutTextContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.cashOutTextContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.cashOutTextContainer.heightAnchor.constraint(equalToConstant: 265).isActive = true
        
        self.nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        self.nextButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.nextButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.nextButton.layer.cornerRadius = 25
        
        self.cashOutBodyBank.topAnchor.constraint(equalTo: self.cashOutTextContainer.bottomAnchor, constant: 60).isActive = true
        self.cashOutBodyBank.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.cashOutBodyBank.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.cashOutBodyBank.bottomAnchor.constraint(equalTo: self.nextButton.topAnchor, constant: -30).isActive = true
        
    }
    
    func fillValues() {
        
        switch trajectory {
        case .fromCashOut: self.cashOutMainHeader.backDescriptionLabel.text = "Cashout"
        case .fromAddMoney: self.cashOutMainHeader.backDescriptionLabel.text = "Add Money"
        }
        
        self.cashOutTextContainer.minLabel.setTitle("Min $5.00", for: .normal)
        self.cashOutTextContainer.totalValueLabel.text = "$231"
        self.cashOutTextContainer.availableBalanceLabel.text = "Available Balance: 1267 Kwiks"
        self.cashOutTextContainer.coinConversionLabel.text = "406 Kwiks"
        
    }
    
    //from settings logout button, prompt to confirm
    func presentCashoutPopup() {
    
        UIDevice.vibrateLight()
        let cashoutConfirmationPopUp = CashoutConfirmationPopUp()
        cashoutConfirmationPopUp.cashOutMain = self
        cashoutConfirmationPopUp.frame = self.view.frame
        self.view.addSubview(cashoutConfirmationPopUp)
        
        cashoutConfirmationPopUp.fillValues(totalAmount: "$3.99", transactionFeeAmount: "$0.00", cardNumber: "****6468")
        cashoutConfirmationPopUp.runFlag()
    
    }
    
    @objc func handleNextButton() {
        self.presentCashoutPopup()
    }
}

//passed from subclass'
extension CashOutMain {
    
    //passed from cashoutbodybank
    @objc func handleAddAccountButton() {
        print(#function)
    }
    
    //passed from cashoutmainheader
    @objc func handleDismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //passed from cashout confirmation popup
    @objc func handleSendNowButton() {
        print(#function)
    }
}
