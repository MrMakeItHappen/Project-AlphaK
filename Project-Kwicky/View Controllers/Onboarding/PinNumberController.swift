//
//  PinNumberController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/15/23.
//

import UIKit

final class PinNumberController: UIViewController {
    var pinNumber: String?
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirmation\nLink Sent"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interSemiBold(size: 32)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter the 4 digits code sent\nto your email"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 18)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        return label
    }()
    
    private lazy var digitOneTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        let placeholder = "-"
        textField.placeholder = placeholder
        textField.textAlignment = .center
        textField.textColor = .black
        textField.font = UIFont.interMedium(size: 24)
        textField.allowsEditingTextAttributes = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.delegate = self
        textField.backgroundColor = .clear
        textField.returnKeyType = .next
        textField.keyboardType = .numberPad
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 40
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor.borderGrey.cgColor
        textField.layer.borderWidth = 1
        textField.clipsToBounds = true
        textField.layer.masksToBounds = true
        textField.height(122)
        textField.width(84)
        textField.setLeftPaddingPoints(0)
        textField.tag = 0
        textField.addTarget(self, action: #selector(self.handlePinNumber(for:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var digitTwoTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        let placeholder = "-"
        textField.placeholder = placeholder
        textField.textAlignment = .center
        textField.textColor = .black
        textField.font = UIFont.interMedium(size: 24)
        textField.allowsEditingTextAttributes = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.delegate = self
        textField.backgroundColor = .clear
        textField.returnKeyType = .next
        textField.keyboardType = .numberPad
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 40
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor.borderGrey.cgColor
        textField.layer.borderWidth = 1
        textField.clipsToBounds = true
        textField.layer.masksToBounds = true
        textField.height(122)
        textField.width(84)
        textField.setLeftPaddingPoints(0)
        textField.addTarget(self, action: #selector(self.handlePinNumber(for:)), for: .editingChanged)
        textField.tag = 1
        return textField
    }()
    
    private lazy var digitThreeTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        let placeholder = "-"
        textField.placeholder = placeholder
        textField.textAlignment = .center
        textField.textColor = .black
        textField.font = UIFont.interMedium(size: 24)
        textField.allowsEditingTextAttributes = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.delegate = self
        textField.backgroundColor = .clear
        textField.returnKeyType = .next
        textField.keyboardType = .numberPad
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 40
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor.borderGrey.cgColor
        textField.layer.borderWidth = 1
        textField.clipsToBounds = true
        textField.layer.masksToBounds = true
        textField.height(122)
        textField.width(84)
        textField.setLeftPaddingPoints(0)
        textField.tag = 2
        textField.addTarget(self, action: #selector(self.handlePinNumber(for:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var digitFourTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        let placeholder = "-"
        textField.placeholder = placeholder
        textField.textAlignment = .center
        textField.textColor = .black
        textField.font = UIFont.interMedium(size: 24)
        textField.allowsEditingTextAttributes = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.delegate = self
        textField.backgroundColor = .clear
        textField.returnKeyType = .next
        textField.keyboardType = .numberPad
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 40
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor.borderGrey.cgColor
        textField.layer.borderWidth = 1
        textField.clipsToBounds = true
        textField.layer.masksToBounds = true
        textField.height(122)
        textField.width(84)
        textField.setLeftPaddingPoints(0)
        textField.tag = 3
        textField.addTarget(self, action: #selector(self.handlePinNumber(for:)), for: .editingChanged)
        return textField
    }()
    
    private let pinStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = 6
        return stackView
    }()
    
    private lazy var confirmButton: UIButton = {
        let icon = UIImage(named: "LoginIcon")
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .interRegular(size: 16)
        
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .capsule
        configuration.image = icon
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 10
        configuration.attributedTitle = AttributedString("Confirm", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapConfirm()
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
        label.text = "Didn't receive the code?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 13)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var resendButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .interSemiBold(size: 13)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("Resend here.", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapResend()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = .clear
        button.tintColor = .kwiksGreen
        button.sizeToFit()
        return button
    }()
    
    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = -6
        return stackView
    }()
    
    var tempPinNumberDisplay: UILabel = {
        let label = UILabel()
        label.text = "0000"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Configure
extension PinNumberController {
    private func configure() {
        self.view.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)
    }
}
//MARK: - Layout UI
extension PinNumberController {
    private func layoutUI() {
        self.view.addSubview(self.mainTitleLabel)
        self.mainTitleLabel.topToSuperview(offset: 40, usingSafeArea: true)
        self.mainTitleLabel.leftToSuperview(offset: 40)
        self.mainTitleLabel.rightToSuperview(offset: -40)
        
        self.view.addSubview(self.subTitleLabel)
        self.subTitleLabel.topToBottom(of: self.mainTitleLabel, offset: 12)
        self.subTitleLabel.left(to: self.mainTitleLabel)
        self.subTitleLabel.right(to: self.mainTitleLabel)
        
        self.pinStackView.addArrangedSubview(self.digitOneTextField)
        self.pinStackView.addArrangedSubview(self.digitTwoTextField)
        self.pinStackView.addArrangedSubview(self.digitThreeTextField)
        self.pinStackView.addArrangedSubview(self.digitFourTextField)
        
        self.view.addSubview(self.pinStackView)
        self.pinStackView.topToBottom(of: self.subTitleLabel, offset: 49)
        self.pinStackView.centerXToSuperview()
        
        self.view.addSubview(self.tempPinNumberDisplay)
        self.tempPinNumberDisplay.topToBottom(of: self.pinStackView, offset: 20)
        self.tempPinNumberDisplay.left(to: self.pinStackView)
        self.tempPinNumberDisplay.right(to: self.pinStackView)
        
        self.view.addSubview(self.confirmButton)
        self.confirmButton.topToBottom(of: self.pinStackView, offset: 114)
        self.confirmButton.left(to: self.mainTitleLabel)
        self.confirmButton.right(to: self.mainTitleLabel)
        
        self.bottomStackView.addArrangedSubview(self.bottomLabel)
        self.bottomStackView.addArrangedSubview(self.resendButton)
        
        self.view.addSubview(self.bottomStackView)
        self.bottomStackView.topToBottom(of: self.confirmButton, offset: 37)
        self.bottomStackView.centerXToSuperview()
    }
}
//MARK: - Helpers
extension PinNumberController {
    
}
//MARK: - @objc
extension PinNumberController {
    @objc func didTapConfirm() {
        let selectUsernameVC = SelectUsernameController()
        selectUsernameVC.modalPresentationStyle = .fullScreen
        selectUsernameVC.navigationController?.navigationBar.isHidden = true
        
        self.present(selectUsernameVC, animated: true)
    }
    
    @objc func didTapResend() {
        print(#function)
    }
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        self.digitOneTextField.resignFirstResponder()
        self.digitTwoTextField.resignFirstResponder()
        self.digitThreeTextField.resignFirstResponder()
        self.digitFourTextField.resignFirstResponder()
    }
    
    @objc func handlePinNumber(for textField : UITextField) {
        let firstDigit = self.digitOneTextField.text ?? ""
        let secondDigit = self.digitTwoTextField.text ?? ""
        let thirdDigit = self.digitThreeTextField.text ?? ""
        let fourthDigit = self.digitFourTextField.text ?? ""
        
        
        if self.digitOneTextField.isFirstResponder && firstDigit.count > 0 {
            self.digitTwoTextField.becomeFirstResponder()
            
        } else if digitTwoTextField.isFirstResponder && secondDigit.count > 0 {
            self.digitThreeTextField.becomeFirstResponder()
            
        } else if digitThreeTextField.isFirstResponder && thirdDigit.count > 0 {
            self.digitFourTextField.becomeFirstResponder()
            
        } else if self.digitFourTextField.isFirstResponder && fourthDigit.count > 0 {
            //TODO: Handle Pin Completion Flow Here. If all fields are not complete, present error message. Otherwise store JWT token in user defaults to confirm authorization and login.
            self.digitFourTextField.resignFirstResponder()
            self.confirmButton.isEnabled = true
            self.confirmButton.backgroundColor = .kwiksGreen
        }
    }
}
//MARK: - UITextField Delegate
extension PinNumberController: UITextFieldDelegate {
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
            
            let maxLength = 1
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            
            textField.text = text
            return newString.length <= maxLength
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.borderGrey.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.kwiksGreen.cgColor
    }
}
