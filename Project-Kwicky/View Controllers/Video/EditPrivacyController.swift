//
//  EditPrivacyController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/23/23.
//

import UIKit

final class EditPrivacyController: UIViewController {
    private let selectedImage = UIImage(named: "SelectedIcon")
    private let deselectedImage = UIImage(named: "DeSelectedIcon")
    private var privacyType: PrivacyType = .everyone //TODO: Make this a global variable
    
    private lazy var customBackButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.kwiksTextBlack
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        button.height(23)
        button.width(33)
        button.setImage(UIImage(named: "KwiksBackArrow"), for: .normal)
        return button
    }()
    
    private let privacyLabel: UILabel = {
        let label = UILabel()
        label.text = "Edit Privacy"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Who can see your post?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let publicIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.layer.masksToBounds = true
        imageView.height(40)
        imageView.width(40)
        
        let image = UIImage(named: "PublicPrivacyIcon")
        imageView.image = image
        return imageView
    }()
    
    private let publicLabel: UILabel = {
        let label = UILabel()
        label.text = "Public"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let publicSelectionImageView: UIImageView = {
        let imageView = UIImageView()
        let size: CGFloat = 24
        let image = UIImage(named: "SelectedIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = size / 2
        imageView.height(size)
        imageView.width(size)
        imageView.image = image
        return imageView
    }()
    
    private let publicButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let friendsIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.layer.masksToBounds = true
        imageView.height(40)
        imageView.width(40)
        
        let image = UIImage(named: "FriendsPrivacyIcon")
        imageView.image = image
        return imageView
    }()
    
    private let friendsLabel: UILabel = {
        let label = UILabel()
        label.text = "Friends"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let friendsSelectionImageView: UIImageView = {
        let imageView = UIImageView()
        let size: CGFloat = 24
        let image = UIImage(named: "DeSelectedIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = size / 2
        imageView.height(size)
        imageView.width(size)
        imageView.image = image
        return imageView
    }()
    
    private let friendsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let onlyMeIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.layer.masksToBounds = true
        imageView.height(40)
        imageView.width(40)
        
        let image = UIImage(named: "OnlyMePrivacyIcon")
        imageView.image = image
        return imageView
    }()
    
    private let onlyMeLabel: UILabel = {
        let label = UILabel()
        label.text = "Only Me"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let onlyMeSelectionImageView: UIImageView = {
        let imageView = UIImageView()
        let size: CGFloat = 24
        let image = UIImage(named: "DeSelectedIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = size / 2
        imageView.height(size)
        imageView.width(size)
        imageView.image = image
        return imageView
    }()
    
    private let onlyMeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .segoeUISemiBold(size: 15)
        
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .capsule
        configuration.attributedTitle = AttributedString("Save", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapSave()
        }))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.backgroundColor = .kwiksGreen
        button.tintColor = .kwiksTextBlack
        button.height(50)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Configure Controller
extension EditPrivacyController {
    private func configure() {
        self.view.backgroundColor = .white
        
        self.publicButton.addTarget(self, action: #selector(didTapPublic), for: .touchUpInside)
        self.friendsButton.addTarget(self, action: #selector(didTapFriends), for: .touchUpInside)
        self.onlyMeButton.addTarget(self, action: #selector(didTapOnlyMe), for: .touchUpInside)
    }
}

//MARK: - Layout UI
extension EditPrivacyController {
    private func layoutUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.privacyLabel)
        self.privacyLabel.centerY(to: self.customBackButton, offset: -2)
        self.privacyLabel.leftToRight(of: self.customBackButton, offset: 18)
        
        self.view.addSubview(self.headerLabel)
        self.headerLabel.topToBottom(of: self.privacyLabel, offset: 40)
        self.headerLabel.leftToSuperview(offset: 30)
        self.headerLabel.rightToSuperview(offset: -30)
        
        self.view.addSubview(self.publicIconImageView)
        self.publicIconImageView.leftToSuperview(offset: 32)
        self.publicIconImageView.topToBottom(of: self.headerLabel, offset: 38)
        
        self.view.addSubview(self.publicLabel)
        self.publicLabel.centerY(to: self.publicIconImageView)
        self.publicLabel.leftToRight(of: self.publicIconImageView, offset: 10)
        
        self.view.addSubview(self.publicSelectionImageView)
        self.publicSelectionImageView.centerY(to: self.publicIconImageView)
        self.publicSelectionImageView.rightToSuperview(offset: -40)
        
        self.view.addSubview(self.publicButton)
        self.publicButton.left(to: self.publicIconImageView)
        self.publicButton.right(to: self.publicSelectionImageView)
        self.publicButton.top(to: self.publicIconImageView)
        self.publicButton.bottom(to: self.publicIconImageView)
        
        self.view.addSubview(self.friendsIconImageView)
        self.friendsIconImageView.topToBottom(of: self.publicIconImageView, offset: 40)
        self.friendsIconImageView.left(to: self.publicIconImageView)
        
        self.view.addSubview(self.friendsLabel)
        self.friendsLabel.centerY(to: self.friendsIconImageView)
        self.friendsLabel.leftToRight(of: self.friendsIconImageView, offset: 10)
        
        self.view.addSubview(self.friendsSelectionImageView)
        self.friendsSelectionImageView.centerY(to: self.friendsIconImageView)
        self.friendsSelectionImageView.rightToSuperview(offset: -40)
        
        self.view.addSubview(self.friendsButton)
        self.friendsButton.left(to: self.friendsIconImageView)
        self.friendsButton.right(to: self.friendsSelectionImageView)
        self.friendsButton.top(to: self.friendsIconImageView)
        self.friendsButton.bottom(to: self.friendsIconImageView)
        
        self.view.addSubview(self.onlyMeIconImageView)
        self.onlyMeIconImageView.topToBottom(of: self.friendsIconImageView, offset: 40)
        self.onlyMeIconImageView.left(to: self.publicIconImageView)
        
        self.view.addSubview(self.onlyMeLabel)
        self.onlyMeLabel.centerY(to: self.onlyMeIconImageView)
        self.onlyMeLabel.leftToRight(of: self.onlyMeIconImageView, offset: 10)
        
        self.view.addSubview(self.onlyMeSelectionImageView)
        self.onlyMeSelectionImageView.centerY(to: self.onlyMeIconImageView)
        self.onlyMeSelectionImageView.rightToSuperview(offset: -40)
        
        self.view.addSubview(self.onlyMeButton)
        self.onlyMeButton.left(to: self.onlyMeIconImageView)
        self.onlyMeButton.right(to: self.onlyMeSelectionImageView)
        self.onlyMeButton.top(to: self.onlyMeIconImageView)
        self.onlyMeButton.bottom(to: self.onlyMeIconImageView)
        
        self.view.addSubview(self.saveButton)
        self.saveButton.topToBottom(of: self.onlyMeLabel, offset: 80)
        self.saveButton.leftToSuperview(offset: 30)
        self.saveButton.rightToSuperview(offset: -30)
    }
}

//MARK: - Helpers
extension EditPrivacyController {
    
}

//MARK: - @objc
extension EditPrivacyController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapPublic() {
        self.publicSelectionImageView.image = self.selectedImage
        self.friendsSelectionImageView.image = self.deselectedImage
        self.onlyMeSelectionImageView.image = self.deselectedImage
        
        self.privacyType = .everyone
    }
    
    @objc func didTapFriends() {
        self.friendsSelectionImageView.image = self.selectedImage
        self.publicSelectionImageView.image = self.deselectedImage
        self.onlyMeSelectionImageView.image = self.deselectedImage
        
        self.privacyType = .friends
    }
    
    @objc func didTapOnlyMe() {
        self.onlyMeSelectionImageView.image = self.selectedImage
        self.publicSelectionImageView.image = self.deselectedImage
        self.friendsSelectionImageView.image = self.deselectedImage
        
        self.privacyType = .onlyMe
    }
    
    @objc func didTapSave() {
        print(#function)
        self.navigationController?.popViewController(animated: true)
        //TODO: Maybe save to global variable here
    }
}
