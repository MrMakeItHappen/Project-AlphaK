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
    
    private let viewCountContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(hexString: "#8C8687", alpha: 0.80)
        view.layer.cornerRadius = 6
        view.height(20)
        view.width(50)
        return view
    }()
    
    private let viewCountIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.height(9)
        imageView.width(9)
        
        let image = UIImage(named: "ViewersIcon")
        imageView.image = image
        return imageView
    }()
    
    private let viewCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 10)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
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
        
        guard let videoViewCount = item.viewers else {
            self.viewCountLabel.text = "🔥🔥🔥"
            return
        }
        self.viewCountLabel.text = "\(videoViewCount)"
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
        
        self.addSubview(self.viewCountContainerView)
        self.viewCountContainerView.topToSuperview(offset: 8)
        self.viewCountContainerView.rightToSuperview(offset: -9)
        
        self.viewCountContainerView.addSubview(self.viewCountIconImageView)
        self.viewCountIconImageView.leftToSuperview(offset: 7)
        self.viewCountIconImageView.centerYToSuperview()
        
        self.viewCountContainerView.addSubview(self.viewCountLabel)
        self.viewCountLabel.centerYToSuperview()
        self.viewCountLabel.leftToRight(of: self.viewCountIconImageView, offset: 4)
        self.viewCountLabel.rightToSuperview(offset: -7)
    }
}
