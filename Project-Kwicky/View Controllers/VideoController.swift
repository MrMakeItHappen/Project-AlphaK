//
//  VideoController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/19/23.
//

import UIKit
//Temporary Settings Controller. Change later
final class VideoController: UIViewController {
    private let settingsItem: [SettingsItem] = SettingsItem.allItems
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 25
        
        let image = UIImage(named: "SettingsBackground")
        imageView.image = image
        return imageView
    }()
    
    private let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        let imageSize: CGFloat = 35
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
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Elizabeth Ely"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .custom)
        let buttonSize: CGFloat = 35
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = buttonSize / 2
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
        button.setImage(UIImage(named: "SettingsIcon"), for: .normal)
        button.height(buttonSize)
        button.width(buttonSize)
        return button
    }()
    
    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 41)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private let contentContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.barStyle = .default
        searchBar.placeholder = "Search"
        searchBar.isTranslucent = true
        searchBar.backgroundColor = .white
        searchBar.barTintColor = .white
        searchBar.backgroundImage = UIImage()
        searchBar.height(50)
        searchBar.layer.cornerRadius = 25
        return searchBar
    }()
    
    private let settingsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 360, height: 60)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(SettingsCollectionViewCell.self, forCellWithReuseIdentifier: SettingsCollectionViewCell.identifier)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Configure
extension VideoController {
    private func configure() {
        self.view.backgroundColor = .white
        self.settingsCollectionView.dataSource = self
        self.settingsCollectionView.delegate = self
    }
}
//MARK: - Layout UI
extension VideoController {
    private func layoutUI() {
        self.view.addSubview(self.backgroundImageView)
        self.backgroundImageView.topToSuperview(usingSafeArea: true)
        self.backgroundImageView.leftToSuperview()
        self.backgroundImageView.rightToSuperview()
        
        self.backgroundImageView.addSubview(self.userProfileImageView)
        self.userProfileImageView.topToSuperview(offset: 28)
        self.userProfileImageView.leftToSuperview(offset: 49)
        
        self.backgroundImageView.addSubview(self.userNameLabel)
        self.userNameLabel.centerY(to: self.userProfileImageView)
        self.userNameLabel.leftToRight(of: self.userProfileImageView, offset: 12)
        
        self.view.addSubview(self.settingsButton)
        self.settingsButton.centerY(to: self.userProfileImageView)
        self.settingsButton.rightToSuperview(offset: -49)
        
        self.backgroundImageView.addSubview(self.settingsLabel)
        self.settingsLabel.topToBottom(of: self.userProfileImageView, offset: 10)
        self.settingsLabel.left(to: self.userProfileImageView)
        
        self.view.addSubview(self.contentContainerView)
        self.contentContainerView.topToBottom(of: self.settingsLabel, offset: 28)
        self.contentContainerView.leftToSuperview()
        self.contentContainerView.rightToSuperview()
        self.contentContainerView.bottomToSuperview(usingSafeArea: false)
        
        self.contentContainerView.addSubview(self.searchBar)
        self.searchBar.topToSuperview(offset: 20)
        self.searchBar.leftToSuperview(offset: 25)
        self.searchBar.rightToSuperview(offset: -25)
        
        self.contentContainerView.addSubview(self.settingsCollectionView)
        self.settingsCollectionView.topToBottom(of: self.searchBar, offset: 6)
        self.settingsCollectionView.leftToSuperview(offset: 13)
        self.settingsCollectionView.rightToSuperview(offset: -13)
        self.settingsCollectionView.bottomToSuperview()
    }
}
//MARK: - @objc
extension VideoController {
    @objc func didTapSettings() {
        print(#function)
    }
}
//MARK: - CollectionView DataSource & Delegate
extension VideoController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.settingsItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsCollectionViewCell.identifier, for: indexPath) as! SettingsCollectionViewCell
        let item = self.settingsItem[indexPath.item]
        cell.configure(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            let followInviteVC = FollowInviteFriendsController()
            self.navigationController?.pushViewController(followInviteVC, animated: true)
            
        case 1:
            let notificationsVC = NotificationsController()
            self.navigationController?.pushViewController(notificationsVC, animated: true)
            
        case 2:
            print("Creator Tapped")
            
        case 3:
            print("Privacy Tapped")
            
        case 4:
            print("Supervision Tapped")
            
        case 5:
            print("Security Tapped")
            
        case 6:
            print("Payments Tapped")
            
        case 7:
            print("Ads Tapped")
            
        case 8:
            let accountVC = AccountController()
            self.navigationController?.pushViewController(accountVC, animated: true)
            
        case 9:
            print("Help Tapped")
            
        case 10:
            print("About Tapped")
            
        default:
            print("Something went wrong!")
        }
    }
}
