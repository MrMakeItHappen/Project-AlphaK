//
//  EditPhoneNumberController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 5/1/23.
//

import UIKit

final class EditPhoneNumberController: UIViewController {
    
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
        label.text = "Phone Number"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    private let phoneNumberContainer = UIView.createSettingsContainer()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone Number"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 16)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    private let dividerLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .kwiksGrey
        view.height(1)
        return view
    }()
    
    private let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.kwiksGreen
        button.setTitle("Update", for: .normal)
        button.titleLabel?.font = .segoeUISemiBold(size: 15)
        button.layer.cornerRadius = 25
        button.height(50)
        return button
    }()
    
    lazy var phoneTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = _userPhoneNumber
        textField.textAlignment = .left
        textField.textColor = .black
        textField.font = UIFont.segoeUIRegular(size: 16)
        textField.allowsEditingTextAttributes = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.backgroundColor = .clear
        textField.returnKeyType = .done
        textField.keyboardType = .numbersAndPunctuation
        textField.layer.masksToBounds = true
        textField.leftViewMode = .always
        textField.clipsToBounds = true
        textField.height(50)
        textField.setLeftPaddingPoints(0)
        textField.tag = 0
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Configure Controller
extension EditPhoneNumberController {
    private func configure() {
        self.view.backgroundColor = .white
        self.updateButton.addTarget(self, action: #selector(didTapUpdate), for: .touchUpInside)
        self.phoneTextField.becomeFirstResponder()
    }
}

//MARK: - Layout UI
extension EditPhoneNumberController {
    private func layoutUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerY(to: self.customBackButton)
        self.titleLabel.centerXToSuperview()
        
        self.view.addSubview(self.phoneNumberContainer)
        self.phoneNumberContainer.topToBottom(of: self.customBackButton, offset: 35)
        self.phoneNumberContainer.leftToSuperview(offset: 6)
        self.phoneNumberContainer.rightToSuperview(offset: -6)
        
        self.phoneNumberContainer.addSubview(self.phoneNumberLabel)
        self.phoneNumberLabel.topToSuperview(offset: 25)
        self.phoneNumberLabel.leftToSuperview(offset: 16)
        
        self.phoneNumberContainer.addSubview(self.phoneTextField)
        self.phoneTextField.rightToSuperview(offset: -16)
        self.phoneTextField.centerY(to: self.phoneNumberLabel)
        
        self.phoneNumberContainer.addSubview(self.dividerLineView)
        self.dividerLineView.bottom(to: self.phoneNumberLabel, offset: 11)
        self.dividerLineView.leftToSuperview(offset: 16)
        self.dividerLineView.rightToSuperview(offset: -16)
        
        self.phoneNumberContainer.bottom(to: self.dividerLineView, offset: 25)
        
        self.view.addSubview(self.updateButton)
        self.updateButton.topToBottom(of: self.phoneNumberContainer, offset: 48)
        self.updateButton.leftToSuperview(offset: 30)
        self.updateButton.rightToSuperview(offset: -30)
    }
}

//MARK: - Helpers
extension EditPhoneNumberController {
    
}

//MARK: - @objc
extension EditPhoneNumberController {
    @objc func didTapBack() {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapUpdate() {
        guard let text = self.phoneTextField.text, !text.isEmpty else {
            //Handle text field error
            return
        }
        
        _userPhoneNumber = text
        
        let confirmVC = ConfirmationLinkController()
        confirmVC.isModalInPresentation = true
        confirmVC.entryPath = .phone
        confirmVC.delegate = self
        //TODO: Remember to pass value from here.
        
        self.view.endEditing(true)
        self.phoneTextField.text = nil
        self.present(confirmVC, animated: true)
    }
}
//MARK: - UITextField Delegate
extension EditPhoneNumberController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.didTapUpdate()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = self.phoneTextField.text {

            let maxLength = 12
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            
            textField.text = text
            return newString.length <= maxLength
        }

        return true
    }
}
//MARK: Confirmation Delegate
extension EditPhoneNumberController: ConfirmationDelegate {
    func updateGlobal() {
        self.phoneTextField.placeholder = _userPhoneNumber
    }
}
