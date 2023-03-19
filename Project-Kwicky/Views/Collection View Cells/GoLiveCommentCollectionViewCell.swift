//
//  GoLiveCommentCollectionViewCell.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/18/23.
//

import UIKit

final class GoLiveCommentCollectionViewCell: UICollectionViewCell {
    static let identifier = "GoLiveCommentCollectionViewCell"
    
    private let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        let size: CGFloat = 32
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.height(size)
        imageView.width(size)
        imageView.layer.cornerRadius = size / 2
        
        let image = UIImage(named: "FemalePlaceholder")
        imageView.image = image
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "LazySunday69420"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#5F5F5F", alpha: 1)
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "Testing spacing and other things. Will this truncate or will it go to the next line. Stay tuned."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 12)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black.withAlphaComponent(0.80)
        self.addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        self.addSubview(self.userProfileImageView)
        self.userProfileImageView.topToSuperview(offset: 8)
        self.userProfileImageView.leftToSuperview(offset: 8)
        
        self.addSubview(self.userNameLabel)
        self.userNameLabel.topToSuperview(offset: 0)
        self.userNameLabel.leftToRight(of: self.userProfileImageView, offset: 13)
        
        self.addSubview(self.commentLabel)
        self.commentLabel.topToBottom(of: self.userNameLabel)
        self.commentLabel.left(to: self.userNameLabel)
        self.commentLabel.rightToSuperview(offset: -13)
    }
    
    func configure(with comment: String) {
        
    }
}
