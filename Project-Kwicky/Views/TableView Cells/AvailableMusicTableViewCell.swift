//
//  AvailableMusicTableViewCell.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/26/23.
//

import UIKit

final class AvailableMusicTableViewCell: UITableViewCell {
    static let identifier = "AvailableMusicTableViewCell"
    var playMusicCallback: () -> () = {}
    var showVideosCallback: () -> () = {}
    
    private let songArtworkContainerView: UIView = {
        let view = UIView()
        let size: CGFloat = 40
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(hexString: "#202020")
        view.height(size)
        view.width(size)
        view.layer.cornerRadius = size / 2
        return view
    }()
    
    private let songImageView: UIImageView = {
        let imageView = UIImageView()
        let size: CGFloat = 40
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = size / 2
        imageView.height(size)
        imageView.width(size)
        return imageView
    }()
    
    let viewVideosContainingSongButton: UIButton = {
        let button = UIButton(type: .custom)
        let size: CGFloat = 30
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor(hexString: "#787878")
        button.height(size)
        button.width(size)
        button.layer.cornerRadius = size / 2
        button.setImage(UIImage(named: "ViewVideosIcon"), for: .normal)
        return button
    }()
    
    let playSongButton: UIButton = {
        let button = UIButton(type: .custom)
        let size: CGFloat = 30
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.kwiksGreen.withAlphaComponent(0.80)
        button.height(size)
        button.width(size)
        button.layer.cornerRadius = size / 2
        button.setImage(UIImage(named: "PlayMusicIcon"), for: .normal)
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
        label.textColor = UIColor.white
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
    
    private let seperatorOneView: UIView = {
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
    
    private let seperatorTwoView: UIView = {
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
    
    private let numberOfVideosFeaturingSong: UILabel = {
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
        
        self.playSongButton.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
        self.viewVideosContainingSongButton.addTarget(self, action: #selector(didTapView), for: .touchUpInside)
    }
    
    private func layoutUI() {
        self.addSubview(self.songArtworkContainerView)
        self.songArtworkContainerView.leftToSuperview()
        self.songArtworkContainerView.centerYToSuperview()
        
        self.addSubview(self.viewVideosContainingSongButton)
        self.viewVideosContainingSongButton.rightToSuperview()
        self.viewVideosContainingSongButton.centerYToSuperview()
        
        self.addSubview(self.playSongButton)
        self.playSongButton.rightToLeft(of: self.viewVideosContainingSongButton, offset: -10)
        self.playSongButton.centerYToSuperview()
        
        self.addSubview(self.songTitleLabel)
        self.songTitleLabel.leftToRight(of: self.songArtworkContainerView, offset: 10)
        self.songTitleLabel.rightToLeft(of: self.playSongButton, offset: -10)
        self.songTitleLabel.top(to: self.songArtworkContainerView, offset: 1)

        self.addSubview(self.artistNameLabel)
        self.artistNameLabel.left(to: self.songTitleLabel)
        self.artistNameLabel.bottom(to: self.songArtworkContainerView, offset: -4)

        self.addSubview(self.seperatorOneView)
        self.seperatorOneView.leftToRight(of: self.artistNameLabel, offset: 6)
        self.seperatorOneView.centerY(to: self.artistNameLabel, offset: 1)

        self.addSubview(self.durationLabel)
        self.durationLabel.leftToRight(of: self.seperatorOneView, offset: 6)
        self.durationLabel.centerY(to: self.artistNameLabel)

        self.addSubview(self.seperatorTwoView)
        self.seperatorTwoView.leftToRight(of: self.durationLabel, offset: 6)
        self.seperatorTwoView.centerY(to: self.artistNameLabel, offset: 1)

        self.addSubview(self.numberOfVideosFeaturingSong)
        self.numberOfVideosFeaturingSong.leftToRight(of: self.seperatorTwoView, offset: 6)
        self.numberOfVideosFeaturingSong.centerY(to: self.artistNameLabel)
        self.numberOfVideosFeaturingSong.rightToLeft(of: self.playSongButton, offset: -10, relation: .equalOrLess)
    }
    
    func configure(with music: AvailableMusic) {
        self.songTitleLabel.text = music.songTitle ?? "Searching..."
        self.durationLabel.text = music.duration ?? "01:00"
        self.numberOfVideosFeaturingSong.text = "\(music.numberOfVideosFeaturingSong ?? "0") Videos"
        
        guard let artistName = music.artistName else {
            //Artist Name Unavailable
            self.artistNameLabel.text = "Artist"
            return
        }
        
        self.artistNameLabel.text = "\(artistName.prefix(12))"
    }
    
    @objc func didTapPlay() {
        playMusicCallback()
    }

    @objc func didTapView() {
        showVideosCallback()
    }
}
