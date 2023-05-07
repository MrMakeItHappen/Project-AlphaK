//
//  SimpleLoginController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/26/23.
//

import UIKit

final class SimpleLoginController: UIViewController {
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        let image = UIImage(named: "SimpleLoginBackground")
        imageView.image = image
        return imageView
    }()
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        
        let image = UIImage(named: "SimpleLoginHeader")
        imageView.image = image
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .segoeUIBold(size: 46)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.white
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.85
        label.attributedText = NSMutableAttributedString(string: "Create Better \nTogether.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.text = "Create a profile, follow other accounts,\nmake your own videos, and more."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .segoeUISemiBold(size: 16)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private lazy var logInButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .interSemiBold(size: 14)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("Log In", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapLogin()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = .clear
        button.tintColor = .kwiksGreen
        button.sizeToFit()
        return button
    }()
    
    private lazy var registerWithPhoneButton: UIButton = {
        let icon = UIImage(named: "SimpleLoginPhoneIcon")
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .segoeUIRegular(size: 16)
        
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .capsule
        configuration.image = icon
        configuration.imagePlacement = .leading
        configuration.imagePadding = 8
        configuration.attributedTitle = AttributedString("Register with phone", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapPhone()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = .kwiksGreen
        button.tintColor = .kwiksTextBlack
        button.layer.cornerRadius = 25
        button.height(50)
        return button
    }()
    
    private lazy var registerWithEmailButton: UIButton = {
        let icon = UIImage(named: "SimpleLoginEmailIcon")
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .segoeUIRegular(size: 16)
        
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .capsule
        configuration.image = icon
        configuration.imagePlacement = .leading
        configuration.imagePadding = 10
        configuration.attributedTitle = AttributedString("Register with email", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapEmail()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = UIColor(hexString: "#78B84F")
        button.tintColor = .white
        button.layer.cornerRadius = 25
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
extension SimpleLoginController {
    private func configure() {
        self.view.backgroundColor = .white
        self.navigationItem.backButtonTitle = ""
        
        self.view.addSubview(self.backgroundImageView)
        self.backgroundImageView.edgesToSuperview()
    }
}

//MARK: - Layout UI
extension SimpleLoginController {
    private func layoutUI() {
        self.view.addSubview(self.bottomLabel)
        self.bottomLabel.bottomToSuperview(usingSafeArea: true)
        self.bottomLabel.centerXToSuperview(offset: -15)
        
        self.view.addSubview(self.logInButton)
        self.logInButton.centerY(to: self.bottomLabel)
        self.logInButton.leftToRight(of: self.bottomLabel, offset: -4)
        
        self.view.addSubview(self.registerWithPhoneButton)
        self.registerWithPhoneButton.bottomToTop(of: self.bottomLabel, offset: -35)
        self.registerWithPhoneButton.leftToSuperview(offset: 30)
        self.registerWithPhoneButton.rightToSuperview(offset: -30)
        
        self.view.addSubview(self.registerWithEmailButton)
        self.registerWithEmailButton.bottomToTop(of: self.registerWithPhoneButton, offset: -20)
        self.registerWithEmailButton.left(to: self.registerWithPhoneButton)
        self.registerWithEmailButton.right(to: self.registerWithPhoneButton)
        
        self.view.addSubview(self.subLabel)
        self.subLabel.bottomToTop(of: self.registerWithEmailButton, offset: -40)
        self.subLabel.leftToSuperview(offset: 38)
        self.subLabel.rightToSuperview(offset: -38)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.bottomToTop(of: self.subLabel, offset: -22)
        self.titleLabel.leftToSuperview(offset: 38)
        self.titleLabel.rightToSuperview(offset: -38)
        
        self.view.addSubview(self.headerImageView)
        self.headerImageView.bottomToTop(of: self.titleLabel)
        self.headerImageView.leftToSuperview()
        self.headerImageView.rightToSuperview()
    }
}

//MARK: - Helpers
extension SimpleLoginController {
    
}

//MARK: - @objc
extension SimpleLoginController {
    @objc func didTapLogin() {
        let loginVC = LoginController()
        let navVC = UINavigationController(rootViewController: loginVC)
        navVC.modalPresentationStyle = .popover
        self.navigationController?.present(navVC, animated: true)
    }
    
    @objc func didTapPhone() {
        let signUpVC = SignUpDetailController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func didTapEmail() {
        let signUpVC = SignUpDetailController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
