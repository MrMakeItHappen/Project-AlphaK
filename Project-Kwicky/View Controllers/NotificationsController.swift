//
//  NotificationsController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/23/23.
//

import UIKit

final class NotificationsController: UIViewController {
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
        label.text = "Notifications"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
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
    
    private let inAppBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        view.layer.cornerRadius = 9
        view.height(78)
        return view
    }()
    
    private let inAppLabel = UILabel.createSettingsLabel(with: "In-app notifications")
    private let inAppChevron = UIImageView.createChevron()
    private lazy var inAppHiddenButton = self.createHiddenButton(with: #selector(didTapInApp))
    
    private let likeLabel = UILabel.createSettingsLabel(with: "Likes")
    private lazy var likeToggle = self.createToggleButton(with: #selector(didTapLikes))
    
    private let commentsLabel = UILabel.createSettingsLabel(with: "Comments")
    private lazy var commentToggle = self.createToggleButton(with: #selector(didTapComments))
    
    private let newFollowersLabel = UILabel.createSettingsLabel(with: "New Followers")
    private lazy var followerToggle = self.createToggleButton(with: #selector(didTapNewFollowers))
    
    private let mentionsLabel = UILabel.createSettingsLabel(with: "Mentions and tags")
    private lazy var mentionsToggle = self.createToggleButton(with: #selector(didTapMentions))
    
    private let profileViewsLabel = UILabel.createSettingsLabel(with: "Profile views")
    private lazy var profileToggle = self.createToggleButton(with: #selector(didTapProfile))
    
    private let repostLabel = UILabel.createSettingsLabel(with: "Reposts")
    private lazy var repostToggle = self.createToggleButton(with: #selector(didTapRepost))
    
    private let directMessageLabel = UILabel.createSettingsLabel(with: "Direct messages")
    private lazy var directToggle = self.createToggleButton(with: #selector(didTapDirectMessages))
    
    private let previewLabel = UILabel.createSettingsLabel(with: "Direct Messages Preview")
    private lazy var previewToggle = self.createToggleButton(with: #selector(didTapDirectPreview))
    
    private let interactionLabel: UILabel = {
        let label = UILabel()
        label.text = "Interactions"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 15)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private let interactionContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        view.layer.cornerRadius = 9
        view.height(388)
        return view
    }()
    
    private let messagesLabel: UILabel = {
        let label = UILabel()
        label.text = "Messages"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 15)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private let messagesContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        view.layer.cornerRadius = 9
        view.height(122)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.layoutInAppUI()
        self.layoutInteractionUI()
        self.layoutMessageUI()
    }
}
//MARK: - Layout UI
extension NotificationsController {
    private func layoutInAppUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerY(to: self.customBackButton)
        self.titleLabel.centerXToSuperview()
        
        self.view.addSubview(self.scrollView)
        self.scrollView.topToBottom(of: self.titleLabel, offset: 25)
        self.scrollView.leftToSuperview()
        self.scrollView.rightToSuperview()
        self.scrollView.bottomToSuperview()
        
        self.scrollView.addSubview(self.scrollViewContentView)
        self.scrollViewContentView.edgesToSuperview()
        self.scrollViewContentView.width(to: self.scrollView)
        
        self.scrollViewContentView.addSubview(self.inAppBackgroundView)
        self.inAppBackgroundView.topToSuperview()
        self.inAppBackgroundView.leftToSuperview(offset: 6)
        self.inAppBackgroundView.rightToSuperview(offset: -6)
        
        self.inAppBackgroundView.addSubview(self.inAppLabel)
        self.inAppLabel.leftToSuperview(offset: 25)
        self.inAppLabel.centerYToSuperview()
        self.inAppLabel.rightToSuperview(offset: -30)
        
        self.inAppBackgroundView.addSubview(self.inAppChevron)
        self.inAppChevron.rightToSuperview(offset: -33)
        self.inAppChevron.centerYToSuperview()
        
        self.inAppBackgroundView.addSubview(self.inAppHiddenButton)
        self.inAppHiddenButton.edgesToSuperview()
    }
    
    private func layoutInteractionUI() {
        self.scrollViewContentView.addSubview(self.interactionLabel)
        self.interactionLabel.topToBottom(of: self.inAppBackgroundView, offset: 26)
        self.interactionLabel.leftToSuperview(offset: 21)
        self.interactionLabel.rightToSuperview(offset: -21)

        self.scrollViewContentView.addSubview(self.interactionContainerView)
        self.interactionContainerView.topToBottom(of: self.interactionLabel, offset: 10)
        self.interactionContainerView.left(to: self.inAppBackgroundView)
        self.interactionContainerView.right(to: self.inAppBackgroundView)
        
        self.interactionContainerView.addSubview(self.likeLabel)
        self.likeLabel.leftToSuperview(offset: 14)
        self.likeLabel.topToSuperview(offset: 25)
        
        self.interactionContainerView.addSubview(self.likeToggle)
        self.likeToggle.centerY(to: self.likeLabel)
        self.likeToggle.rightToSuperview(offset: -14)
        
        self.interactionContainerView.addSubview(self.commentToggle)
        self.commentToggle.topToBottom(of: self.likeToggle, offset: 35)
        self.commentToggle.right(to: self.likeToggle)
        
        self.interactionContainerView.addSubview(self.commentsLabel)
        self.commentsLabel.left(to: self.likeLabel)
        self.commentsLabel.centerY(to: self.commentToggle)
        
        self.interactionContainerView.addSubview(self.followerToggle)
        self.followerToggle.topToBottom(of: self.commentToggle, offset: 35)
        self.followerToggle.right(to: self.likeToggle)
        
        self.interactionContainerView.addSubview(self.newFollowersLabel)
        self.newFollowersLabel.left(to: self.likeLabel)
        self.newFollowersLabel.centerY(to: self.followerToggle)
        
        self.interactionContainerView.addSubview(self.mentionsToggle)
        self.mentionsToggle.topToBottom(of: self.followerToggle, offset: 35)
        self.mentionsToggle.right(to: self.likeToggle)
        
        self.interactionContainerView.addSubview(self.mentionsLabel)
        self.mentionsLabel.left(to: self.likeLabel)
        self.mentionsLabel.centerY(to: self.mentionsToggle)
        
        self.interactionContainerView.addSubview(self.profileToggle)
        self.profileToggle.topToBottom(of: self.mentionsToggle, offset: 35)
        self.profileToggle.right(to: self.likeToggle)
        
        self.interactionContainerView.addSubview(self.profileViewsLabel)
        self.profileViewsLabel.left(to: self.likeLabel)
        self.profileViewsLabel.centerY(to: self.profileToggle)
        
        self.interactionContainerView.addSubview(self.repostToggle)
        self.repostToggle.topToBottom(of: self.profileToggle, offset: 35)
        self.repostToggle.right(to: self.likeToggle)

        self.interactionContainerView.addSubview(self.repostLabel)
        self.repostLabel.left(to: self.likeLabel)
        self.repostLabel.centerY(to: self.repostToggle)
    }
    
    private func layoutMessageUI() {
        self.scrollViewContentView.addSubview(self.messagesLabel)
        self.messagesLabel.topToBottom(of: self.interactionContainerView, offset: 26)
        self.messagesLabel.left(to: self.interactionLabel)
        self.messagesLabel.right(to: self.interactionLabel)
        
        self.scrollViewContentView.addSubview(self.messagesContainerView)
        self.messagesContainerView.topToBottom(of: self.messagesLabel, offset: 10)
        self.messagesContainerView.left(to: self.inAppBackgroundView)
        self.messagesContainerView.right(to: self.inAppBackgroundView)
        
        self.messagesContainerView.addSubview(self.directToggle)
        self.directToggle.topToSuperview(offset: 14)
        self.directToggle.rightToSuperview(offset: -14)
        
        self.messagesContainerView.addSubview(self.directMessageLabel)
        self.directMessageLabel.centerY(to: self.directToggle)
        self.directMessageLabel.leftToSuperview(offset: 14)
        
        self.messagesContainerView.addSubview(self.previewToggle)
        self.previewToggle.topToBottom(of: self.directToggle, offset: 40)
        self.previewToggle.right(to: self.directToggle)
        
        self.messagesContainerView.addSubview(self.previewLabel)
        self.previewLabel.centerY(to: self.previewToggle)
        self.previewLabel.left(to: self.directMessageLabel)
        
        self.scrollViewContentView.bottom(to: self.messagesContainerView, offset: 30)
    }
}
//MARK: - Helpers
extension NotificationsController {
    private func createHiddenButton(with selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    private func createToggleButton(with selector: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.isSelected = false
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "IsOnIcon"), for: .selected)
        button.setImage(UIImage(named: "IsOffIcon"), for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.height(26)
        button.width(48)
        return button
    }
}
//MARK: - @objc
extension NotificationsController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapInApp() {
        print(#function)
    }
    
    @objc func didTapLikes() {
        print(#function)
        self.likeToggle.isSelected.toggle()
    }
    
    @objc func didTapComments() {
        print(#function)
        self.commentToggle.isSelected.toggle()
    }
    
    @objc func didTapNewFollowers() {
        print(#function)
        self.followerToggle.isSelected.toggle()
    }
    
    @objc func didTapMentions() {
        print(#function)
        self.mentionsToggle.isSelected.toggle()
    }
    
    @objc func didTapProfile() {
        print(#function)
        self.profileToggle.isSelected.toggle()
    }
    
    @objc func didTapRepost() {
        print(#function)
        self.repostToggle.isSelected.toggle()
    }
    
    @objc func didTapDirectMessages() {
        print(#function)
        self.directToggle.isSelected.toggle()
    }
    
    @objc func didTapDirectPreview() {
        print(#function)
        self.previewToggle.isSelected.toggle()
    }
}