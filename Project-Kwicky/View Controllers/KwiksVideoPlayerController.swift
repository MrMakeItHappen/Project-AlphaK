//
//  KwiksVideoPlayerController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/8/23.
//

import UIKit
import AVFoundation

final class KwiksVideoPlayerController: UIViewController {
    var kwiksVideo: KwiksVideo!
    var player: AVPlayer?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.configureVideo()
        self.layoutUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.view.removeFromSuperview()
        self.player?.replaceCurrentItem(with: nil)
    }
}
//MARK: - Configure View Controller
extension KwiksVideoPlayerController {
    private func configure() {
        self.view.backgroundColor = .white
        self.progressView.progress = 0.0
        
        self.profileButton.addTarget(self, action: #selector(didTapProfile), for: .touchDown)
        self.hiddenEarnedAmountButton.addTarget(self, action: #selector(didTapEarnedAmount), for: .touchDown)
        self.hiddenStatsButton.addTarget(self, action: #selector(didTapStats), for: .touchDown)
        
        guard let viewers = self.kwiksVideo.viewers else {
            self.viewCountLabel.text = "🔥🔥🔥"
            return
        }
        
        self.viewCountLabel.text = "\(viewers)"
    }
}
//MARK: - Layout UI
extension KwiksVideoPlayerController {
    private func layoutUI() {
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
        
        self.view.addSubview(self.viewCountContainerView)
        self.viewCountContainerView.centerY(to: self.userProfileImageView)
        self.viewCountContainerView.leftToRight(of: self.customBackButton, offset: 10)
        
        self.viewCountContainerView.addSubview(self.viewCountIconImageView)
        self.viewCountIconImageView.leftToSuperview(offset: 7)
        self.viewCountIconImageView.centerYToSuperview()
        
        self.viewCountContainerView.addSubview(self.viewCountLabel)
        self.viewCountLabel.centerYToSuperview(offset: -1)
        self.viewCountLabel.leftToRight(of: self.viewCountIconImageView, offset: 4)
        self.viewCountLabel.rightToSuperview(offset: -7)
        
        self.view.addSubview(self.earnedAmountView)
        self.earnedAmountView.centerY(to: self.userProfileImageView)
        self.earnedAmountView.leftToRight(of: self.viewCountContainerView, offset: 8)
        
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
        
        self.view.addSubview(self.progressView)
        self.progressView.bottom(to: self.tabBarExtension, offset: -20)
        self.progressView.leftToSuperview(offset: 30)
        self.progressView.rightToSuperview(offset: -30)
    }
}
//MARK: - Helpers
extension KwiksVideoPlayerController {
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
extension KwiksVideoPlayerController {
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
}
