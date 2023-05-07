//
//  RequestDataDownloadController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 5/7/23.
//

import UIKit

final class RequestDataDownloadController: UIViewController {
    private let selectedImage = UIImage(named: "Checkmark")
    var downloadType: DownloadType = .none
    
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
        label.text = "Request Your Data"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    private let requestContainer = UIView.createSettingsContainer()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Request"
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
        label.text = "Includes username and other details"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#848484")
        return label
    }()
    
    private let profileButton: UIButton = {
        let button = UIButton(type: .custom)
        let size: CGFloat = 24
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.white
        button.height(size)
        button.width(size)
        button.layer.cornerRadius = size / 2
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.kwiksTextBlack.cgColor
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
        label.text = "Includes your videos and all activites"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#848484")
        return label
    }()
    
    private let activityButton: UIButton = {
        let button = UIButton(type: .custom)
        let size: CGFloat = 24
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.white
        button.height(size)
        button.width(size)
        button.layer.cornerRadius = size / 2
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.kwiksTextBlack.cgColor
        return button
    }()
    
    private let noteLabel: UILabel = {
        let label = UILabel()
        label.text = "Your request may take some time. Once the data is ready, we will notifiy you."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 14)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#848484")
        return label
    }()
    
    private let requestButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.kwiksGreen
        button.setTitle("Request Data", for: .normal)
        button.titleLabel?.font = .segoeUISemiBold(size: 18)
        button.layer.cornerRadius = 25
        button.height(50)
        return button
    }()
    
    private let downloadContainer = UIView.createSettingsContainer()
    private let downloadTitleLabel = UILabel.createSettingsTitleLabel(with: "Download Data")
    private let downloadChevron = UIImageView.createChevron()
    private lazy var hiddenDownloadButton = UIButton.createHiddenButton(with: #selector(didTapDownloadData), for: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Configure Controller
extension RequestDataDownloadController {
    private func configure() {
        self.view.backgroundColor = .white
        self.profileButton.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        self.activityButton.addTarget(self, action: #selector(didTapActivity), for: .touchUpInside)
        self.requestButton.addTarget(self, action: #selector(didTapRequest), for: .touchUpInside)
    }
}

//MARK: - Layout UI
extension RequestDataDownloadController {
    private func layoutUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerY(to: self.customBackButton)
        self.titleLabel.centerXToSuperview()
        
        self.view.addSubview(self.requestContainer)
        self.requestContainer.topToBottom(of: self.customBackButton, offset: 35)
        self.requestContainer.leftToSuperview(offset: 6)
        self.requestContainer.rightToSuperview(offset: -6)
        
        self.requestContainer.addSubview(self.headerLabel)
        self.headerLabel.topToSuperview(offset: 25)
        self.headerLabel.leftToSuperview(offset: 15)
        
        self.requestContainer.addSubview(self.profileImageView)
        self.profileImageView.topToBottom(of: self.headerLabel, offset: 30)
        self.profileImageView.leftToSuperview(offset: 20)
        
        self.requestContainer.addSubview(self.profileButton)
        self.profileButton.rightToSuperview(offset: -30)
        self.profileButton.centerY(to: self.profileImageView)
        
        self.requestContainer.addSubview(self.profileTitleLabel)
        self.profileTitleLabel.top(to: self.profileImageView, offset: -1)
        self.profileTitleLabel.leftToRight(of: self.profileImageView, offset: 10)
        
        self.requestContainer.addSubview(self.profileSubLabel)
        self.profileSubLabel.bottom(to: self.profileImageView, offset: 1)
        self.profileSubLabel.leftToRight(of: self.profileImageView, offset: 12)
        self.profileSubLabel.rightToLeft(of: self.profileButton, offset: -10)
        
        self.requestContainer.addSubview(self.activityImageView)
        self.activityImageView.topToBottom(of: self.profileImageView, offset: 30)
        self.activityImageView.left(to: self.profileImageView)
        
        self.requestContainer.addSubview(self.activityButton)
        self.activityButton.right(to: self.profileButton)
        self.activityButton.centerY(to: self.activityImageView)
        
        self.requestContainer.addSubview(self.activityTitleLabel)
        self.activityTitleLabel.top(to: self.activityImageView, offset: -1)
        self.activityTitleLabel.leftToRight(of: self.activityImageView, offset: 10)
        
        self.requestContainer.addSubview(self.activitySubLabel)
        self.activitySubLabel.bottom(to: self.activityImageView, offset: 1)
        self.activitySubLabel.leftToRight(of: self.activityImageView, offset: 12)
        self.activitySubLabel.rightToLeft(of: self.activityButton, offset: -10)
        
        self.requestContainer.addSubview(self.noteLabel)
        self.noteLabel.topToBottom(of: self.activitySubLabel, offset: 34)
        self.noteLabel.leftToSuperview(offset: 52)
        self.noteLabel.rightToSuperview(offset: -52)
        
        self.requestContainer.addSubview(self.requestButton)
        self.requestButton.topToBottom(of: self.noteLabel, offset: 15)
        self.requestButton.leftToSuperview(offset: 30)
        self.requestButton.rightToSuperview(offset: -30)
        
        self.requestContainer.bottom(to: self.requestButton, offset: 20)
        
        self.view.addSubview(self.downloadContainer)
        self.downloadContainer.topToBottom(of: self.requestContainer, offset: 20)
        self.downloadContainer.left(to: self.requestContainer)
        self.downloadContainer.right(to: self.requestContainer)
        
        self.downloadContainer.addSubview(self.downloadTitleLabel)
        self.downloadTitleLabel.topToSuperview(offset: 20)
        self.downloadTitleLabel.leftToSuperview(offset: 15)
        
        self.downloadContainer.addSubview(self.downloadChevron)
        self.downloadChevron.rightToSuperview(offset: -26)
        self.downloadChevron.centerY(to: self.downloadTitleLabel)
        
        self.downloadContainer.addSubview(self.hiddenDownloadButton)
        self.hiddenDownloadButton.edgesToSuperview()
        
        self.downloadContainer.bottom(to: self.downloadTitleLabel, offset: 20)
    }
}

//MARK: - @objc
extension RequestDataDownloadController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapProfile() {
        self.downloadType = .profile
        
        self.profileButton.backgroundColor = UIColor(hexString: "#69BD06")
        self.profileButton.layer.borderColor = UIColor(hexString: "#69BD06").cgColor
        self.profileButton.setImage(self.selectedImage, for: .normal)
    }
    
    @objc func didTapActivity() {
        self.downloadType = .activity
        
        self.activityButton.backgroundColor = UIColor(hexString: "#69BD06")
        self.activityButton.layer.borderColor = UIColor(hexString: "#69BD06").cgColor
        self.activityButton.setImage(self.selectedImage, for: .normal)
    }
    
    @objc func didTapRequest() {
        print(#function)
    }
    
    @objc func didTapDownloadData() {
        let downloadDataVC = DownloadYourDataController()
        self.navigationController?.pushViewController(downloadDataVC, animated: true)
    }
}
