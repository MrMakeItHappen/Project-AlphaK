//
//  FeaturedMusicCollectionViewCell.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/17/23.
//

import UIKit

final class FeaturedMusicCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedMusicCollectionViewCell"
    
    private let songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.height(22)
        return view
    }()
    
    private let songTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.font = .segoeUISemiBold(size: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.clipsToBounds = true
        label.textAlignment = .center
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        self.layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .clear
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
    private func layoutUI() {
        self.addSubview(self.songImageView)
        self.songImageView.edgesToSuperview()
        
        self.addSubview(self.containerView)
        self.containerView.leftToSuperview(offset: 34)
        self.containerView.rightToSuperview(offset: -17)
        self.containerView.bottomToSuperview(offset: -7)
        
        self.containerView.addSubview(self.songTitle)
        self.songTitle.centerXToSuperview()
        self.songTitle.centerYToSuperview(offset: -1)
    }
    
    func configure(with music: Music) {
        self.songTitle.text = music.songTitle
        self.songImageView.image = music.tempImage
    }
}
