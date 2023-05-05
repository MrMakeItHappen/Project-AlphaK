//
//  SignUpDetailController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/11/23.
//

import UIKit
import Lottie

final class SignUpDetailController: UIViewController {
    var isPathFromLogin = false
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        
        let image = UIImage(named: "SimpleLoginBackground")
        imageView.image = image
        return imageView
    }()
    
    private let backgroundArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(344)
        imageView.width(226)
        
        let image = UIImage(named: "SignUpBackgroundArrow")
        imageView.image = image
        return imageView
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
        view.roundCorners(corners: [.topLeft, .topRight], radius: 30)
        return view
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Fill your details"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interMedium(size: 24)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
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
        scrollView.keyboardDismissMode = .onDrag
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
    
    private lazy var fullNameTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        let placeholder = "ex. Mark Blum"
        textField.placeholder = placeholder
        textField.textAlignment = .left
        textField.textColor = .black
        textField.font = UIFont.interRegular(size: 18)
        textField.allowsEditingTextAttributes = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
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
        textField.tag = 0
        return textField
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Full Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.font = UIFont.interRegular(size: 13)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        label.width(78)
        return label
    }()
    
    private let fullNameErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter your full name."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 10)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.textColor = .systemRed
        label.isHidden = true
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
        textField.autocapitalizationType = .none
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
        textField.tag = 1
        return textField
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email or Phone number"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.font = UIFont.interRegular(size: 13)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        label.width(150)
        return label
    }()
    
    private let emailErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter a valid email."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 10)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.textColor = .systemRed
        label.isHidden = true
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
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.backgroundColor = .clear
        textField.returnKeyType = .done
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
        textField.tag = 2
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
        label.width(78)
        return label
    }()
    
    private let passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter a password."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 10)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.textColor = .systemRed
        label.isHidden = true
        return label
    }()
    
    private lazy var birthdateTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        let placeholder = "ex. 01/21/2001"
        textField.placeholder = placeholder
        textField.isUserInteractionEnabled = false
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
    
    private let birthdateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date of birth"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.font = UIFont.interRegular(size: 13)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        label.width(95)
        return label
    }()
    
    private let birthdateErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "Please select your birthdate."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 10)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.textColor = .systemRed
        label.isHidden = true
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.tintColor = .kwiksGreen
        datePicker.addTarget(self, action: #selector(handleDateSelection), for: .valueChanged)
        return datePicker
    }()
    
    private lazy var signUpButton: UIButton = {
        let icon = UIImage(named: "LoginIcon")
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .interRegular(size: 16)
        attributeContainer.foregroundColor = .black
        
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .capsule
        configuration.image = icon
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 10
        configuration.attributedTitle = AttributedString("Sign up", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapSignUp()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
        button.layer.cornerRadius = 25
        button.height(50)
        return button
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Already a member?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 13)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var signInButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .interSemiBold(size: 13)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("Sign in", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapSignIn()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = .clear
        button.tintColor = .kwiksGreen
        button.sizeToFit()
        return button
    }()
    
    private lazy var loadingScreen: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .kwiksGreen
        view.layer.cornerRadius = 0
        view.clipsToBounds = true
        view.alpha = 0
        return view
    }()
    
    private lazy var lottieAnimation: LottieAnimationView = {
        let lottie = LottieAnimationView(name: "Rocket-Morphing")
        lottie.translatesAutoresizingMaskIntoConstraints = false
        lottie.isUserInteractionEnabled = false
        lottie.backgroundBehavior = .pauseAndRestore
        lottie.currentProgress = 0
        lottie.loopMode = .loop
        lottie.play()
        lottie.width(300)
        lottie.height(300)
        lottie.alpha = 0
        return lottie
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Configure Controller
extension SignUpDetailController {
    private func configure() {
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.isHidden = false
        
        if isPathFromLogin {
            self.bottomLabel.layer.opacity = 0
            self.signInButton.layer.opacity = 0
        } else {
            self.bottomLabel.layer.opacity = 1
            self.signInButton.layer.opacity = 1
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)
    }
}
//MARK: - Layout UI
extension SignUpDetailController {
    private func layoutUI() {
        self.view.addSubview(self.backgroundImageView)
        self.backgroundImageView.edgesToSuperview()
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.topToSuperview(usingSafeArea: true)
        self.titleLabel.leftToSuperview(offset: 40)
        self.titleLabel.rightToSuperview(offset: -40)
        
        self.view.addSubview(self.backgroundArrowImageView)
        self.backgroundArrowImageView.top(to: self.titleLabel, offset: -16)
        self.backgroundArrowImageView.rightToSuperview(offset: 6)
        
        self.view.addSubview(self.subTitleLabel)
        self.subTitleLabel.topToBottom(of: self.titleLabel, offset: 18)
        self.subTitleLabel.left(to: self.titleLabel)
        self.subTitleLabel.rightToSuperview(offset: -69)
        
        self.view.addSubview(self.loginContainerView)
        self.loginContainerView.topToBottom(of: self.subTitleLabel, offset: 35)
        self.loginContainerView.leftToSuperview()
        self.loginContainerView.rightToSuperview()
        self.loginContainerView.bottomToSuperview()
        
        self.loginContainerView.addSubview(self.detailsLabel)
        self.detailsLabel.topToSuperview(offset: 42)
        self.detailsLabel.leftToSuperview(offset: 40)
        
        self.loginContainerView.addSubview(self.scrollView)
        self.scrollView.topToBottom(of: self.detailsLabel, offset: 34)
        self.scrollView.leftToSuperview(offset: 20)
        self.scrollView.rightToSuperview(offset: -20)
        self.scrollView.bottom(to: self.view, self.view.keyboardLayoutGuide.topAnchor)
        
        self.scrollView.addSubview(self.scrollViewContentView)
        self.scrollViewContentView.edgesToSuperview()
        self.scrollViewContentView.width(to: self.scrollView)
        
        self.scrollViewContentView.addSubview(self.fullNameTextField)
        self.fullNameTextField.topToSuperview(offset: 10)
        self.fullNameTextField.leftToSuperview(offset: 20)
        self.fullNameTextField.rightToSuperview(offset: -20)
        
        self.scrollViewContentView.addSubview(self.fullNameLabel)
        self.fullNameLabel.top(to: self.fullNameTextField, offset: -8)
        self.fullNameLabel.left(to: self.fullNameTextField, offset: 22)
        
        self.scrollViewContentView.addSubview(self.fullNameErrorLabel)
        self.fullNameErrorLabel.topToBottom(of: self.fullNameTextField, offset: 4)
        self.fullNameErrorLabel.left(to: self.fullNameTextField)
        self.fullNameErrorLabel.right(to: self.fullNameTextField, offset: -6)
        
        self.scrollViewContentView.addSubview(self.emailTextField)
        self.emailTextField.topToBottom(of: self.fullNameTextField, offset: 30)
        self.emailTextField.left(to: self.fullNameTextField)
        self.emailTextField.right(to: self.fullNameTextField)
        
        self.scrollViewContentView.addSubview(self.emailLabel)
        self.emailLabel.top(to: self.emailTextField, offset: -8)
        self.emailLabel.left(to: self.emailTextField, offset: 25)
        
        self.scrollViewContentView.addSubview(self.emailErrorLabel)
        self.emailErrorLabel.topToBottom(of: self.emailTextField, offset: 4)
        self.emailErrorLabel.left(to: self.emailTextField)
        self.emailErrorLabel.right(to: self.emailTextField, offset: -6)
        
        self.scrollViewContentView.addSubview(self.passwordTextField)
        self.passwordTextField.topToBottom(of: self.emailTextField, offset: 30)
        self.passwordTextField.left(to: self.fullNameTextField)
        self.passwordTextField.right(to: self.fullNameTextField)
        
        self.scrollViewContentView.addSubview(self.passwordLabel)
        self.passwordLabel.top(to: self.passwordTextField, offset: -8)
        self.passwordLabel.left(to: self.passwordTextField, offset: 22)
        
        self.scrollViewContentView.addSubview(self.passwordErrorLabel)
        self.passwordErrorLabel.topToBottom(of: self.passwordTextField, offset: 4)
        self.passwordErrorLabel.left(to: self.passwordTextField)
        self.passwordErrorLabel.right(to: self.passwordTextField, offset: -6)
        
        self.scrollViewContentView.addSubview(self.birthdateTextField)
        self.birthdateTextField.topToBottom(of: self.passwordTextField, offset: 30)
        self.birthdateTextField.left(to: self.fullNameTextField)
        self.birthdateTextField.right(to: self.fullNameTextField)
        
        self.scrollViewContentView.addSubview(self.birthdateLabel)
        self.birthdateLabel.top(to: self.birthdateTextField, offset: -8)
        self.birthdateLabel.left(to: self.birthdateTextField, offset: 22)
        
        self.scrollViewContentView.addSubview(self.birthdateErrorLabel)
        self.birthdateErrorLabel.topToBottom(of: self.birthdateTextField, offset: 4)
        self.birthdateErrorLabel.left(to: self.birthdateTextField)
        self.birthdateErrorLabel.right(to: self.birthdateTextField, offset: -6)
        
        self.scrollViewContentView.addSubview(self.datePicker)
        self.datePicker.right(to: self.birthdateTextField, offset: -10)
        self.datePicker.centerY(to: self.birthdateTextField)
        
        self.scrollViewContentView.addSubview(self.signUpButton)
        self.signUpButton.topToBottom(of: self.birthdateTextField, offset: 37)
        self.signUpButton.left(to: self.fullNameTextField)
        self.signUpButton.right(to: self.fullNameTextField)
        
        self.scrollViewContentView.addSubview(self.bottomLabel)
        self.bottomLabel.topToBottom(of: self.signUpButton, offset: 26)
        self.bottomLabel.centerXToSuperview(offset: -26)
        
        self.scrollViewContentView.addSubview(self.signInButton)
        self.signInButton.top(to: self.bottomLabel)
        self.signInButton.bottom(to: self.bottomLabel)
        self.signInButton.leftToRight(of: self.bottomLabel, offset: -6)
        
        self.scrollViewContentView.bottom(to: self.bottomLabel, offset: 4)
        
        self.view.addSubview(self.loadingScreen)
        self.loadingScreen.edgesToSuperview()
        
        self.loadingScreen.addSubview(self.lottieAnimation)
        self.lottieAnimation.centerInSuperview()
    }
}
//MARK: - Helpers
extension SignUpDetailController {
    private func removeTextFieldErrors() {
        self.fullNameTextField.layer.borderColor = UIColor.borderGrey.cgColor
        self.fullNameErrorLabel.isHidden = true
        
        self.emailTextField.layer.borderColor = UIColor.borderGrey.cgColor
        self.emailErrorLabel.isHidden = true
        
        self.passwordTextField.layer.borderColor = UIColor.borderGrey.cgColor
        self.passwordErrorLabel.isHidden = true
        
        self.birthdateTextField.layer.borderColor = UIColor.borderGrey.cgColor
        self.birthdateErrorLabel.isHidden = true
    }
}
//MARK: - @objc
extension SignUpDetailController {
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc func didTapSignUp() {
        
        //TODO: Check if all fields are valid before submitting to backend.
       guard let emailText = self.emailTextField.text, let passwordText = self.passwordTextField.text, let fullNameText = self.fullNameTextField.text, let dateText = self.birthdateTextField.text else { return }
        
        if fullNameText.isEmpty {
            self.fullNameTextField.layer.borderColor = UIColor.systemRed.cgColor
            self.fullNameErrorLabel.isHidden = false
            return
        }
        
        if emailText.isEmpty {
            self.emailTextField.layer.borderColor = UIColor.systemRed.cgColor
            self.emailErrorLabel.isHidden = false
            return
        }
        
        if passwordText.isEmpty {
            self.passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
            self.passwordErrorLabel.isHidden = false
            return
        }
        
        if dateText.isEmpty {
            self.birthdateTextField.layer.borderColor = UIColor.systemRed.cgColor
            self.birthdateErrorLabel.isHidden = false
            return
        }
        
        //TODO: Need to check if this is a phone number or email address before pinging backend.
        
        //Display Loading Screen
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.50) {
                self.loadingScreen.alpha = 1
                self.lottieAnimation.alpha = 1
                self.lottieAnimation.play()
            }
        }
        
        let values = ["email":"\(emailText)"]

        //serverkit can manage all https calls so if a backend changes, one file changes
        ServerKit().onRegister(values: values) { onSuccess, object in

            if onSuccess == false {//flag error
                DispatchQueue.main.async {
                    print("🔴 Registration failed")
                   self.emailTextField.layer.borderColor = UIColor.systemRed.cgColor
                   self.emailErrorLabel.isHidden = false
                   self.emailErrorLabel.text = "Sorry, email already exists."

                   self.loadingScreen.alpha = 0
                   self.lottieAnimation.alpha = 0
                   self.lottieAnimation.stop()
                }
            } else {
                print("🟢 Registration success")
                if !fullNameText.isEmpty && !emailText.isEmpty && !passwordText.isEmpty && !dateText.isEmpty {
                    //Remove Loading Screen
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.50) {
                            self.loadingScreen.alpha = 0
                            self.lottieAnimation.alpha = 0
                            self.lottieAnimation.stop()
                        }

                        let pinVC = PinNumberController()
                        let pinNumber = object["data"] as? String ?? "This is a hard NULL from the server"

                        if pinNumber != "This is a hard NULL from the server" {
                            pinVC.pinNumber = pinNumber
                            pinVC.tempPinNumberDisplay.text = pinNumber
                            self.navigationController?.pushViewController(pinVC, animated: true)
                        } else {
                            //missing pin but we should not get it here
                            print("THIS IS OKAY")
                        }
                    }
                }
            }
        }
    }
    
    @objc func didTapSignIn() {
        let loginVC = LoginController()
        loginVC.isPathFromSignUpDetails = true
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc func handleDateSelection() {
        //Remember to upload in a different format.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        self.birthdateTextField.text = dateFormatter.string(from: self.datePicker.date)
        
        self.view.endEditing(true)
    }
}
//MARK: - UITextField Delegate
extension SignUpDetailController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text {
            
            let maxLength = 30
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            
            textField.text = text
            return newString.length <= maxLength
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.removeTextFieldErrors()
        
        guard let emailText = self.emailTextField.text, let passwordText = self.passwordTextField.text, let fullNameText = self.fullNameTextField.text, let dateText = self.birthdateTextField.text else { return }
        
        if !emailText.isEmpty && !passwordText.isEmpty && !fullNameText.isEmpty && !dateText.isEmpty {
            self.signUpButton.backgroundColor = .kwiksGreen
        } else {
            self.signUpButton.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
        }
    }
}


//TODO: inspect me
//graveyard
//        ServiceProvider.shared.serviceRequest(typeOfRequest: .POST, passedParameters: values, endpoint: Statics.signUpEndpoint) { JSON, error in
//
//            if error != nil {
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//                return
//            }
//
//            if let JSON = JSON {
//                let errors = JSON["errors"] as? [String] ?? ["nil"]
//                let pinNumber = JSON["data"] as? String ?? "This is a hard NULL from the server"
//
//                if errors != [] {
//                    guard let error = errors.first else { return }
//                    print("ERROR - ", error)
//
//                    DispatchQueue.main.async {
//                        self.emailTextField.layer.borderColor = UIColor.systemRed.cgColor
//                        self.emailErrorLabel.isHidden = false
//                        self.emailErrorLabel.text = "Sorry, email already exists."
//
//                        self.loadingScreen.alpha = 0
//                        self.lottieAnimation.alpha = 0
//                        self.lottieAnimation.stop()
//                    }
//
//                    return
//                }
//
//                print("SUCCESSFUL SIGN UP!")
//                print("JSON Response - ", pinNumber)
//
//                if !fullNameText.isEmpty && !emailText.isEmpty && !passwordText.isEmpty && !dateText.isEmpty {
//                    //Remove Loading Screen
//                    DispatchQueue.main.async {
//                        UIView.animate(withDuration: 0.50) {
//                            self.loadingScreen.alpha = 0
//                            self.lottieAnimation.alpha = 0
//                            self.lottieAnimation.stop()
//                        }
//
//                        let pinVC = PinNumberController()
//                        pinVC.pinNumber = pinNumber
//                        pinVC.tempPinNumberDisplay.text = pinNumber
//                        self.navigationController?.pushViewController(pinVC, animated: true)
//                    }
//                }
//
//            } else {
//                print(Statics.JSONFailedToLoad)
//            }
//        }
