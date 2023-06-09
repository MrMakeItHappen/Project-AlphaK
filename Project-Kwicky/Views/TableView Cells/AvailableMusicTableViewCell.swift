//
//  AvailableMusicTableViewCell.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/26/23.
//

import UIKit

final class AvailableMusicTableViewCell: UITableViewCell {
    static let identifier = "AvailableMusicTableViewCell"
    
    private var isBookmarked = false
    var cellCallback: () -> () = {}
    var bookmarkCallback: () -> () = {}
    var trashCallback: () -> () = {}
    
    private let bookmarkIcon = UIImage(named: "BookmarkIcon")
    private let selectedBookmarkIcon = UIImage(named: "BookmarkSelectedIcon")
    
    private let songImageView: UIImageView = {
        let imageView = UIImageView()
        let size: CGFloat = 50
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = size / 2
        imageView.height(size)
        imageView.width(size)
        imageView.image = UIImage(named: "PlaceholderMusicIconV3")
        return imageView
    }()
    
    let nowPlayingImageView: UIImageView = {
        let imageView = UIImageView()
        let size: CGFloat = 30
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = size / 2
        imageView.height(size)
        imageView.width(size)
        imageView.image = UIImage(named: "NowPlayingMusicIcon")
        imageView.isHidden = true
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
    
    let trashcanButton: UIButton = {
        let button = UIButton(type: .custom)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.clear
        button.height(18)
        button.width(16)
        button.setImage(UIImage(named: "TrashcanIcon"), for: .normal)
        button.isHidden = true
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
    
    private let cellButton: UIButton = {
        let button = UIButton(type: .custom)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.clear
        return button
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
        self.trashcanButton.addTarget(self, action: #selector(didTapTrash), for: .touchUpInside)
        self.cellButton.addTarget(self, action: #selector(didTapCell), for: .touchUpInside)
    }
    
    private func layoutUI() {
        self.addSubview(self.songImageView)
        self.songImageView.leftToSuperview()
        self.songImageView.centerYToSuperview()
        
        self.addSubview(self.nowPlayingImageView)
        self.nowPlayingImageView.centerX(to: self.songImageView)
        self.nowPlayingImageView.centerY(to: self.songImageView)
        
        self.addSubview(self.bookmarkButton)
        self.bookmarkButton.rightToSuperview()
        self.bookmarkButton.centerYToSuperview()
        
        self.addSubview(self.trashcanButton)
        self.trashcanButton.rightToSuperview()
        self.trashcanButton.centerYToSuperview()
        
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
        
        self.addSubview(self.cellButton)
        self.cellButton.left(to: self.songTitleLabel)
        self.cellButton.topToSuperview()
        self.cellButton.rightToSuperview(offset: -30)
        self.cellButton.bottomToSuperview()
    }
    
    func configure(with music: Music) {
        self.songTitleLabel.text = music.songTitle ?? "Searching..."
        self.durationLabel.text = music.duration ?? "01:00"
        
        guard let artistName = music.artistName else {
            //Artist Name Unavailable
            self.artistNameLabel.text = "Artist"
            return
        }
        
        self.artistNameLabel.text = "\(artistName)"
    }

    func toggleBookmark() {
        self.isBookmarked = !self.isBookmarked
        
        if isBookmarked {
            self.bookmarkButton.setImage(self.selectedBookmarkIcon, for: .normal)
        } else {
            self.bookmarkButton.setImage(self.bookmarkIcon, for: .normal)
        }
    }
    
    func showTrashCan() {
        self.bookmarkButton.isHidden = true
        self.trashcanButton.isHidden = false
    }
    
    func hideTrashCan() {
        self.bookmarkButton.isHidden = false
        self.trashcanButton.isHidden = true
    }
    
    @objc func didTapBookmark() {
        bookmarkCallback()
    }
    
    @objc func didTapTrash() {
        trashCallback()
    }
    
    @objc func didTapCell() {
        cellCallback()
    }
}
