//
//  ProductCollectionViewCell.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/21/23.
//

import UIKit

final class ProductCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProductCollectionViewCell"
    
    private let coinValueContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .kwiksGreen
        view.width(50)
        view.height(20)
        view.layer.cornerRadius = 9
        return view
    }()
    
    private let moneySignImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(12)
        imageView.width(12)
        
        let image = UIImage(named: "MoneySignIcon")
        imageView.image = image
        return imageView
    }()
    
    private let coinValueLabel: UILabel = {
        let label = UILabel()
        label.text = "999"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .segoeUISemiBold(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(12)
        imageView.width(12)
        
        let image = UIImage(named: "StarIcon")
        imageView.image = image
        return imageView
    }()
    
    private let starRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .segoeUISemiBold(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        let size: CGFloat = 70
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.white
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.height(size)
        imageView.width(size)
        imageView.image = UIImage(named: "ProductPlaceholder01")
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Joyroom Earbud"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .segoeUISemiBold(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.clipsToBounds = true
        self.layer.cornerRadius = 13
        self.layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        self.addSubview(self.coinValueContainerView)
        self.coinValueContainerView.topToSuperview(offset: 8)
        self.coinValueContainerView.leftToSuperview(offset: 6)
        
        self.coinValueContainerView.addSubview(self.moneySignImageView)
        self.moneySignImageView.leftToSuperview(offset: 6)
        self.moneySignImageView.centerYToSuperview()
        
        self.coinValueContainerView.addSubview(self.coinValueLabel)
        self.coinValueLabel.centerYToSuperview(offset: -1)
        self.coinValueLabel.leftToRight(of: self.moneySignImageView, offset: 2)
        
        self.addSubview(self.starRatingLabel)
        self.starRatingLabel.rightToSuperview(offset: -10)
        self.starRatingLabel.centerY(to: self.coinValueContainerView)
        
        self.addSubview(self.starImageView)
        self.starImageView.centerY(to: self.starRatingLabel)
        self.starImageView.rightToLeft(of: self.starRatingLabel, offset: -4)
        
        self.addSubview(self.nameLabel)
        self.nameLabel.leftToSuperview(offset: 12)
        self.nameLabel.rightToSuperview(offset: -12)
        self.nameLabel.bottomToSuperview(offset: -12)
        
        self.addSubview(self.productImageView)
        self.productImageView.centerInSuperview()
    }
    
    func configure(with product: KwiksSaleItem) {
        self.coinValueLabel.text = product.coinValue
        self.starRatingLabel.text = product.starRating
        self.nameLabel.text = product.productName
    }
}
