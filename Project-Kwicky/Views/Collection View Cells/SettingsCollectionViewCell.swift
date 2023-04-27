//
//  SettingsCollectionViewCell.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/19/23.
//

import UIKit

final class SettingsCollectionViewCell: UICollectionViewCell {
    static let identifier = "SettingsCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .segoeUIRegular(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = .kwiksTextBlack
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.height(14)
        imageView.width(14)
        return imageView
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.height(12)
        imageView.width(12)
        
        let image = UIImage(named: "GreyNextIcon")
        imageView.image = image
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        self.addSubview(self.iconImageView)
        self.iconImageView.centerYToSuperview()
        self.iconImageView.leftToSuperview(offset: 20)
        
        self.addSubview(self.chevronImageView)
        self.chevronImageView.centerYToSuperview()
        self.chevronImageView.rightToSuperview(offset: -20)
        
        self.addSubview(self.titleLabel)
        self.titleLabel.centerYToSuperview()
        self.titleLabel.leftToRight(of: self.iconImageView, offset: 25)
    }
    
    func configure(with item: SettingsItem) {
        self.titleLabel.text = item.title
        self.iconImageView.image = item.icon
    }
}
