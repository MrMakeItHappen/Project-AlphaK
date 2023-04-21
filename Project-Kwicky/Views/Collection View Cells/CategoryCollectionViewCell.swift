//
//  CategoryCollectionViewCell.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/19/23.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    private var isHeightCalculated: Bool = false
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .segoeUIRegular(size: 16)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .center
        label.textColor = .kwiksTextBlack
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hexString: "#F6F6F6")
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        self.layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        self.addSubview(self.categoryLabel)
        self.categoryLabel.leftToSuperview(offset: 10)
        self.categoryLabel.rightToSuperview(offset: -10)
        self.categoryLabel.topToSuperview(offset: 10)
        self.categoryLabel.bottomToSuperview(offset: -10)
    }
    
    func configure(with title: String) {
        self.categoryLabel.text = title
    }
}
