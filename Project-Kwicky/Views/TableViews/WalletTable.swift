//
//  WalletTable.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/24/23.
//

import Foundation
import UIKit

class WalletTable : UITableView, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    private let walletID = "walletID"
    
    var walletController : WalletController?
   
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.backgroundColor = UIColor.white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.dataSource = self
        self.delegate = self
        
        self.isPrefetchingEnabled = false
        self.keyboardDismissMode = UIScrollView.KeyboardDismissMode.interactive
        self.alwaysBounceVertical = true
        self.alwaysBounceHorizontal = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.allowsMultipleSelection = true
        self.canCancelContentTouches = false
        self.contentInsetAdjustmentBehavior = .never
        self.delaysContentTouches = true
        self.clipsToBounds = true
        self.separatorStyle = .none
        self.allowsSelection = false
        self.layer.cornerRadius = 30
        self.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        self.register(WalletFeeder.self, forCellReuseIdentifier: self.walletID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: self.walletID, for: indexPath) as! WalletFeeder
        cell.walletTable = self
        
        //speed & performance bump possibly, these controllers are difficult without pre fetching - added to chat main also
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
