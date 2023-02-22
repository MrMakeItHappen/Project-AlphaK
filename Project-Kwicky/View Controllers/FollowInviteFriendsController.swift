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
        view.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
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
//    private lazy var hiddenWhatsAppButton = self.createHiddenButton(with: #selector(didTapFollowContacts))
//    private lazy var hiddenEmailButton = self.createHiddenButton(with: #selector(didTapFollowContacts))
//    private lazy var hiddenSMSButton = self.createHiddenButton(with: #selector(didTapFollowContacts))
//    private lazy var hiddenOtherOptionButton = self.createHiddenButton(with: #selector(didTapFollowContacts))

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
