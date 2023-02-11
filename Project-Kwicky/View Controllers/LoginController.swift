//
//  LoginController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/11/23.
//

import UIKit

final class LoginController: UIViewController, UITextFieldDelegate {
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
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interMedium(size: 24)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        let placeholder = "ex. kwiks@kwiks.com"
        textField.placeholder = placeholder
        textField.textAlignment = .left
        textField.textColor = .black
        textField.font = UIFont.interRegular(size: 18)
        textField.allowsEditingTextAttributes = false
        textField.autocorrectionType = .no
        textField.delegate = self
        textField.backgroundColor = .clear
        textField.returnKeyType = .next
        textField.keyboardType = .emailAddress
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor.borderGrey.cgColor
        textField.layer.borderWidth = 1
        textField.clipsToBounds = true
        textField.layer.masksToBounds = true
        textField.height(50)
        textField.setLeftPaddingPoints(30)
        return textField
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email Address"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.font = UIFont.interRegular(size: 13)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        label.width(108)
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        let placeholder = "ex. kwiks#123"
        textField.placeholder = placeholder
        textField.textAlignment = .left
        textField.textColor = .black
        textField.font = UIFont.interRegular(size: 18)
        textField.allowsEditingTextAttributes = false
        textField.autocorrectionType = .no
        textField.delegate = self
        textField.backgroundColor = .clear
        textField.returnKeyType = .next
        textField.keyboardType = .emailAddress
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor.borderGrey.cgColor
        textField.layer.borderWidth = 1
        textField.clipsToBounds = true
        textField.layer.masksToBounds = true
        textField.isSecureTextEntry = true
        textField.height(50)
        textField.setLeftPaddingPoints(30)
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.font = UIFont.interRegular(size: 13)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        label.width(80)
        return label
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .interRegular(size: 13)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("Forgot Password", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapForgotPassword()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = .clear
        button.tintColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        button.sizeToFit()
        return button
    }()
    
    private lazy var logInButton: UIButton = {
        let icon = UIImage(named: "LoginIcon")
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .interRegular(size: 18)
        
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .capsule
        configuration.image = icon
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 10
        configuration.attributedTitle = AttributedString("Log in", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapLogin()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
        button.tintColor = .black
        button.layer.cornerRadius = 25
        button.height(50)
        return button
    }()
    
    private lazy var appleLoginButton: UIButton = {
        let buttonHeight: CGFloat = 50
        var configuaration = UIButton.Configuration.plain()
        configuaration.image = UIImage(named: "AppleIcon02")
        
        let button = UIButton(configuration: configuaration, primaryAction: UIAction(handler: { _ in
            self.didTapAppleLogin()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 0
        button.layer.masksToBounds = true
        button.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
        button.height(buttonHeight)
        button.width(buttonHeight)
        button.layer.cornerRadius = buttonHeight / 2
        return button
    }()
    
    private lazy var facebookLoginButton: UIButton = {
        let buttonHeight: CGFloat = 50
        var configuaration = UIButton.Configuration.plain()
        configuaration.image = UIImage(named: "FacebookIcon02")
        
        let button = UIButton(configuration: configuaration, primaryAction: UIAction(handler: { _ in
            self.didTapFacebookLogin()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 0
        button.layer.masksToBounds = true
        button.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
        button.height(buttonHeight)
        button.width(buttonHeight)
        button.layer.cornerRadius = buttonHeight / 2
        return button
    }()
    
    private lazy var googleLoginButton: UIButton = {
        let buttonHeight: CGFloat = 50
        var configuaration = UIButton.Configuration.plain()
        configuaration.image = UIImage(named: "GoogleIcon02")
        
        let button = UIButton(configuration: configuaration, primaryAction: UIAction(handler: { _ in
            self.didTapGoogleLogin()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 0
        button.layer.masksToBounds = true
        button.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
        button.height(buttonHeight)
        button.width(buttonHeight)
        button.layer.cornerRadius = buttonHeight / 2
        return button
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Need to create an account?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 13)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var registerNowButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .interSemiBold(size: 13)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("Register now", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapRegisterNow()
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
        self.navigationController?.navigationBar.isHidden = false
        self.addGradientBackground()
        self.layoutUI()
    }

}
//MARK: - Configure Controller
extension LoginController {
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
extension LoginController {
    private func layoutUI() {
        self.view.addSubview(self.titleLabel)
        self.titleLabel.topToSuperview(offset: 40)
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
        
        self.loginContainerView.addSubview(self.loginLabel)
        self.loginLabel.topToSuperview(offset: 45)
        self.loginLabel.leftToSuperview(offset: 51)
        
        self.loginContainerView.addSubview(self.emailTextField)
        self.emailTextField.topToBottom(of: self.loginLabel, offset: 34)
        self.emailTextField.leftToSuperview(offset: 40)
        self.emailTextField.rightToSuperview(offset: -40)
        
        self.loginContainerView.addSubview(self.emailLabel)
        self.emailLabel.top(to: self.emailTextField, offset: -8)
        self.emailLabel.left(to: self.emailTextField, offset: 20)
        
        self.loginContainerView.addSubview(self.passwordTextField)
        self.passwordTextField.topToBottom(of: self.emailTextField, offset: 34)
        self.passwordTextField.left(to: self.emailTextField)
        self.passwordTextField.right(to: self.emailTextField)
        
        self.loginContainerView.addSubview(self.passwordLabel)
        self.passwordLabel.top(to: self.passwordTextField, offset: -8)
        self.passwordLabel.left(to: self.passwordTextField, offset: 19)
        
        self.loginContainerView.addSubview(self.forgotPasswordButton)
        self.forgotPasswordButton.topToBottom(of: self.passwordTextField, offset: 9)
        self.forgotPasswordButton.right(to: self.passwordTextField)
        
        self.loginContainerView.addSubview(self.logInButton)
        self.logInButton.topToBottom(of: self.forgotPasswordButton, offset: 32)
        self.logInButton.left(to: self.emailTextField)
        self.logInButton.right(to: self.emailTextField)
        
        self.loginContainerView.addSubview(self.appleLoginButton)
        self.appleLoginButton.topToBottom(of: self.logInButton, offset: 50)
        self.appleLoginButton.centerXToSuperview()
        
        self.loginContainerView.addSubview(self.facebookLoginButton)
        self.facebookLoginButton.top(to: self.appleLoginButton)
        self.facebookLoginButton.rightToLeft(of: self.appleLoginButton, offset: -15)
        
        self.loginContainerView.addSubview(self.googleLoginButton)
        self.googleLoginButton.top(to: self.appleLoginButton)
        self.googleLoginButton.leftToRight(of: self.appleLoginButton, offset: 15)
        
        self.loginContainerView.addSubview(self.bottomLabel)
        self.bottomLabel.bottomToSuperview(usingSafeArea: true)
        self.bottomLabel.centerXToSuperview(offset: -45)
        
        self.loginContainerView.addSubview(self.registerNowButton)
        self.registerNowButton.top(to: self.bottomLabel)
        self.registerNowButton.bottom(to: self.bottomLabel)
        self.registerNowButton.leftToRight(of: self.bottomLabel, offset: -6)
    }
}
//MARK: - @objc
extension LoginController {
    @objc func didTapLogin() {
        //Capture email address and password.
        //Submit to backend for verification.
        //If valid, present next screen.
        //If invalid, present pop-up with error description.
        print(#function)
    }
    
    @objc func didTapAppleLogin() {
        //Add Sign-In With Apple logic here.
        print(#function)
    }
    
    @objc func didTapFacebookLogin() {
        //Add Sign-In With Facebook logic here.
        print(#function)
    }
    
    @objc func didTapGoogleLogin() {
        //Add Sign-In With Google logic here.
        print(#function)
    }
    
    @objc func didTapRegisterNow() {
        print(#function)
    }
    
    @objc func didTapForgotPassword() {
        //Present Forgot Password pop-up or reset options.
        print(#function)
    }
}
