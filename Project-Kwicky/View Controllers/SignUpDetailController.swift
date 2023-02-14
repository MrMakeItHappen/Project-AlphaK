//
//  SignUpDetailController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/11/23.
//

import UIKit

final class SignUpDetailController: UIViewController {
    var isPathFromLogin = false
    
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
        label.text = "Email ID"
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
        
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .capsule
        configuration.image = icon
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 10
        configuration.attributedTitle = AttributedString("Sign Up", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapSignUp()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
        button.tintColor = .black
        button.layer.cornerRadius = 25
        button.height(50)
        button.isEnabled = false
        return button
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "I'm already a member,"
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.addGradientBackground()
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
    }
    
    private func addGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.537, green: 0.839, blue: 0.345, alpha: 1).cgColor,
            UIColor(red: 0.443, green: 0.733, blue: 0.259, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.bounds = view.bounds.insetBy(dx: -0.5 * view.bounds.size.width, dy: -0.5 * view.bounds.size.height)
        gradientLayer.position = view.center
        self.background.layer.addSublayer(gradientLayer)
        
        self.view.addSubview(self.background)
        self.background.edgesToSuperview()
    }
}
//MARK: - Layout UI
extension SignUpDetailController {
    private func layoutUI() {
        self.view.addSubview(self.titleLabel)
        self.titleLabel.topToSuperview(usingSafeArea: true)
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

        self.scrollViewContentView.addSubview(self.emailTextField)
        self.emailTextField.topToBottom(of: self.fullNameTextField, offset: 30)
        self.emailTextField.left(to: self.fullNameTextField)
        self.emailTextField.right(to: self.fullNameTextField)

        self.scrollViewContentView.addSubview(self.emailLabel)
        self.emailLabel.top(to: self.emailTextField, offset: -8)
        self.emailLabel.left(to: self.emailTextField, offset: 18)

        self.scrollViewContentView.addSubview(self.passwordTextField)
        self.passwordTextField.topToBottom(of: self.emailTextField, offset: 30)
        self.passwordTextField.left(to: self.fullNameTextField)
        self.passwordTextField.right(to: self.fullNameTextField)

        self.scrollViewContentView.addSubview(self.passwordLabel)
        self.passwordLabel.top(to: self.passwordTextField, offset: -8)
        self.passwordLabel.left(to: self.passwordTextField, offset: 22)

        self.scrollViewContentView.addSubview(self.birthdateTextField)
        self.birthdateTextField.topToBottom(of: self.passwordTextField, offset: 30)
        self.birthdateTextField.left(to: self.fullNameTextField)
        self.birthdateTextField.right(to: self.fullNameTextField)

        self.scrollViewContentView.addSubview(self.birthdateLabel)
        self.birthdateLabel.top(to: self.birthdateTextField, offset: -8)
        self.birthdateLabel.left(to: self.birthdateTextField, offset: 22)
        
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
    }
}
//MARK: - @objc
extension SignUpDetailController {
    @objc func didTapSignUp() {
        //Check if all fields are valid before submitting to backend.
        print(#function)
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
        
        guard let emailText = self.emailTextField.text, let passwordText = self.passwordTextField.text, let fullNameText = self.fullNameTextField.text else { return }
        
        if !emailText.isEmpty && !passwordText.isEmpty && !fullNameText.isEmpty {
            self.signUpButton.backgroundColor = .kwiksGreen
            self.signUpButton.isEnabled = true
        } else {
            self.signUpButton.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
            self.signUpButton.isEnabled = false
        }
        
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
            
            let maxLength = 20
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            
            textField.text = text
            return newString.length <= maxLength
        }
        
        return true
    }
}
