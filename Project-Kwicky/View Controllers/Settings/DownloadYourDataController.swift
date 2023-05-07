//
//  DownloadYourDataController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 5/7/23.
//

import UIKit

final class DownloadYourDataController: UIViewController {
    private lazy var customBackButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.black
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        button.height(23)
        button.width(33)
        button.setImage(UIImage(named: "KwiksBackArrow"), for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Download Your Data"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    private let downloadContainer = UIView.createSettingsContainer()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Download"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    private let profileImageView = UIImageView.createIconImageView(with: "PublicPrivacyIcon")
    
    private let profileTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your profile"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let profileSubLabel: UILabel = {
        let label = UILabel()
        label.text = "Requested on February 20, 2023"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#848484")
        return label
    }()
    
    private let downloadProfileBackgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.layer.masksToBounds = true
        imageView.height(32)
        imageView.width(81)
        
        let image = UIImage(named: "DownloadDataBackground")
        imageView.image = image
        return imageView
    }()
    
    private let downloadProfileButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Download", for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        button.titleLabel?.font = .segoeUISemiBold(size: 14)
        button.tintColor = .white
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        return button
    }()
    
    private let activityImageView = UIImageView.createIconImageView(with: "FriendsPrivacyIcon")
    
    private let activityTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your activity"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let activitySubLabel: UILabel = {
        let label = UILabel()
        label.text = "Requested on February 20, 2023"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#848484")
        return label
    }()
    
    private let downloadActivityBackgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.layer.masksToBounds = true
        imageView.height(32)
        imageView.width(81)
        
        let image = UIImage(named: "PendingDataBackground")
        imageView.image = image
        return imageView
    }()
    
    private let downloadActivityButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Pending", for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        button.titleLabel?.font = .segoeUISemiBold(size: 14)
        button.tintColor = .white
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Configure Controller
extension DownloadYourDataController {
    private func configure() {
        self.view.backgroundColor = .white
        self.downloadProfileButton.addTarget(self, action: #selector(didTapProfileDownload), for: .touchUpInside)
        self.downloadActivityButton.addTarget(self, action: #selector(didTapActivityDownload), for: .touchUpInside)
    }
}

//MARK: - Layout UI
extension DownloadYourDataController {
    private func layoutUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerY(to: self.customBackButton)
        self.titleLabel.centerXToSuperview()
        
        self.view.addSubview(self.downloadContainer)
        self.downloadContainer.topToBottom(of: self.customBackButton, offset: 35)
        self.downloadContainer.leftToSuperview(offset: 6)
        self.downloadContainer.rightToSuperview(offset: -6)
        
        self.downloadContainer.addSubview(self.headerLabel)
        self.headerLabel.topToSuperview(offset: 25)
        self.headerLabel.leftToSuperview(offset: 15)
        
        self.downloadContainer.addSubview(self.profileImageView)
        self.profileImageView.topToBottom(of: self.headerLabel, offset: 30)
        self.profileImageView.leftToSuperview(offset: 20)
        
        self.downloadContainer.addSubview(self.downloadProfileBackgroundView)
        self.downloadProfileBackgroundView.rightToSuperview(offset: -8)
        self.downloadProfileBackgroundView.centerY(to: self.profileImageView)
        
        self.downloadContainer.addSubview(self.downloadProfileButton)
        self.downloadProfileButton.top(to: self.downloadProfileBackgroundView)
        self.downloadProfileButton.bottom(to: self.downloadProfileBackgroundView)
        self.downloadProfileButton.left(to: self.downloadProfileBackgroundView)
        self.downloadProfileButton.right(to: self.downloadProfileBackgroundView)
        
        self.downloadContainer.addSubview(self.profileTitleLabel)
        self.profileTitleLabel.top(to: self.profileImageView, offset: -1)
        self.profileTitleLabel.leftToRight(of: self.profileImageView, offset: 10)
        
        self.downloadContainer.addSubview(self.profileSubLabel)
        self.profileSubLabel.bottom(to: self.profileImageView, offset: 1)
        self.profileSubLabel.leftToRight(of: self.profileImageView, offset: 12)
        self.profileSubLabel.rightToLeft(of: self.downloadProfileBackgroundView, offset: -10)
        
        self.downloadContainer.addSubview(self.activityImageView)
        self.activityImageView.topToBottom(of: self.profileImageView, offset: 30)
        self.activityImageView.left(to: self.profileImageView)
        
        self.downloadContainer.addSubview(self.downloadActivityBackgroundView)
        self.downloadActivityBackgroundView.right(to: self.downloadProfileBackgroundView)
        self.downloadActivityBackgroundView.centerY(to: self.activityImageView)
        
        self.downloadContainer.addSubview(self.downloadActivityButton)
        self.downloadActivityButton.top(to: self.downloadActivityBackgroundView)
        self.downloadActivityButton.bottom(to: self.downloadActivityBackgroundView)
        self.downloadActivityButton.left(to: self.downloadActivityBackgroundView)
        self.downloadActivityButton.right(to: self.downloadActivityBackgroundView)
        
        self.downloadContainer.addSubview(self.activityTitleLabel)
        self.activityTitleLabel.top(to: self.activityImageView, offset: -1)
        self.activityTitleLabel.leftToRight(of: self.activityImageView, offset: 10)
        
        self.downloadContainer.addSubview(self.activitySubLabel)
        self.activitySubLabel.bottom(to: self.activityImageView, offset: 1)
        self.activitySubLabel.leftToRight(of: self.activityImageView, offset: 12)
        self.activitySubLabel.rightToLeft(of: self.downloadActivityBackgroundView, offset: -10)
        
        self.downloadContainer.bottom(to: self.activitySubLabel, offset: 30)
    }
}

//MARK: - @objc
extension DownloadYourDataController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapProfileDownload() {
        print(#function)
    }
    
    @objc func didTapActivityDownload() {
        print(#function)
    }
}
