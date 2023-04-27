//
//  FollowInviteFriendsController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/22/23.
//

import UIKit

final class FollowInviteFriendsController: UIViewController {
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
        label.text = "Follow And Invite Friends"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .settingsContainer
        view.layer.cornerRadius = 9
        return view
    }()
    
    private lazy var followContactsImageView = self.createIcon(with: "FollowContactsIcon")
    private lazy var whatsAppImageView = self.createIcon(with: "WhatsAppIcon")
    private lazy var inviteByEmailImageView = self.createIcon(with: "InviteByEmailIcon")
    private lazy var inviteBySMSImageView = self.createIcon(with: "InviteBySMSIcon")
    private lazy var inviteOtherOptionImageView = self.createIcon(with: "InviteOtherOptionIcon")
    
    private lazy var followContactsLabel = self.createLabel(with: "Follow Contacts")
    private lazy var whatsAppLabel = self.createLabel(with: "Invite Friends By WhatsApp")
    private lazy var emailLabel = self.createLabel(with: "Invite Friends By Email")
    private lazy var smsLabel = self.createLabel(with: "Invite Friends By SMS")
    private lazy var otherOptionLabel = self.createLabel(with: "Invite Friends By...")
    
    private lazy var hiddenFollowButton = self.createHiddenButton(with: #selector(didTapFollowContacts))
    private lazy var hiddenWhatsAppButton = self.createHiddenButton(with: #selector(didTapWhatsApp))
    private lazy var hiddenEmailButton = self.createHiddenButton(with: #selector(didTapEmail))
    private lazy var hiddenSMSButton = self.createHiddenButton(with: #selector(didTapSMS))
    private lazy var hiddenOtherOptionButton = self.createHiddenButton(with: #selector(didTapOtherOption))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.layoutUI()
    }
}
//MARK: - Layout UI
extension FollowInviteFriendsController {
    private func layoutUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerY(to: self.customBackButton)
        self.titleLabel.centerXToSuperview()
        
        self.view.addSubview(self.containerView)
        self.containerView.topToBottom(of: self.customBackButton, offset: 35)
        self.containerView.leftToSuperview(offset: 6)
        self.containerView.rightToSuperview(offset: -6)
        self.containerView.height(352)
        
        self.containerView.addSubview(self.followContactsImageView)
        self.followContactsImageView.topToSuperview(offset: 22)
        self.followContactsImageView.leftToSuperview(offset: 16)
        
        self.containerView.addSubview(self.followContactsLabel)
        self.followContactsLabel.centerY(to: self.followContactsImageView)
        self.followContactsLabel.leftToRight(of: self.followContactsImageView, offset: 31)
        self.followContactsLabel.rightToSuperview(offset: -16)
        
        self.containerView.addSubview(self.hiddenFollowButton)
        self.hiddenFollowButton.top(to: self.followContactsLabel, offset: -4)
        self.hiddenFollowButton.left(to: self.followContactsImageView)
        self.hiddenFollowButton.bottom(to: self.followContactsLabel, offset: 4)
        self.hiddenFollowButton.rightToSuperview(offset: -4)
        
        self.containerView.addSubview(self.whatsAppImageView)
        self.whatsAppImageView.topToBottom(of: self.followContactsImageView, offset: 50)
        self.whatsAppImageView.left(to: self.followContactsImageView)
        
        self.containerView.addSubview(self.whatsAppLabel)
        self.whatsAppLabel.centerY(to: self.whatsAppImageView)
        self.whatsAppLabel.leftToRight(of: self.whatsAppImageView, offset: 31)
        self.whatsAppLabel.right(to: self.followContactsLabel)
        
        self.containerView.addSubview(self.hiddenWhatsAppButton)
        self.hiddenWhatsAppButton.top(to: self.whatsAppLabel, offset: -4)
        self.hiddenWhatsAppButton.left(to: self.whatsAppImageView)
        self.hiddenWhatsAppButton.bottom(to: self.whatsAppLabel, offset: 4)
        self.hiddenWhatsAppButton.right(to: self.hiddenFollowButton)
        
        self.containerView.addSubview(self.inviteByEmailImageView)
        self.inviteByEmailImageView.topToBottom(of: self.whatsAppImageView, offset: 50)
        self.inviteByEmailImageView.left(to: self.whatsAppImageView)
        
        self.containerView.addSubview(self.emailLabel)
        self.emailLabel.centerY(to: self.inviteByEmailImageView)
        self.emailLabel.leftToRight(of: self.inviteByEmailImageView, offset: 31)
        self.emailLabel.right(to: self.followContactsLabel)
        
        self.containerView.addSubview(self.hiddenEmailButton)
        self.hiddenEmailButton.top(to: self.emailLabel, offset: -4)
        self.hiddenEmailButton.left(to: self.inviteByEmailImageView)
        self.hiddenEmailButton.bottom(to: self.emailLabel, offset: 4)
        self.hiddenEmailButton.right(to: self.hiddenFollowButton)
        
        self.containerView.addSubview(self.inviteBySMSImageView)
        self.inviteBySMSImageView.topToBottom(of: self.inviteByEmailImageView, offset: 50)
        self.inviteBySMSImageView.left(to: self.whatsAppImageView)
        
        self.containerView.addSubview(self.smsLabel)
        self.smsLabel.centerY(to: self.inviteBySMSImageView)
        self.smsLabel.leftToRight(of: self.inviteBySMSImageView, offset: 31)
        self.smsLabel.right(to: self.followContactsLabel)
        
        self.containerView.addSubview(self.hiddenSMSButton)
        self.hiddenSMSButton.top(to: self.smsLabel, offset: -4)
        self.hiddenSMSButton.left(to: self.inviteBySMSImageView)
        self.hiddenSMSButton.bottom(to: self.smsLabel, offset: 4)
        self.hiddenSMSButton.right(to: self.hiddenFollowButton)
        
        self.containerView.addSubview(self.inviteOtherOptionImageView)
        self.inviteOtherOptionImageView.topToBottom(of: self.inviteBySMSImageView, offset: 50)
        self.inviteOtherOptionImageView.left(to: self.whatsAppImageView)
        
        self.containerView.addSubview(self.otherOptionLabel)
        self.otherOptionLabel.centerY(to: self.inviteOtherOptionImageView)
        self.otherOptionLabel.leftToRight(of: self.inviteOtherOptionImageView, offset: 31)
        self.otherOptionLabel.right(to: self.followContactsLabel)
        
        self.containerView.addSubview(self.hiddenOtherOptionButton)
        self.hiddenOtherOptionButton.top(to: self.otherOptionLabel, offset: -4)
        self.hiddenOtherOptionButton.left(to: self.inviteOtherOptionImageView)
        self.hiddenOtherOptionButton.bottom(to: self.otherOptionLabel, offset: 4)
        self.hiddenOtherOptionButton.right(to: self.hiddenFollowButton)
    }
}
//MARK: - Helpers
extension FollowInviteFriendsController {
    private func createIcon(with name: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(20)
        imageView.width(20)
        
        let image = UIImage(named: name)
        imageView.image = image
        return imageView
    }
    
    private func createLabel(with name: String) -> UILabel {
        let label = UILabel()
        label.text = name
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }
    
    private func createHiddenButton(with selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
}
//MARK: - @objc
extension FollowInviteFriendsController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapFollowContacts() {
        print(#function)
    }
    
    @objc func didTapWhatsApp() {
        print(#function)
    }
    
    @objc func didTapEmail() {
        print(#function)
    }
    
    @objc func didTapSMS() {
        print(#function)
    }
    
    @objc func didTapOtherOption() {
        print(#function)
    }
}
