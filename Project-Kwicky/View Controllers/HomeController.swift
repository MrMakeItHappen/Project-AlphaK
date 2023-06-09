//
//  HomeController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/19/23.
//

import UIKit

enum FeedType: String, CaseIterable {
    case forYou
    case friends
    case popular
    case live
}

final class HomeController: UIViewController {
    private let forYouExampleVideos: [KwiksVideo] = KwiksVideo.forYouExampleVideos
    private let followingExampleVideos: [KwiksVideo] = KwiksVideo.friendsExampleVideos
    private let popularExampleVideos: [KwiksVideo] = KwiksVideo.popularExampleVideos
    private let liveExampleVideos: [KwiksVideo] = KwiksVideo.liveExampleVideos
    
    private var feedType: FeedType = .forYou
    
    private let tabBarExtension: UIView = {
        let view = UIView(frame: .zero)
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor(red: 0.090, green: 0.090, blue: 0.090, alpha: 1)
        view.height(6)
        return view
    }()
    
    private let placeholderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        
        let image = UIImage(named: "HomePlaceholder")
        imageView.image = image
        return imageView
    }()
    
    private let mainVideoGradientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        
        let image = UIImage(named: "HomePageGradientBackground")
        imageView.image = image
        return imageView
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
    
    private lazy var forYouCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 165, height: 231)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ForYouCollectionViewCell.self, forCellWithReuseIdentifier: ForYouCollectionViewCell.identifier)
        collectionView.height(272)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        
        return collectionView
    }()
    
    private let seperatorLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .black
        view.height(1.5)
        return view
    }()
    
    private let forYouLabel: UILabel = {
        let label = UILabel()
        label.text = "For You"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 15)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksGreen
        return label
    }()
    
    private let forYouLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .kwiksGreen
        view.height(1.5)
        return view
    }()
    
    private let hiddenForYouButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        label.text = "Friends"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 15)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let followingLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .kwiksGreen
        view.height(1.5)
        view.alpha = 0
        return view
    }()
    
    private let hiddenFollowingButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let popularLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 15)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let popularLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .kwiksGreen
        view.height(1.5)
        view.alpha = 0
        return view
    }()
    
    private let hiddenPopularButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let liveLabel: UILabel = {
        let label = UILabel()
        label.text = "Live"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 15)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let liveLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .kwiksGreen
        view.height(1.5)
        view.alpha = 0
        return view
    }()
    
    private let hiddenLiveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let viewsIconImageView: UIImageView = {
        let imageView = UIImageView()
        let imageSize: CGFloat = 22
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.height(imageSize)
        imageView.width(imageSize)
        imageView.layer.masksToBounds = true
        
        let image = UIImage(named: "ViewCountIcon")?.withTintColor(UIColor(hexString: "#DDDDFF", alpha: 1))
        imageView.image = image
        return imageView
    }()
    
    private let viewCountLabel: UILabel = {
        let label = UILabel()
        label.text = "44 B"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 13)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let uploadTimeIconImageView: UIImageView = {
        let imageView = UIImageView()
        let imageSize: CGFloat = 22
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.height(imageSize)
        imageView.width(imageSize)
        imageView.layer.masksToBounds = true
        
        let image = UIImage(named: "UploadIcon")?.withTintColor(UIColor(hexString: "#DDDDFF", alpha: 1))
        imageView.image = image
        return imageView
    }()
    
    private let uploadTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "7 Min Ago"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 13)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let mainVideoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Taylor is Back! New songs, new tour....new man?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 18)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let mainVideoPlayButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        button.height(85)
        button.width(85)
        button.setImage(UIImage(named: "KwiksWhitePlayButton"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Layout UI
extension HomeController {
    private func layoutUI() {
        self.view.addSubview(self.placeholderImageView)
        self.placeholderImageView.edgesToSuperview(usingSafeArea: false)
        
        self.view.addSubview(self.mainVideoGradientImageView)
        self.mainVideoGradientImageView.edgesToSuperview()
        
        self.view.addSubview(self.tabBarExtension)
        self.tabBarExtension.bottomToSuperview(usingSafeArea: true)
        self.tabBarExtension.leftToSuperview()
        self.tabBarExtension.rightToSuperview()
        
        self.view.addSubview(self.userProfileImageView)
        self.userProfileImageView.topToSuperview(offset: 20, usingSafeArea: true)
        self.userProfileImageView.rightToSuperview(offset: -20)
        
        self.view.addSubview(self.profileButton)
        self.profileButton.top(to: self.userProfileImageView)
        self.profileButton.left(to: self.userProfileImageView)
        self.profileButton.right(to: self.userProfileImageView)
        self.profileButton.bottom(to: self.userProfileImageView)
        
        self.view.addSubview(self.forYouCollectionView)
        self.forYouCollectionView.bottomToSuperview(usingSafeArea: true)
        self.forYouCollectionView.leftToSuperview(offset: 20)
        self.forYouCollectionView.rightToSuperview()
        
        self.view.addSubview(self.seperatorLineView)
        self.seperatorLineView.leftToSuperview(offset: 26)
        self.seperatorLineView.rightToSuperview(offset: -24)
        self.seperatorLineView.bottomToTop(of: self.forYouCollectionView)
        
        self.view.addSubview(self.forYouLabel)
        self.forYouLabel.left(to: self.seperatorLineView)
        self.forYouLabel.bottomToTop(of: self.seperatorLineView, offset: -15)
        
        self.view.addSubview(self.forYouLineView)
        self.forYouLineView.left(to: self.forYouLabel)
        self.forYouLineView.right(to: self.forYouLabel)
        self.forYouLineView.top(to: self.seperatorLineView)
        self.forYouLineView.bottom(to: self.seperatorLineView)
        
        self.view.addSubview(self.hiddenForYouButton)
        self.hiddenForYouButton.top(to: self.forYouLabel, offset: -2)
        self.hiddenForYouButton.left(to: self.forYouLabel, offset: -2)
        self.hiddenForYouButton.bottom(to: self.seperatorLineView, offset: 2)
        self.hiddenForYouButton.right(to: self.forYouLabel, offset: 2)
        
        self.view.addSubview(self.followingLabel)
        self.followingLabel.centerY(to: self.forYouLabel)
        self.followingLabel.leftToRight(of: self.forYouLabel, offset: 15)
        
        self.view.addSubview(self.followingLineView)
        self.followingLineView.left(to: self.followingLabel)
        self.followingLineView.right(to: self.followingLabel)
        self.followingLineView.top(to: self.seperatorLineView)
        self.followingLineView.bottom(to: self.seperatorLineView)
        
        self.view.addSubview(self.hiddenFollowingButton)
        self.hiddenFollowingButton.top(to: self.followingLabel, offset: -2)
        self.hiddenFollowingButton.left(to: self.followingLabel, offset: -2)
        self.hiddenFollowingButton.bottom(to: self.seperatorLineView, offset: 2)
        self.hiddenFollowingButton.right(to: self.followingLabel, offset: 2)
        
        self.view.addSubview(self.popularLabel)
        self.popularLabel.centerY(to: self.forYouLabel)
        self.popularLabel.leftToRight(of: self.followingLabel, offset: 15)
        
        self.view.addSubview(self.popularLineView)
        self.popularLineView.left(to: self.popularLabel)
        self.popularLineView.right(to: self.popularLabel)
        self.popularLineView.top(to: self.seperatorLineView)
        self.popularLineView.bottom(to: self.seperatorLineView)
        
        self.view.addSubview(self.hiddenPopularButton)
        self.hiddenPopularButton.top(to: self.popularLabel, offset: -2)
        self.hiddenPopularButton.left(to: self.popularLabel, offset: -2)
        self.hiddenPopularButton.bottom(to: self.seperatorLineView, offset: 2)
        self.hiddenPopularButton.right(to: self.popularLabel, offset: 2)
        
        self.view.addSubview(self.liveLabel)
        self.liveLabel.centerY(to: self.forYouLabel)
        self.liveLabel.leftToRight(of: self.popularLabel, offset: 15)
        
        self.view.addSubview(self.liveLineView)
        self.liveLineView.left(to: self.liveLabel)
        self.liveLineView.right(to: self.liveLabel)
        self.liveLineView.top(to: self.seperatorLineView)
        self.liveLineView.bottom(to: self.seperatorLineView)
        
        self.view.addSubview(self.hiddenLiveButton)
        self.hiddenLiveButton.top(to: self.liveLabel, offset: -2)
        self.hiddenLiveButton.left(to: self.liveLabel, offset: -2)
        self.hiddenLiveButton.bottom(to: self.seperatorLineView, offset: 2)
        self.hiddenLiveButton.right(to: self.liveLabel, offset: 2)
        
        self.view.addSubview(self.viewsIconImageView)
        self.viewsIconImageView.left(to: self.seperatorLineView)
        self.viewsIconImageView.bottomToTop(of: self.forYouLabel, offset: -30)
        
        self.view.addSubview(self.viewCountLabel)
        self.viewCountLabel.leftToRight(of: self.viewsIconImageView, offset: 10)
        self.viewCountLabel.centerY(to: self.viewsIconImageView)
        
        self.view.addSubview(self.uploadTimeIconImageView)
        self.uploadTimeIconImageView.leftToRight(of: self.viewCountLabel, offset: 20)
        self.uploadTimeIconImageView.centerY(to: self.viewsIconImageView)
        
        self.view.addSubview(self.uploadTimeLabel)
        self.uploadTimeLabel.leftToRight(of: self.uploadTimeIconImageView, offset: 10)
        self.uploadTimeLabel.centerY(to: self.uploadTimeIconImageView)
        
        self.view.addSubview(self.mainVideoTitleLabel)
        self.mainVideoTitleLabel.bottomToTop(of: self.viewsIconImageView, offset: -13)
        self.mainVideoTitleLabel.left(to: seperatorLineView)
        self.mainVideoTitleLabel.right(to: self.userProfileImageView)
        
        self.view.addSubview(self.mainVideoPlayButton)
        self.mainVideoPlayButton.left(to: self.seperatorLineView)
        self.mainVideoPlayButton.bottomToTop(of: self.mainVideoTitleLabel, offset: -10)
    }
}
//MARK: - Helpers
extension HomeController {
    private func configure() {
        self.view.backgroundColor = .white
        self.tabBarController?.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
        
        self.profileButton.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        self.mainVideoPlayButton.addTarget(self, action: #selector(didTapMainVideoPlay), for: .touchUpInside)
        
        self.hiddenForYouButton.addTarget(self, action: #selector(didTapForYou), for: .touchUpInside)
        self.hiddenFollowingButton.addTarget(self, action: #selector(didTapFriends), for: .touchUpInside)
        self.hiddenPopularButton.addTarget(self, action: #selector(didTapPopular), for: .touchUpInside)
        self.hiddenLiveButton.addTarget(self, action: #selector(didTapLive), for: .touchUpInside)
    }
}
//MARK: - @objc
extension HomeController {
    @objc func didTapProfile() {
        let profileVC = ProfileController()
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @objc func didTapEarnedAmount() {
        print(#function)
    }
    
    @objc func didTapMainVideoPlay() {
        print(#function)
    }
    
    @objc func didTapForYou() {
        UIView.animate(withDuration: 0.50, delay: 0, options: .curveEaseInOut) {
            self.forYouLabel.textColor = .kwiksGreen
            self.forYouLineView.alpha = 1
            
            self.followingLabel.textColor = .white
            self.followingLineView.alpha = 0
            
            self.popularLabel.textColor = .white
            self.popularLineView.alpha = 0
            
            self.liveLabel.textColor = .white
            self.liveLineView.alpha = 0
        }
        
        self.feedType = .forYou
        self.forYouCollectionView.reloadData()
        self.forYouCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
    }
    
    @objc func didTapFriends() {
        UIView.animate(withDuration: 0.50, delay: 0, options: .curveEaseInOut) {
            self.followingLabel.textColor = .kwiksGreen
            self.followingLineView.alpha = 1
            
            self.forYouLabel.textColor = .white
            self.forYouLineView.alpha = 0
            
            self.popularLabel.textColor = .white
            self.popularLineView.alpha = 0
            
            self.liveLabel.textColor = .white
            self.liveLineView.alpha = 0
        }
        
        self.feedType = .friends
        self.forYouCollectionView.reloadData()
        self.forYouCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
    }
    
    @objc func didTapPopular() {
        UIView.animate(withDuration: 0.50, delay: 0, options: .curveEaseInOut) {
            self.popularLabel.textColor = .kwiksGreen
            self.popularLineView.alpha = 1
            
            self.followingLabel.textColor = .white
            self.followingLineView.alpha = 0
            
            self.forYouLabel.textColor = .white
            self.forYouLineView.alpha = 0
            
            self.liveLabel.textColor = .white
            self.liveLineView.alpha = 0
        }
        
        self.feedType = .popular
        self.forYouCollectionView.reloadData()
        self.forYouCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
    }
    
    @objc func didTapLive() {
        
        UIView.animate(withDuration: 0.50, delay: 0, options: .curveEaseInOut) {
            self.liveLabel.textColor = .kwiksGreen
            self.liveLineView.alpha = 1
            
            self.followingLabel.textColor = .white
            self.followingLineView.alpha = 0
            
            self.popularLabel.textColor = .white
            self.popularLineView.alpha = 0
            
            self.forYouLabel.textColor = .white
            self.forYouLineView.alpha = 0
        }
        
        self.feedType = .live
        self.forYouCollectionView.reloadData()
        self.forYouCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
    }
}
//MARK: - CollectionView DataSource & Delegate
extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.feedType {
        case .forYou:
            return self.forYouExampleVideos.count
            
        case .friends:
            return self.followingExampleVideos.count
            
        case .popular:
            return self.popularExampleVideos.count
            
        case .live:
            return self.liveExampleVideos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForYouCollectionViewCell.identifier, for: indexPath) as! ForYouCollectionViewCell
        
        switch self.feedType {
            
        case .forYou:
            let video = self.forYouExampleVideos[indexPath.item]
            cell.configure(with: video)
            
        case .friends:
            let video = self.followingExampleVideos[indexPath.item]
            cell.configure(with: video)
            
        case .popular:
            let video = self.popularExampleVideos[indexPath.item]
            cell.configure(with: video)
            
        case .live:
            let video = self.liveExampleVideos[indexPath.item]
            cell.configureLive(with: video)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoPlayerVC = KwiksVideoPlayerController()
        videoPlayerVC.modalPresentationStyle = .overCurrentContext
        
        switch self.feedType {
            
        case .forYou:
            let forYouVideo = self.forYouExampleVideos[indexPath.item]
            videoPlayerVC.kwiksVideo = forYouVideo
            
        case .friends:
            let friendVideo = self.followingExampleVideos[indexPath.item]
            videoPlayerVC.kwiksVideo = friendVideo
            
        case .popular:
            let popularVideo = self.popularExampleVideos[indexPath.item]
            videoPlayerVC.kwiksVideo = popularVideo
            
        case .live:
            let liveVideo = self.liveExampleVideos[indexPath.item]
            let goLiveVC = GoLiveVideoController()
            
            goLiveVC.modalPresentationStyle = .fullScreen
            goLiveVC.currentLiveVideo = liveVideo
            
            self.present(goLiveVC, animated: true)
            return
        }
        
        self.present(videoPlayerVC, animated: true)
    }
}
