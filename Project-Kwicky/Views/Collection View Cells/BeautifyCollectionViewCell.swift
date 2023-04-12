//
//  BeautifyCollectionViewCell.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/9/23.
//

import UIKit

final class BeautifyCollectionViewCell: UICollectionViewCell {
    static let identifier = "BeautifyCollectionViewCell"
    private var isChecked = false
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        let size: CGFloat = 50
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor(hexString: "#1A1A1A")
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = size / 2
        imageView.height(size)
        imageView.width(size)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 15)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        self.addSubview(self.iconImageView)
        self.iconImageView.centerXToSuperview()
        self.iconImageView.topToSuperview()
        
        self.addSubview(self.titleLabel)
        self.titleLabel.centerXToSuperview()
        self.titleLabel.bottomToSuperview()
    }
    
    func configure(with option: Effect) {
        let image = option.image?.withTintColor(.white, renderingMode: .alwaysTemplate)
        
        self.titleLabel.text = option.name
        self.iconImageView.image = image
    }
    
    func toggle() {
        self.isChecked = !self.isChecked
        
        if isChecked {
            
            
        } else {
            
        }
    }
}
