//
//  AvailableMusicTableViewCell.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/26/23.
//

import UIKit

final class AvailableMusicTableViewCell: UITableViewCell {
    static let identifier = "AvailableMusicTableViewCell"
    var bookmarkCallback: () -> () = {}
    
    private let songImageView: UIImageView = {
        let imageView = UIImageView()
        let size: CGFloat = 50
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.kwiksGreen.withAlphaComponent(0.80)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = size / 2
        imageView.height(size)
        imageView.width(size)
        return imageView
    }()
    
    private let centerLine: UIView = {
        let view = UIView(frame: .zero)
        view.isUserInteractionEnabled = false
        view.height(1)
        view.backgroundColor = .clear
        return view
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .custom)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.clear
        button.height(18)
        button.width(16)
        button.setImage(UIImage(named: "BookmarkIcon"), for: .normal)
        return button
    }()
    
    private let songTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#454545")
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 12)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor.musicTextColor
        return label
    }()
    
    private let seperatorView: UIView = {
        let view = UIView()
        let size: CGFloat = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor.musicTextColor
        view.height(size)
        view.width(size)
        view.layer.cornerRadius = size / 2
        return view
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 12)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor.musicTextColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
        self.layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.contentView.isUserInteractionEnabled = false
        self.selectionStyle = .none
        self.clipsToBounds = true
        self.backgroundColor = .clear
        
        self.bookmarkButton.addTarget(self, action: #selector(didTapBookmark), for: .touchUpInside)
    }
    
    private func layoutUI() {
        self.addSubview(self.songImageView)
        self.songImageView.leftToSuperview()
        self.songImageView.centerYToSuperview()
        
        self.addSubview(self.bookmarkButton)
        self.bookmarkButton.rightToSuperview()
        self.bookmarkButton.centerYToSuperview()
        
        self.addSubview(self.centerLine)
        self.centerLine.leftToRight(of: self.songImageView, offset: 12)
        self.centerLine.rightToLeft(of: self.bookmarkButton, offset: -12)
        self.centerLine.centerY(to: self.songImageView)
        
        self.addSubview(self.songTitleLabel)
        self.songTitleLabel.left(to: self.centerLine)
        self.songTitleLabel.bottomToTop(of: self.centerLine)

        self.addSubview(self.artistNameLabel)
        self.artistNameLabel.left(to: self.centerLine)
        self.artistNameLabel.topToBottom(of: self.centerLine)
        
        self.addSubview(self.seperatorView)
        self.seperatorView.leftToRight(of: self.artistNameLabel, offset: 6)
        self.seperatorView.centerY(to: self.artistNameLabel, offset: 1)

        self.addSubview(self.durationLabel)
        self.durationLabel.leftToRight(of: self.seperatorView, offset: 6)
        self.durationLabel.centerY(to: self.artistNameLabel)
    }
    
    func configure(with music: AvailableMusic) {
        self.songTitleLabel.text = music.songTitle ?? "Searching..."
        self.durationLabel.text = music.duration ?? "01:00"
        
        guard let artistName = music.artistName else {
            //Artist Name Unavailable
            self.artistNameLabel.text = "Artist"
            return
        }
        
        self.artistNameLabel.text = "\(artistName)"
    }
    
    @objc func didTapBookmark() {
        bookmarkCallback()
    }
}
