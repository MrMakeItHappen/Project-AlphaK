//
//  VisibilityPopUpController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/29/23.
//

import UIKit

final class VisibilityPopUpController: UIViewController {
    private let selectedImage = UIImage(named: "Checkmark")
    
    weak var homeController: PrivacyController!
    var visibility: PrivacyType = .everyone
    var entryPath: PrivacyPath = .posts
    
    private let contentContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 29
        view.height(314)
        return view
    }()
    
    private lazy var hiddenDismissButton = UIButton.createHiddenButton(with: #selector(tapToDismiss), for: self)
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.tintColor = UIColor.black
        button.setImage(UIImage(named: "CloseButton"), for: .normal)
        button.addTarget(self, action: #selector(tapToDismiss), for: .touchUpInside)
        button.width(16)
        button.height(16)
        return button
    }()
    
    private lazy var everyoneImageView = self.createIconImageView(with: "PublicPrivacyIcon")
    private lazy var everyoneTitleLabel = self.createTitleLabel(with: "Everyone")
    private lazy var everyoneSubLabel = self.createSubLabel(with: "Anyone on or off Kwiks")
    
    private lazy var everyoneButton: UIButton = {
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
        button.addTarget(self, action: #selector(didTapEveryone), for: .touchUpInside)
        return button
    }()
    
    private lazy var friendsImageView = self.createIconImageView(with: "FriendsPrivacyIcon")
    private lazy var friendsTitleLabel = self.createTitleLabel(with: "Friends")
    private lazy var friendsSubLabel = self.createSubLabel(with: "Your friends on Kwiks")
    
    private lazy var friendsButton: UIButton = {
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
        button.addTarget(self, action: #selector(didTapFriends), for: .touchUpInside)
        return button
    }()
    
    private lazy var onlyMeImageView = self.createIconImageView(with: "OnlyMePrivacyIcon")
    private lazy var onlyMeTitleLabel = self.createTitleLabel(with: "Only Me")
    private lazy var onlyMeSubLabel = self.createSubLabel(with: "Just you")
    
    private lazy var onlyMeButton: UIButton = {
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
        button.addTarget(self, action: #selector(didTapOnlyMe), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        UIView.animate(withDuration: 0.50) {
            self.view.backgroundColor = .black.withAlphaComponent(0.7)
        }
        
        switch self.entryPath {
            
        case .posts:
            self.headerLabel.text = "Who can see your post?"
            
        case .comments:
            self.headerLabel.text = "Who can see your comments?"
            
        case .mentions:
            self.headerLabel.text = "Who can see your mentions?"
            
        case .directMessages:
            self.headerLabel.text = "Who can see your DMs?"
            
            self.onlyMeImageView.isHidden = true
            self.onlyMeTitleLabel.isHidden = true
            self.onlyMeSubLabel.isHidden = true
            self.onlyMeButton.isHidden = true
        }
    }
}
//MARK: - Configure Controller
extension VisibilityPopUpController {
    private func configure() {
        self.view.backgroundColor = .clear
        
        switch self.visibility {
        case .everyone:
            self.didTapEveryone()
            
        case .friends:
            self.didTapFriends()
            
        case .onlyMe:
            self.didTapOnlyMe()
        }
    }
}

//MARK: - Layout UI
extension VisibilityPopUpController {
    private func layoutUI() {
        self.view.addSubview(self.contentContainerView)
        self.contentContainerView.leftToSuperview()
        self.contentContainerView.rightToSuperview()
        self.contentContainerView.bottomToSuperview()
        
        self.contentContainerView.addSubview(self.headerLabel)
        self.headerLabel.topToSuperview(offset: 30)
        self.headerLabel.leftToSuperview(offset: 30)
        
        self.contentContainerView.addSubview(self.closeButton)
        self.closeButton.rightToSuperview(offset: -30)
        self.closeButton.centerY(to: self.headerLabel)
        
        self.view.addSubview(self.hiddenDismissButton)
        self.hiddenDismissButton.topToSuperview()
        self.hiddenDismissButton.leftToSuperview()
        self.hiddenDismissButton.rightToSuperview()
        self.hiddenDismissButton.bottomToTop(of: self.contentContainerView)
        
        self.contentContainerView.addSubview(self.everyoneImageView)
        self.everyoneImageView.topToBottom(of: self.headerLabel, offset: 30)
        self.everyoneImageView.leftToSuperview(offset: 42)
        
        self.contentContainerView.addSubview(self.everyoneButton)
        self.everyoneButton.rightToSuperview(offset: -30)
        self.everyoneButton.centerY(to: self.everyoneImageView)
        
        self.contentContainerView.addSubview(self.everyoneTitleLabel)
        self.everyoneTitleLabel.top(to: self.everyoneImageView)
        self.everyoneTitleLabel.leftToRight(of: self.everyoneImageView, offset: 20)
        
        self.contentContainerView.addSubview(self.everyoneSubLabel)
        self.everyoneSubLabel.bottom(to: self.everyoneImageView)
        self.everyoneSubLabel.left(to: self.everyoneTitleLabel)
        
        self.contentContainerView.addSubview(self.friendsImageView)
        self.friendsImageView.topToBottom(of: self.everyoneImageView, offset: 30)
        self.friendsImageView.centerX(to: self.everyoneImageView)
        
        self.contentContainerView.addSubview(self.friendsButton)
        self.friendsButton.right(to: self.everyoneButton)
        self.friendsButton.centerY(to: self.friendsImageView)
        
        self.contentContainerView.addSubview(self.friendsTitleLabel)
        self.friendsTitleLabel.top(to: self.friendsImageView)
        self.friendsTitleLabel.leftToRight(of: self.friendsImageView, offset: 20)
        
        self.contentContainerView.addSubview(self.friendsSubLabel)
        self.friendsSubLabel.bottom(to: self.friendsImageView)
        self.friendsSubLabel.left(to: self.friendsTitleLabel)
        
        self.contentContainerView.addSubview(self.onlyMeImageView)
        self.onlyMeImageView.topToBottom(of: self.friendsImageView, offset: 30)
        self.onlyMeImageView.centerX(to: self.everyoneImageView)
        
        self.contentContainerView.addSubview(self.onlyMeButton)
        self.onlyMeButton.right(to: self.everyoneButton)
        self.onlyMeButton.centerY(to: self.onlyMeImageView)
        
        self.contentContainerView.addSubview(self.onlyMeTitleLabel)
        self.onlyMeTitleLabel.top(to: self.onlyMeImageView)
        self.onlyMeTitleLabel.leftToRight(of: self.onlyMeImageView, offset: 20)
        
        self.contentContainerView.addSubview(self.onlyMeSubLabel)
        self.onlyMeSubLabel.bottom(to: self.onlyMeImageView)
        self.onlyMeSubLabel.left(to: self.onlyMeTitleLabel)
    }
}

//MARK: - Helpers
extension VisibilityPopUpController {
    private func createIconImageView(with text: String) -> UIImageView {
        let imageView = UIImageView()
        let size: CGFloat = 40
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = size / 2
        
        let image = UIImage(named: text)
        imageView.image = image
        imageView.width(size)
        imageView.height(size)
        return imageView
    }
    
    private func createTitleLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 16)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }
    
    private func createSubLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#848484")
        return label
    }
}

//MARK: - @objc
extension VisibilityPopUpController {
    @objc func tapToDismiss() {
        
        //TODO: Send selection to backend here.
        switch self.entryPath {
        case .posts:
            self.homeController.postVisibility = self.visibility
            
        case .comments:
            self.homeController.commentVisibility = self.visibility
            
        case .mentions:
            self.homeController.mentionVisibility = self.visibility
            
        case .directMessages:
            self.homeController.diretMessageVisibility = self.visibility
        }
        
        self.dismiss(animated: true)
    }
    
    @objc func didTapEveryone() {
        self.visibility = .everyone
        
        self.everyoneButton.backgroundColor = UIColor(hexString: "#69BD06")
        self.everyoneButton.layer.borderColor = UIColor(hexString: "#69BD06").cgColor
        self.everyoneButton.setImage(self.selectedImage, for: .normal)
        
        self.friendsButton.backgroundColor = UIColor.white
        self.friendsButton.setImage(nil, for: .normal)
        self.friendsButton.layer.borderColor = UIColor.kwiksTextBlack.cgColor
        
        self.onlyMeButton.backgroundColor = UIColor.white
        self.onlyMeButton.setImage(nil, for: .normal)
        self.onlyMeButton.layer.borderColor = UIColor.kwiksTextBlack.cgColor
    }
    
    @objc func didTapFriends() {
        self.visibility = .friends
        
        self.friendsButton.backgroundColor = UIColor(hexString: "#69BD06")
        self.friendsButton.layer.borderColor = UIColor(hexString: "#69BD06").cgColor
        self.friendsButton.setImage(self.selectedImage, for: .normal)
        
        self.everyoneButton.backgroundColor = UIColor.white
        self.everyoneButton.setImage(nil, for: .normal)
        self.everyoneButton.layer.borderColor = UIColor.kwiksTextBlack.cgColor
        
        self.onlyMeButton.backgroundColor = UIColor.white
        self.onlyMeButton.setImage(nil, for: .normal)
        self.onlyMeButton.layer.borderColor = UIColor.kwiksTextBlack.cgColor
    }
    
    @objc func didTapOnlyMe() {
        self.visibility = .onlyMe
        
        self.onlyMeButton.backgroundColor = UIColor(hexString: "#69BD06")
        self.onlyMeButton.layer.borderColor = UIColor(hexString: "#69BD06").cgColor
        self.onlyMeButton.setImage(self.selectedImage, for: .normal)
        
        self.everyoneButton.backgroundColor = UIColor.white
        self.everyoneButton.setImage(nil, for: .normal)
        self.everyoneButton.layer.borderColor = UIColor.kwiksTextBlack.cgColor
        
        self.friendsButton.backgroundColor = UIColor.white
        self.friendsButton.setImage(nil, for: .normal)
        self.friendsButton.layer.borderColor = UIColor.kwiksTextBlack.cgColor
    }
}
