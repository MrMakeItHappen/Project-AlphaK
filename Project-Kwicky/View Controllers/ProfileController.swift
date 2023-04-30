//
//  ProfileController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/25/23.
//

import UIKit

//TODO: Make back button tappable area bigger

final class ProfileController: UIViewController {
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
    
    private let editLabel: UILabel = {
        let label = UILabel()
        label.text = "Edit Profile"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let headerBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(186)
        
        let image = UIImage(named: "Profile Header Background")
        imageView.image = image
        return imageView
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
    
    private lazy var facebookButton: UIButton = {
        let button = UIButton(type: .custom)
        let buttonSize: CGFloat = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = buttonSize / 2
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapFacebook), for: .touchUpInside)
        button.setImage(UIImage(named: "FacebookProfileIcon"), for: .normal)
        button.height(buttonSize)
        button.width(buttonSize)
        return button
    }()
    
    private lazy var snapchatButton: UIButton = {
        let button = UIButton(type: .custom)
        let buttonSize: CGFloat = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = buttonSize / 2
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapSnapchat), for: .touchUpInside)
        button.setImage(UIImage(named: "SnapchatProfileIcon"), for: .normal)
        button.height(buttonSize)
        button.width(buttonSize)
        return button
    }()
    
    private lazy var instagramButton: UIButton = {
        let button = UIButton(type: .custom)
        let buttonSize: CGFloat = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = buttonSize / 2
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapInstagram), for: .touchUpInside)
        button.setImage(UIImage(named: "InstagramProfileIcon"), for: .normal)
        button.height(buttonSize)
        button.width(buttonSize)
        return button
    }()
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        let imageSize: CGFloat = 144
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(imageSize)
        imageView.width(imageSize)
        imageView.layer.cornerRadius = imageSize / 2
        imageView.layer.borderColor = UIColor.kwiksGreen.cgColor
        imageView.layer.borderWidth = 2
        
        let image = UIImage(named: "FemalePlaceholder")
        imageView.image = image
        return imageView
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .custom)
        let buttonSize: CGFloat = 32
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = buttonSize / 2
        button.layer.masksToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.clipsToBounds = true
        button.backgroundColor = .kwiksGrey
        button.addTarget(self, action: #selector(didTapEdit), for: .touchUpInside)
        button.setImage(UIImage(named: "EditIcon"), for: .normal)
        button.height(buttonSize)
        button.width(buttonSize)
        return button
    }()
    
    //TODO: Pass in @username
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "@JulianneHo"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 25)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    //TODO: Pass in signup date
    private let memberLabel: UILabel = {
        let label = UILabel()
        label.text = "Member since November 2023"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1)
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.delaysContentTouches = false
        scrollView.clipsToBounds = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let scrollViewContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 0
        view.clipsToBounds = true
        return view
    }()
    
    //TODO: Pass in user name
    private lazy var nameHeaderLabel = self.createHeaderLabel(with: "Name")
    private lazy var nameLabel = self.createLabel(with: "Julianne Hough")
    private lazy var nameDividerView = self.createDividerView()
    
    private lazy var bioHeaderLabel = self.createHeaderLabel(with: "Bio")
    private lazy var bioLabel = self.createLabel(with: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation")
    private lazy var bioDividerView = self.createDividerView()
    
    private lazy var locationHeaderLabel = self.createHeaderLabel(with: "Location")
    private lazy var locationLabel = self.createLabel(with: "Toronto, ON")
    private lazy var locationDividerView = self.createDividerView()
    
    private lazy var languageHeaderLabel = self.createHeaderLabel(with: "Languages")
    private lazy var languageLabel = self.createLabel(with: "English, French")
    private lazy var languageDividerView = self.createDividerView()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Private Details"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 16)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.kwiksGreen
        return label
    }()
    
    private lazy var emailHeaderLabel = self.createHeaderLabel(with: "Email")
    private lazy var emailLabel = self.createLabel(with: "juleshough@gmail.com")
    private lazy var emailDividerView = self.createDividerView()
    
    private lazy var phoneHeaderLabel = self.createHeaderLabel(with: "Phone")
    private lazy var phoneLabel = self.createLabel(with: "(416) 123-4567")
    private lazy var phoneDividerView = self.createDividerView()
    
    private lazy var birthDateHeaderLabel = self.createHeaderLabel(with: "Birth Date")
    private lazy var birthDateLabel = self.createLabel(with: "1984-01-05")
    private lazy var birthDateDividerView = self.createDividerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutTopUI()
        self.layoutBottomUI()
    }

}
//MARK: - Configure View Controller
extension ProfileController {
    private func configure() {
        self.view.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.editLabel.isUserInteractionEnabled = true
        self.editLabel.addGestureRecognizer(tapGesture)
    }
}
//MARK: - Layout UI
extension ProfileController {
    private func layoutTopUI() {
        self.view.addSubview(self.headerBackgroundImageView)
        self.headerBackgroundImageView.topToSuperview()
        self.headerBackgroundImageView.leftToSuperview()
        self.headerBackgroundImageView.rightToSuperview()
        
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.editLabel)
        self.editLabel.centerY(to: self.customBackButton)
        self.editLabel.leftToRight(of: self.customBackButton, offset: 17)
        
        self.view.addSubview(self.settingsButton)
        self.settingsButton.rightToSuperview(offset: -40)
        self.settingsButton.centerY(to: self.customBackButton)
        
        self.view.addSubview(self.facebookButton)
        self.facebookButton.leftToSuperview(offset: 44)
        self.facebookButton.bottom(to: self.headerBackgroundImageView, offset: -22)
        
        self.view.addSubview(self.snapchatButton)
        self.snapchatButton.centerY(to: self.facebookButton)
        self.snapchatButton.leftToRight(of: self.facebookButton, offset: 15)
        
        self.view.addSubview(self.instagramButton)
        self.instagramButton.centerY(to: self.facebookButton)
        self.instagramButton.leftToRight(of: self.snapchatButton, offset: 15)
        
        self.view.addSubview(self.profileImageView)
        self.profileImageView.rightToSuperview(offset: -42)
        self.profileImageView.centerYToSuperview(self.headerBackgroundImageView.bottomAnchor)
        
        self.view.addSubview(self.editButton)
        self.editButton.right(to: self.profileImageView, offset: -8)
        self.editButton.bottom(to: self.profileImageView, offset: -2)
        
        self.view.addSubview(self.usernameLabel)
        self.usernameLabel.topToBottom(of: self.headerBackgroundImageView, offset: 10)
        self.usernameLabel.left(to: self.facebookButton)
        self.usernameLabel.rightToLeft(of: self.profileImageView, offset: -20)
        
        self.view.addSubview(self.memberLabel)
        self.memberLabel.topToBottom(of: self.usernameLabel, offset: 3)
        self.memberLabel.left(to: self.usernameLabel, offset: 2)
        self.memberLabel.right(to: self.usernameLabel)
    }
    
    private func layoutBottomUI() {
        self.view.addSubview(self.scrollView)
        self.scrollView.topToBottom(of: self.memberLabel, offset: 44)
        self.scrollView.leftToSuperview()
        self.scrollView.rightToSuperview()
        self.scrollView.bottomToSuperview()
        
        self.scrollView.addSubview(self.scrollViewContentView)
        self.scrollViewContentView.edgesToSuperview()
        self.scrollViewContentView.width(to: self.scrollView)
        
        self.scrollViewContentView.addSubview(self.nameHeaderLabel)
        self.nameHeaderLabel.topToSuperview()
        self.nameHeaderLabel.leftToSuperview(offset: 40)
        
        self.scrollViewContentView.addSubview(self.nameLabel)
        self.nameLabel.centerY(to: self.nameHeaderLabel)
        self.nameLabel.rightToSuperview(offset: -40)
        
        self.scrollViewContentView.addSubview(self.nameDividerView)
        self.nameDividerView.topToBottom(of: self.nameHeaderLabel, offset: 11)
        self.nameDividerView.left(to: self.nameHeaderLabel)
        self.nameDividerView.right(to: self.nameLabel)
        
        self.scrollViewContentView.addSubview(self.bioHeaderLabel)
        self.bioHeaderLabel.topToBottom(of: self.nameDividerView, offset: 20)
        self.bioHeaderLabel.left(to: self.nameHeaderLabel)
        
        self.scrollViewContentView.addSubview(self.bioLabel)
        self.bioLabel.topToBottom(of: self.bioHeaderLabel, offset: 10)
        self.bioLabel.left(to: self.nameHeaderLabel)
        self.bioLabel.right(to: self.nameLabel)
        
        self.scrollViewContentView.addSubview(self.bioDividerView)
        self.bioDividerView.topToBottom(of: self.bioLabel, offset: 11)
        self.bioDividerView.left(to: self.nameHeaderLabel)
        self.bioDividerView.right(to: self.nameLabel)
        
        self.scrollViewContentView.addSubview(self.locationHeaderLabel)
        self.locationHeaderLabel.topToBottom(of: self.bioDividerView, offset: 20)
        self.locationHeaderLabel.left(to: self.nameHeaderLabel)
        
        self.scrollViewContentView.addSubview(self.locationLabel)
        self.locationLabel.centerY(to: self.locationHeaderLabel)
        self.locationLabel.right(to: self.nameLabel)
        
        self.scrollViewContentView.addSubview(self.locationDividerView)
        self.locationDividerView.topToBottom(of: self.locationLabel, offset: 11)
        self.locationDividerView.left(to: self.nameHeaderLabel)
        self.locationDividerView.right(to: self.nameLabel)
        
        self.scrollViewContentView.addSubview(self.languageHeaderLabel)
        self.languageHeaderLabel.topToBottom(of: self.locationDividerView, offset: 20)
        self.languageHeaderLabel.left(to: self.nameHeaderLabel)
        
        self.scrollViewContentView.addSubview(self.languageLabel)
        self.languageLabel.centerY(to: self.languageHeaderLabel)
        self.languageLabel.right(to: self.nameLabel)
        
        self.scrollViewContentView.addSubview(self.languageDividerView)
        self.languageDividerView.topToBottom(of: self.languageLabel, offset: 11)
        self.languageDividerView.left(to: self.nameHeaderLabel)
        self.languageDividerView.right(to: self.nameLabel)
        
        self.scrollViewContentView.addSubview(self.detailsLabel)
        self.detailsLabel.topToBottom(of: self.languageDividerView, offset: 37)
        self.detailsLabel.left(to: self.nameHeaderLabel)
        
        self.scrollViewContentView.addSubview(self.emailHeaderLabel)
        self.emailHeaderLabel.topToBottom(of: self.detailsLabel, offset: 20)
        self.emailHeaderLabel.left(to: self.nameHeaderLabel)
        
        self.scrollViewContentView.addSubview(self.emailLabel)
        self.emailLabel.centerY(to: self.emailHeaderLabel)
        self.emailLabel.right(to: self.nameLabel)
        
        self.scrollViewContentView.addSubview(self.emailDividerView)
        self.emailDividerView.topToBottom(of: self.emailLabel, offset: 11)
        self.emailDividerView.left(to: self.nameHeaderLabel)
        self.emailDividerView.right(to: self.nameLabel)
        
        self.scrollViewContentView.addSubview(self.phoneHeaderLabel)
        self.phoneHeaderLabel.topToBottom(of: self.emailDividerView, offset: 20)
        self.phoneHeaderLabel.left(to: self.nameHeaderLabel)
        
        self.scrollViewContentView.addSubview(self.phoneLabel)
        self.phoneLabel.centerY(to: self.phoneHeaderLabel)
        self.phoneLabel.right(to: self.nameLabel)
        
        self.scrollViewContentView.addSubview(self.phoneDividerView)
        self.phoneDividerView.topToBottom(of: self.phoneLabel, offset: 11)
        self.phoneDividerView.left(to: self.nameHeaderLabel)
        self.phoneDividerView.right(to: self.nameLabel)
        
        self.scrollViewContentView.addSubview(self.birthDateHeaderLabel)
        self.birthDateHeaderLabel.topToBottom(of: self.phoneDividerView, offset: 20)
        self.birthDateHeaderLabel.left(to: self.nameHeaderLabel)
        
        self.scrollViewContentView.addSubview(self.birthDateLabel)
        self.birthDateLabel.centerY(to: self.birthDateHeaderLabel)
        self.birthDateLabel.right(to: self.nameLabel)
        
        self.scrollViewContentView.bottom(to: self.birthDateLabel, offset: 40)
    }
}
//MARK: - Helpers
extension ProfileController {
    private func createHeaderLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 16)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }
    
    private func createLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 16)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1)
        return label
    }
    
    private func createDividerView() -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        view.height(0.5)
        return view
    }
}
//MARK: - @objc
extension ProfileController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapEdit() {
        let imageVC = UploadImageController()
        imageVC.presentingController = self
        imageVC.modalPresentationStyle = .overFullScreen
        
        self.navigationController?.present(imageVC, animated: true)
    }
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapSettings() {
        let settingsVC = SettingsController()
        let navVC = UINavigationController(rootViewController: settingsVC)
        navVC.modalPresentationStyle = .popover
        navVC.isNavigationBarHidden = true
        
        self.navigationController?.present(navVC, animated: true)
    }
    
    @objc func didTapFacebook() {
        print(#function)
    }
    
    @objc func didTapSnapchat() {
        print(#function)
    }
    
    @objc func didTapInstagram() {
        print(#function)
    }
}
