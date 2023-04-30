//
//  TwoFactorPopUpController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/30/23.
//

import UIKit

final class TwoFactorPopUpController: UIViewController {
    private let selectedImage = UIImage(named: "Checkmark")
    
    var homeController: SecurityController!
    var method: VerifyType = .sms
    
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
        label.text = "Select verification method"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.tintColor = UIColor.black
        button.setImage(UIImage(named: "CloseButton"), for: .normal)
        button.width(16)
        button.height(16)
        return button
    }()
    
    private let turnOnButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.kwiksTextBlack
        button.backgroundColor = UIColor.kwiksGreen
        button.setTitle("Turn On", for: .normal)
        button.titleLabel?.font = .segoeUISemiBold(size: 15)
        button.layer.cornerRadius = 25
        button.height(50)
        return button
    }()
    
    private lazy var smsImageView = self.createIconImageView(with: "PublicPrivacyIcon")
    private lazy var smsTitleLabel = self.createTitleLabel(with: "SMS")
    private lazy var smsSubLabel = self.createSubLabel(with: "A verification code will be sent via SMS")
    
    private let smsButton: UIButton = {
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
    
    private lazy var emailImageView = self.createIconImageView(with: "FriendsPrivacyIcon")
    private lazy var emailTitleLabel = self.createTitleLabel(with: "Email")
    private lazy var emailSubLabel = self.createSubLabel(with: "kwiks@kwiky.com")
    
    private let emailButton: UIButton = {
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
    }
}
//MARK: - Configure Controller
extension TwoFactorPopUpController {
    private func configure() {
        self.view.backgroundColor = .clear
        
        self.closeButton.addTarget(self, action: #selector(tapToDismiss), for: .touchUpInside)
        self.turnOnButton.addTarget(self, action: #selector(tapToDismiss), for: .touchUpInside)
        self.smsButton.addTarget(self, action: #selector(didTapSMS), for: .touchUpInside)
        self.emailButton.addTarget(self, action: #selector(didTapEmail), for: .touchUpInside)
        
        switch self.method {
        case .none:
            break

        case .sms:
            self.didTapSMS()

        case .email:
            self.didTapEmail()
        }
    }
}

//MARK: - Layout UI
extension TwoFactorPopUpController {
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
        
        self.contentContainerView.addSubview(self.turnOnButton)
        self.turnOnButton.leftToSuperview(offset: 30)
        self.turnOnButton.rightToSuperview(offset: -30)
        self.turnOnButton.bottomToSuperview(usingSafeArea: true)
        
        self.contentContainerView.addSubview(self.smsImageView)
        self.smsImageView.topToBottom(of: self.headerLabel, offset: 30)
        self.smsImageView.leftToSuperview(offset: 42)
        
        self.contentContainerView.addSubview(self.smsButton)
        self.smsButton.rightToSuperview(offset: -30)
        self.smsButton.centerY(to: self.smsImageView)
        
        self.contentContainerView.addSubview(self.smsTitleLabel)
        self.smsTitleLabel.top(to: self.smsImageView)
        self.smsTitleLabel.leftToRight(of: self.smsImageView, offset: 20)
        
        self.contentContainerView.addSubview(self.smsSubLabel)
        self.smsSubLabel.bottom(to: self.smsImageView)
        self.smsSubLabel.left(to: self.smsTitleLabel)
        self.smsSubLabel.rightToLeft(of: self.smsButton, offset: -10)
        
        self.contentContainerView.addSubview(self.emailImageView)
        self.emailImageView.topToBottom(of: self.smsImageView, offset: 30)
        self.emailImageView.centerX(to: self.smsImageView)
        
        self.contentContainerView.addSubview(self.emailButton)
        self.emailButton.right(to: self.smsButton)
        self.emailButton.centerY(to: self.emailImageView)
        
        self.contentContainerView.addSubview(self.emailTitleLabel)
        self.emailTitleLabel.top(to: self.emailImageView)
        self.emailTitleLabel.leftToRight(of: self.emailImageView, offset: 20)
        
        self.contentContainerView.addSubview(self.emailSubLabel)
        self.emailSubLabel.bottom(to: self.emailImageView)
        self.emailSubLabel.left(to: self.emailTitleLabel)
    }
}

//MARK: - Helpers
extension TwoFactorPopUpController {
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
extension TwoFactorPopUpController {
    @objc func tapToDismiss() {
        //TODO: Send selection to backend.
        self.homeController.twoFactorMethod = self.method
        self.dismiss(animated: true)
    }
    
    @objc func didTapSMS() {
        self.method = .sms
        
        self.smsButton.backgroundColor = UIColor(hexString: "#69BD06")
        self.smsButton.layer.borderColor = UIColor(hexString: "#69BD06").cgColor
        self.smsButton.setImage(self.selectedImage, for: .normal)
        
        self.emailButton.backgroundColor = UIColor.white
        self.emailButton.setImage(nil, for: .normal)
        self.emailButton.layer.borderColor = UIColor.kwiksTextBlack.cgColor
    }
    
    @objc func didTapEmail() {
        self.method = .email
        
        self.emailButton.backgroundColor = UIColor(hexString: "#69BD06")
        self.emailButton.layer.borderColor = UIColor(hexString: "#69BD06").cgColor
        self.emailButton.setImage(self.selectedImage, for: .normal)
        
        self.smsButton.backgroundColor = UIColor.white
        self.smsButton.setImage(nil, for: .normal)
        self.smsButton.layer.borderColor = UIColor.kwiksTextBlack.cgColor
    }
}
