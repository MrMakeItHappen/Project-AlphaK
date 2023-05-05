
//  WalletMain.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/21/23.
//

import Foundation
import UIKit

class WalletController : BaseViewController, UIScrollViewDelegate {
    
    //subclass
    let walletHeader : WalletMainHeader = {
        let wh = WalletMainHeader(frame: .zero)
        return wh
    }()
    
    //subclass
    let walletBalancePagination : WalletBalancePagination = {
        let wh = WalletBalancePagination(frame: .zero)
        return wh
    }()
    
    let walletTable : WalletTable = {
        let wt = WalletTable(frame: .zero, style: .grouped)
       return wt
    }()
    
    lazy var scrollView : UIScrollView = {
        
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .clear
        sv.isScrollEnabled = true
        sv.minimumZoomScale = 1.0
        sv.maximumZoomScale = 1.0
        sv.bounces = true
        sv.bouncesZoom = true
        sv.isHidden = false
        sv.delegate = self
        sv.contentMode = .scaleAspectFit
        sv.isUserInteractionEnabled = true
        sv.delaysContentTouches = false
        sv.canCancelContentTouches = true
        
        return sv
        
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.backgroundWhiteishGrey
        self.addViews()
        self.triggerRefs()
    }
    
    //references to kick lazy loading when unecessary per @stanley
    func triggerRefs() {
        self.walletHeader.walletController = self
        self.walletBalancePagination.walletController = self
        self.walletTable.walletController = self
    }
        
    func addViews() {
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.walletHeader)
        self.scrollView.addSubview(self.walletBalancePagination)
        self.scrollView.addSubview(self.walletTable)
        
        self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        self.walletHeader.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.walletHeader.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.walletHeader.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.walletHeader.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.walletBalancePagination.topAnchor.constraint(equalTo: self.walletHeader.bottomAnchor, constant: 10).isActive = true
        self.walletBalancePagination.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.walletBalancePagination.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.walletBalancePagination.heightAnchor.constraint(equalToConstant: 325).isActive = true//rough starting height

        self.walletTable.topAnchor.constraint(equalTo: self.walletBalancePagination.bottomAnchor, constant: 0).isActive = true
        self.walletTable.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.walletTable.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.walletTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        let offSet : CGFloat = 60.0 + 200.0 //taken from main header, the actual heights - leave a little room at the top to swipe down and take off tabbar
        self.scrollView.contentSize = CGSize(width: _globalDeviceWidth, height: UIScreen.main.bounds.height + offSet)
        
    }
    
    func fillValues() {
        let image = UIImage(named: "FemalePlaceholder")?.withRenderingMode(.alwaysOriginal)
        self.walletHeader.profileButton.setImage(image, for: .normal)
        self.walletHeader.nameLabel.text = "Charlie"
        self.walletBalancePagination.balanceLabel.text = "113.67"
        self.walletBalancePagination.priceContainerLabel.text = "47.26 This Week"
        
        //set the default font style above, then change the bold text here or vice versa works also
        self.walletBalancePagination.priceContainerLabel.colorFontString(text: "47.26  This Week", coloredText: "47.26", color: UIColor.kwiksTextBlack, fontName: UIFont.segoeBold, fontSize: 15)
        //control progree '0.0-> 1.0 and use the percentage here'
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.fillValues()
        self.walletBalancePagination.handleProgression()
        self.walletBalancePagination.adjustStroke(end: 0.75)

    }
    
    func updateHeight() {
        
        UIView.animate(withDuration: 0.4) {
            
            self.view.invalidateIntrinsicContentSize()
            self.view.superview?.setNeedsLayout()
            self.scrollView.layoutSubviews()
            self.scrollView.layoutIfNeeded()
            
        } completion: { (complete) in }
    }
}

extension WalletController {
    
    //CTA -> Settings
    @objc func handleSettingsButton() {
        print(#function)
    }
    @objc func handleQuestionMarkButton() {
        print(#function)
    }
    //passed from wallet balance pagination
    @objc func handleCashOutButton(sender: UIButton) {
        self.handleCashOuthandler(sender: sender)
        print(#function)
    }
    @objc func handleAddMoneyButton(sender: UIButton) {
        self.handleCashOuthandler(sender: sender)
        print(#function)
    }
    
    //class controls cash in and cash out - change the name to match
    func handleCashOuthandler(sender:UIButton) {
        
        let cashOutMain = CashOutMain() //push this
        cashOutMain.walletMain = self
        switch sender.tag {
        //cash out button
        case 1:
            cashOutMain.trajectory = .fromCashOut
        //add money button
        case 2:
            cashOutMain.trajectory = .fromAddMoney
            
        default: print("🔴 prepare for other buttons")
        }
       
        self.navigationController?.pushViewController(cashOutMain, animated: true)
    }
}
