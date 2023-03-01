//
//  WalletController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/19/23.
//

import UIKit

final class WalletController: UIViewController {

    private let tempImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .white
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 0
        imageView.height(30)
        imageView.width(30)
        
        let image = UIImage(named: "TempLogoIcon")?.withTintColor(.kwiksGreen)
        imageView.image = image
        return imageView
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "Coming Soon"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 16)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = .kwiksTextBlack
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.tempImageView)
        self.tempImageView.centerXToSuperview()
        self.tempImageView.centerYToSuperview(offset: -10)
        
        self.view.addSubview(self.tempLabel)
        self.tempLabel.topToBottom(of: self.tempImageView, offset: 10)
        self.tempLabel.centerX(to: self.tempImageView)
    }

}
