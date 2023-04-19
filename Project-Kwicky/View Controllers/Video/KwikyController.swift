//
//  KwikyController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/11/23.
//

import UIKit
import AVFoundation

final class KwikyController: UIViewController {
    var kwiksVideo: KwiksVideo!
    private var player: AVPlayer?
    private var playerDidFinishObserver: NSObjectProtocol?
    
    private lazy var customBackButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.black
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        button.height(16)
        button.width(16)
        button.setImage(UIImage(named: "LeftChervon"), for: .normal)
        return button
    }()
    
    private let tabBarExtension: UIView = {
        let view = UIView(frame: .zero)
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor(red: 0.090, green: 0.090, blue: 0.090, alpha: 1)
        view.height(6)
        return view
    }()
    
    private let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        let imageSize: CGFloat = 50
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.height(imageSize)
        imageView.width(imageSize)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize / 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1.5
        
        let image = UIImage(named: "FemalePlaceholder")
        imageView.image = image
        return imageView
    }()
    
    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let viewCountContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(hexString: "#8b8686", alpha: 1)
        view.layer.cornerRadius = 10
        view.height(25)
        view.width(60)
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
        imageView.height(11)
        imageView.width(11)
        
        let image = UIImage(named: "ViewersIcon")
        imageView.image = image
        return imageView
    }()
    
    private let viewCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let earnedAmountView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(hexString: "#8b8686", alpha: 1)
        view.layer.cornerRadius = 0
        view.layer.cornerRadius = 12
        view.height(25)
        view.width(80)
        return view
    }()
    
    private let moneySignImageView: UIImageView = {
        let imageView = UIImageView()
        let imageSize: CGFloat = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.height(imageSize)
        imageView.width(imageSize)
        imageView.layer.masksToBounds = true
        
        let image = UIImage(named: "KwiksMoneySymbol")
        imageView.image = image
        return imageView
    }()
    
    private let earnedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "999999"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let hiddenEarnedAmountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let statsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(hexString: "#8b8686", alpha: 1)
        view.layer.cornerRadius = 10
        view.height(25)
        view.width(70)
        return view
    }()
    
    private let statsIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.height(11)
        imageView.width(11)
        
        let image = UIImage(named: "StatsIcon")?.withTintColor(.white)
        imageView.image = image
        return imageView
    }()
    
    private let statsLabel: UILabel = {
        let label = UILabel()
        label.text = "Stats"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 15)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let hiddenStatsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.trackTintColor = .white
        progressView.trackTintColor = UIColor(hexString: "#8b8686", alpha: 1)
        progressView.progressTintColor = .kwiksGreen
        progressView.height(1)
        return progressView
    }()
    
    private let videoBackgroundMusicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 2
        imageView.height(33)
        imageView.width(33)
        
        let image = UIImage(named: "VideoSoundPlaceholderImage")
        imageView.image = image
        return imageView
    }()
    
    private let hiddenMusicButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let sendMoneyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.setImage(UIImage(named: "SendMoneyIcon"), for: .normal)
        button.width(33)
        button.height(33)
        return button
    }()
    
    private let shareVideoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(33)
        imageView.width(33)
        
        let image = UIImage(named: "ShareIcon")
        imageView.image = image
        return imageView
    }()
    
    private let hiddenShareButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let commentCountLabel: UILabel = {
        let label = UILabel()
        label.text = "999K"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 13)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let commentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(33)
        imageView.width(33)
        
        let image = UIImage(named: "CommentIcon")
        imageView.image = image
        return imageView
    }()
    
    private let hiddenCommentButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let likeCountLabel: UILabel = {
        let label = UILabel()
        label.text = "999M"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 13)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(33)
        imageView.width(33)
        
        let image = UIImage(named: "LikeIcon")
        imageView.image = image
        return imageView
    }()
    
    private let hiddenLikeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let currentMusicImageViewIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(14)
        imageView.width(14)
        
        let image = UIImage(named: "CurrentPlayingMusicIcon")
        imageView.image = image
        return imageView
    }()
    
    private let currentMusicLabel: UILabel = {
        let label = UILabel()
        label.text = "Let's Dance - Magic Mountain - music hip-hop low-fi relaxing"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 10)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.width(192)
        return label
    }()
    
    private let videoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Good morining every one #goodmorning"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 12)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "@Galactus44"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 18)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let followContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor.clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 12
        view.height(26)
        view.width(60)
        return view
    }()
    
    private let followLabel: UILabel = {
        let label = UILabel()
        label.text = "Follow"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 12)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let hiddenFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let uploadedByProfileImageView: UIImageView = {
        let imageView = UIImageView()
        let imageSize: CGFloat = 40
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.height(imageSize)
        imageView.width(imageSize)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize / 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1.5
        
        let image = UIImage(named: "MalePlaceholder")
        imageView.image = image
        return imageView
    }()
    
    private lazy var followButton: UIButton = {
        let button = UIButton(type: .custom)
        let size: CGFloat = 17
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(didTapFollow), for: .touchUpInside)
        button.height(size)
        button.width(size)
        button.layer.cornerRadius = size / 2
        button.setImage(UIImage(named: "FollowIcon"), for: .normal)
        return button
    }()
    
    private let verticalScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.bounces = false
        scrollView.backgroundColor = .systemCyan
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.configureVideo()
        self.layoutTopUI()
        self.layoutBottomUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.configure()
        self.configureVideo()
        self.layoutTopUI()
        self.layoutBottomUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.view.removeFromSuperview()
        self.player?.replaceCurrentItem(with: nil)
    }
}
//MARK: - Configure View Controller
extension KwikyController {
    private func configure() {
        self.view.backgroundColor = .white
        self.progressView.progress = 0.0
        
        self.profileButton.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        self.followButton.addTarget(self, action: #selector(didTapFollow), for: .touchUpInside)
        self.sendMoneyButton.addTarget(self, action: #selector(didTapSendMoney), for: .touchUpInside)
        
        self.hiddenEarnedAmountButton.addTarget(self, action: #selector(didTapEarnedAmount), for: .touchUpInside)
        self.hiddenStatsButton.addTarget(self, action: #selector(didTapStats), for: .touchUpInside)
        
        self.hiddenMusicButton.addTarget(self, action: #selector(didTapBackgroundMusic), for: .touchUpInside)
        self.hiddenShareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
        self.hiddenCommentButton.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        self.hiddenLikeButton.addTarget(self, action: #selector(didTapLike), for: .touchDown)
    }
}
//MARK: - Layout UI
extension KwikyController {
    private func layoutTopUI() {
        self.view.addSubview(self.tabBarExtension)
        self.tabBarExtension.bottomToSuperview(usingSafeArea: true)
        self.tabBarExtension.leftToSuperview()
        self.tabBarExtension.rightToSuperview()
        
        self.view.addSubview(self.userProfileImageView)
        self.userProfileImageView.topToSuperview(offset: 0, usingSafeArea: true)
        self.userProfileImageView.rightToSuperview(offset: -20)
        
        self.view.addSubview(self.profileButton)
        self.profileButton.top(to: self.userProfileImageView)
        self.profileButton.left(to: self.userProfileImageView)
        self.profileButton.right(to: self.userProfileImageView)
        self.profileButton.bottom(to: self.userProfileImageView)
        
        self.view.addSubview(self.customBackButton)
        self.customBackButton.centerY(to: self.userProfileImageView)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.earnedAmountView)
        self.earnedAmountView.centerY(to: self.userProfileImageView)
        self.earnedAmountView.leftToRight(of: self.customBackButton, offset: 10)
        
        self.earnedAmountView.addSubview(self.moneySignImageView)
        self.moneySignImageView.leftToSuperview(offset: 9)
        self.moneySignImageView.centerYToSuperview()
        
        self.earnedAmountView.addSubview(self.earnedAmountLabel)
        self.earnedAmountLabel.leftToRight(of: self.moneySignImageView, offset: 2)
        self.earnedAmountLabel.rightToSuperview(offset: -2)
        self.earnedAmountLabel.centerYToSuperview(offset: -1)
        
        self.view.addSubview(self.hiddenEarnedAmountButton)
        self.hiddenEarnedAmountButton.top(to: self.earnedAmountView, offset: -2)
        self.hiddenEarnedAmountButton.right(to: self.earnedAmountView, offset: 2)
        self.hiddenEarnedAmountButton.left(to: self.earnedAmountView, offset: -2)
        self.hiddenEarnedAmountButton.bottom(to: self.earnedAmountView, offset: 2)
        
        self.view.addSubview(self.statsContainerView)
        self.statsContainerView.centerY(to: self.userProfileImageView)
        self.statsContainerView.leftToRight(of: self.earnedAmountView, offset: 8)
        
        self.statsContainerView.addSubview(self.statsIconImageView)
        self.statsIconImageView.leftToSuperview(offset: 9)
        self.statsIconImageView.centerYToSuperview()
        
        self.statsContainerView.addSubview(self.statsLabel)
        self.statsLabel.centerYToSuperview(offset: -1)
        self.statsLabel.leftToRight(of: self.statsIconImageView, offset: 6)
        
        self.view.addSubview(self.hiddenStatsButton)
        self.hiddenStatsButton.top(to: self.statsContainerView, offset: -2)
        self.hiddenStatsButton.right(to: self.statsContainerView, offset: 2)
        self.hiddenStatsButton.left(to: self.statsContainerView, offset: -2)
        self.hiddenStatsButton.bottom(to: self.statsContainerView, offset: 2)
    }
    
    private func layoutBottomUI() {
        self.view.addSubview(self.progressView)
        self.progressView.bottom(to: self.tabBarExtension, offset: -20)
        self.progressView.leftToSuperview(offset: 30)
        self.progressView.rightToSuperview(offset: -30)
        
        self.view.addSubview(self.videoBackgroundMusicImageView)
        self.videoBackgroundMusicImageView.bottomToTop(of: self.progressView, offset: -25)
        self.videoBackgroundMusicImageView.rightToSuperview(offset: -36)
        
        self.view.addSubview(self.hiddenMusicButton)
        self.hiddenMusicButton.top(to: self.videoBackgroundMusicImageView, offset: -2)
        self.hiddenMusicButton.right(to: self.videoBackgroundMusicImageView, offset: 2)
        self.hiddenMusicButton.left(to: self.videoBackgroundMusicImageView, offset: -2)
        self.hiddenMusicButton.bottom(to: self.videoBackgroundMusicImageView, offset: 2)
        
        self.view.addSubview(self.sendMoneyButton)
        self.sendMoneyButton.rightToLeft(of: self.videoBackgroundMusicImageView, offset: -18)
        self.sendMoneyButton.centerY(to: self.videoBackgroundMusicImageView)
        
        self.view.addSubview(self.shareVideoImageView)
        self.shareVideoImageView.bottomToTop(of: self.videoBackgroundMusicImageView, offset: -30)
        self.shareVideoImageView.centerX(to: self.videoBackgroundMusicImageView)
        
        self.view.addSubview(self.hiddenShareButton)
        self.hiddenShareButton.top(to: self.shareVideoImageView, offset: -2)
        self.hiddenShareButton.right(to: self.shareVideoImageView, offset: 2)
        self.hiddenShareButton.left(to: self.shareVideoImageView, offset: -2)
        self.hiddenShareButton.bottom(to: self.shareVideoImageView, offset: 2)
        
        self.view.addSubview(self.commentCountLabel)
        self.commentCountLabel.bottomToTop(of: self.shareVideoImageView, offset: -30)
        self.commentCountLabel.centerX(to: self.videoBackgroundMusicImageView)
        
        self.view.addSubview(self.commentImageView)
        self.commentImageView.bottomToTop(of: self.commentCountLabel, offset: -8)
        self.commentImageView.centerX(to: self.videoBackgroundMusicImageView)
        
        self.view.addSubview(self.hiddenCommentButton)
        self.hiddenCommentButton.top(to: self.commentImageView, offset: -2)
        self.hiddenCommentButton.right(to: self.commentImageView, offset: 2)
        self.hiddenCommentButton.left(to: self.commentImageView, offset: -2)
        self.hiddenCommentButton.bottom(to: self.commentCountLabel, offset: 2)
        
        self.view.addSubview(self.likeCountLabel)
        self.likeCountLabel.bottomToTop(of: self.commentImageView, offset: -30)
        self.likeCountLabel.centerX(to: self.videoBackgroundMusicImageView)
        
        self.view.addSubview(self.likeImageView)
        self.likeImageView.bottomToTop(of: self.likeCountLabel, offset: -8)
        self.likeImageView.centerX(to: self.videoBackgroundMusicImageView)
        
        self.view.addSubview(self.hiddenLikeButton)
        self.hiddenLikeButton.top(to: self.likeImageView, offset: -2)
        self.hiddenLikeButton.right(to: self.likeImageView, offset: 2)
        self.hiddenLikeButton.left(to: self.likeImageView, offset: -2)
        self.hiddenLikeButton.bottom(to: self.likeCountLabel, offset: 2)
        
        self.view.addSubview(self.currentMusicImageViewIcon)
        self.currentMusicImageViewIcon.bottomToTop(of: self.progressView, offset: -23)
        self.currentMusicImageViewIcon.leftToSuperview(offset: 31)
        
        self.view.addSubview(self.currentMusicLabel)
        self.currentMusicLabel.leftToRight(of: self.currentMusicImageViewIcon, offset: 6)
        self.currentMusicLabel.centerY(to: self.currentMusicImageViewIcon)
        
        self.view.addSubview(self.videoTitleLabel)
        self.videoTitleLabel.bottomToTop(of: self.currentMusicImageViewIcon, offset: -15)
        self.videoTitleLabel.left(to: self.currentMusicImageViewIcon)
        self.videoTitleLabel.right(to: self.currentMusicLabel)
        
        self.view.addSubview(self.usernameLabel)
        self.usernameLabel.bottomToTop(of: self.videoTitleLabel, offset: -13)
        self.usernameLabel.left(to: self.currentMusicImageViewIcon)
        
        self.view.addSubview(self.uploadedByProfileImageView)
        self.uploadedByProfileImageView.bottomToTop(of: self.usernameLabel, offset: -13)
        self.uploadedByProfileImageView.left(to: self.currentMusicImageViewIcon)
        
        self.view.addSubview(self.followButton)
        self.followButton.right(to: self.uploadedByProfileImageView, offset: 4)
        self.followButton.bottom(to: self.uploadedByProfileImageView, offset: 4)
    }
}
//MARK: - Helpers
extension KwikyController {
    private func configureVideo() {
        guard let path = Bundle.main.path(forResource: "KwiksTestVideo", ofType: "mp4") else {
            return
        }
        
        let url = URL(filePath: path)
        self.player = AVPlayer(url: url)
        
        guard let player = self.player else {
            print("Error Loading Video Player!")
            return
        }
        
        player.volume = 1.0
        
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        
        self.view.layer.addSublayer(playerLayer)
        player.play()
        
        let interval = CMTime(value: 1, timescale: 1000)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { progressTime in
            
            guard let duration = player.currentItem?.duration else {
                return
            }
            
            let durationInSeconds = CMTimeGetSeconds(duration)
            let progressTimeInSeconds = CMTimeGetSeconds(progressTime)
            
            let totalProgress = Float(progressTimeInSeconds)
            let totalDuraiton = Float(durationInSeconds)
            
            let progress = totalProgress / totalDuraiton
            self.progressView.progress = progress
        })
        
        self.playerDidFinishObserver = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main, using: { [weak player] _ in
            
            player?.seek(to: .zero)
            player?.play()
            
        })
    }
}
//MARK: - @objc
extension KwikyController {
    @objc func didTapBack() {
        self.dismiss(animated: true)
    }
    
    @objc func didTapProfile() {
        let profileVC = ProfileController()
        let navVC = UINavigationController(rootViewController: profileVC)
        navVC.modalPresentationStyle = .popover
        navVC.isNavigationBarHidden = true
        
        self.present(navVC, animated: true)
    }
    
    //TODO: Add delegate calls to notify Home Controller
    @objc func didTapEarnedAmount() {
        print(#function)
    }
    
    @objc func didTapStats() {
        print(#function)
    }
    
    @objc func didTapBackgroundMusic() {
        print(#function)
    }
    
    @objc func didTapShare() {
        print(#function)
    }
    
    @objc func didTapComment() {
        print(#function)
    }
    
    @objc func didTapLike() {
        print(#function)
    }
    
    @objc func didTapFollow() {
        print(#function)
    }
    
    @objc func didTapSendMoney() {
        print(#function)
    }
}
