//
//  ForYouCollectionViewCell.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/2/23.
//

import UIKit

final class ForYouCollectionViewCell: UICollectionViewCell {
    static let identifier = "ForYouCollectionViewCell"
    
    private let gradientBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        let image = UIImage(named: "CellGradient")
        imageView.image = image
        return imageView
    }()
    
    private let uploadedByLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 10)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 13)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let videoPreviewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: KwiksVideo) {
        self.videoPreviewImageView.image = item.deleteLaterImage
        self.uploadedByLabel.text = item.uploadedFrom.userName
        self.titleLabel.text = item.title
    }
    
    private func layoutUI() {
        self.addSubview(self.videoPreviewImageView)
        self.videoPreviewImageView.edgesToSuperview()
        
        self.addSubview(self.gradientBackgroundImageView)
        self.gradientBackgroundImageView.edgesToSuperview()
        
        self.addSubview(self.uploadedByLabel)
        self.uploadedByLabel.leftToSuperview(offset: 14)
        self.uploadedByLabel.bottomToSuperview(offset: -10)
        
        self.addSubview(self.titleLabel)
        self.titleLabel.left(to: self.uploadedByLabel)
        self.titleLabel.bottomToTop(of: self.uploadedByLabel, offset: -2)
        self.titleLabel.rightToSuperview(offset: -14)
    }
}
#warning("Work here. Need to add view count to cell. Then other icons on Home Controller. Dueces")
