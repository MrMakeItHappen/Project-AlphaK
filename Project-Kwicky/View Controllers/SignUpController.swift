//
//  SignUpController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/8/23.
//

import UIKit

final class SignUpController: UIViewController {
    private let background: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 46)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = UIColor.white
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.83
        label.attributedText = NSMutableAttributedString(string: "Create Better Together.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 15)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.13
        label.attributedText = NSMutableAttributedString(string: "Create a profile, follow other accounts, make your own videos, and more.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private let loginContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interMedium(size: 24)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var phoneButton: UIButton = {
        let mailIcon = UIImage(named: "MailIcon")?.resized(to: CGSize(width: 15, height: 15))
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .interRegular(size: 16)
        
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .capsule
        configuration.image = mailIcon
        configuration.imagePadding = 45
        configuration.attributedTitle = AttributedString("Use phone or email", attributes: attributeContainer)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 40)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapPhone()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 0
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.borderGrey.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 30
        button.backgroundColor = .white
        button.tintColor = .black
        button.height(60)
        return button
    }()
    
    private lazy var facebookButton: UIButton = {
        let mailIcon = UIImage(named: "FacebookIcon")?.resized(to: CGSize(width: 20, height: 20))
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .interRegular(size: 16)
        
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .capsule
        configuration.image = mailIcon
        configuration.imagePadding = 24
        configuration.attributedTitle = AttributedString("Continue with Facebook", attributes: attributeContainer)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapFacebook()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 0
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.borderGrey.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 30
        button.backgroundColor = .white
        button.tintColor = .black
        button.height(60)
        return button
    }()
    
    private lazy var appleButton: UIButton = {
        let mailIcon = UIImage(named: "AppleIcon")?.resized(to: CGSize(width: 20, height: 20))
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .interRegular(size: 16)
        
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .capsule
        configuration.image = mailIcon
        configuration.imagePadding = 40
        configuration.attributedTitle = AttributedString("Continue with Apple", attributes: attributeContainer)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapApple()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 0
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.borderGrey.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 30
        button.backgroundColor = .white
        button.tintColor = .black
        button.height(60)
        return button
    }()
    
    private lazy var googleButton: UIButton = {
        let mailIcon = UIImage(named: "GoogleIcon")?.resized(to: CGSize(width: 20, height: 20))
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .interRegular(size: 16)
        
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .capsule
        configuration.image = mailIcon
        configuration.imagePadding = 32
        configuration.attributedTitle = AttributedString("Continue with Google", attributes: attributeContainer)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapApple()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 0
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.borderGrey.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 30
        button.backgroundColor = .white
        button.tintColor = .black
        button.height(60)
        return button
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 15)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var logInButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .interSemiBold(size: 15)
        
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = ""
        self.addGradientBackground()
        self.layoutUI()
    }
}

//MARK: - Configure Controller
extension SignUpController {
    private func addGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.537, green: 0.839, blue: 0.345, alpha: 1).cgColor,
            UIColor(red: 0.443, green: 0.733, blue: 0.259, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        gradientLayer.position = view.center
        self.background.layer.addSublayer(gradientLayer)
        
        self.view.addSubview(self.background)
        self.background.edgesToSuperview()
    }
}

//MARK: - Layout UI
extension SignUpController {
    private func layoutUI() {
        self.view.addSubview(self.titleLabel)
        self.titleLabel.topToSuperview(offset: 79)
        self.titleLabel.leftToSuperview(offset: 40)
        self.titleLabel.rightToSuperview(offset: -40)
        
        self.view.addSubview(self.subTitleLabel)
        self.subTitleLabel.topToBottom(of: self.titleLabel, offset: 18)
        self.subTitleLabel.left(to: self.titleLabel)
        self.subTitleLabel.rightToSuperview(offset: -69)
        
        self.view.addSubview(self.loginContainerView)
        self.loginContainerView.topToBottom(of: self.subTitleLabel, offset: 35)
        self.loginContainerView.leftToSuperview()
        self.loginContainerView.rightToSuperview()
        self.loginContainerView.bottomToSuperview()
        
        self.loginContainerView.addSubview(self.signUpLabel)
        self.signUpLabel.topToSuperview(offset: 45)
        self.signUpLabel.leftToSuperview(offset: 51)
        
        self.loginContainerView.addSubview(self.phoneButton)
        self.phoneButton.topToBottom(of: self.signUpLabel, offset: 30)
        self.phoneButton.leftToSuperview(offset: 40)
        self.phoneButton.rightToSuperview(offset: -40)
        
        self.loginContainerView.addSubview(self.facebookButton)
        self.facebookButton.topToBottom(of: self.phoneButton, offset: 15)
        self.facebookButton.left(to: self.phoneButton)
        self.facebookButton.right(to: self.phoneButton)
        
        self.loginContainerView.addSubview(self.appleButton)
        self.appleButton.topToBottom(of: self.facebookButton, offset: 15)
        self.appleButton.left(to: self.phoneButton)
        self.appleButton.right(to: self.phoneButton)
        
        self.loginContainerView.addSubview(self.googleButton)
        self.googleButton.topToBottom(of: self.appleButton, offset: 15)
        self.googleButton.left(to: self.phoneButton)
        self.googleButton.right(to: self.phoneButton)
        
        self.loginContainerView.addSubview(self.bottomLabel)
        self.bottomLabel.topToBottom(of: self.googleButton, offset: 30)
        self.bottomLabel.centerXToSuperview(offset: -15)
        
        self.loginContainerView.addSubview(self.logInButton)
        self.logInButton.top(to: self.bottomLabel)
        self.logInButton.bottom(to: self.bottomLabel)
        self.logInButton.leftToRight(of: self.bottomLabel, offset: -4)
    }
}

//MARK: - Helpers
extension SignUpController {
    
}

//MARK: - @objc
extension SignUpController {
    @objc func didTapPhone() {
        let signUpDetailVC = SignUpDetailController()
        self.navigationController?.pushViewController(signUpDetailVC, animated: true)
    }
    
    @objc func didTapFacebook() {
        print(#function)
    }
    
    @objc func didTapApple() {
        print(#function)
    }
    
    @objc func didTapLogin() {
        let loginVC = LoginController()
        loginVC.modalPresentationStyle = .popover
        self.navigationController?.present(loginVC, animated: true)
    }
}
