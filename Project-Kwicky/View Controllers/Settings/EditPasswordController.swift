//
//  EditPasswordController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 5/1/23.
//

import UIKit

final class EditPasswordController: UIViewController {
    
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
        label.text = "Password"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    private let passwordContainer = UIView.createSettingsContainer()
    
    private let currentPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Current password"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 16)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    private let currentDividerLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .kwiksGrey
        view.height(1)
        return view
    }()
    
    lazy var currentTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "********"
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
    
    private let newPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "New password"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 16)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    private let newDividerLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .kwiksGrey
        view.height(1)
        return view
    }()
    
    lazy var newPasswordTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Enter new password"
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
    
    private let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirm password"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 16)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    private let confirmDividerLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .kwiksGrey
        view.height(1)
        return view
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Confirm new password"
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
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor(hexString: "686868")
        button.backgroundColor = UIColor(hexString: "DADADA")
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = .segoeUISemiBold(size: 15)
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
extension EditPasswordController {
    private func configure() {
        self.view.backgroundColor = .white
        self.updateButton.addTarget(self, action: #selector(didTapUpdate), for: .touchUpInside)
        self.cancelButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
    }
}
//MARK: - Layout UI
extension EditPasswordController {
    private func layoutUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerY(to: self.customBackButton)
        self.titleLabel.centerXToSuperview()
        
        self.view.addSubview(self.passwordContainer)
        self.passwordContainer.topToBottom(of: self.customBackButton, offset: 35)
        self.passwordContainer.leftToSuperview(offset: 6)
        self.passwordContainer.rightToSuperview(offset: -6)
        self.passwordContainer.height(210)
        
        self.passwordContainer.addSubview(self.currentPasswordLabel)
        self.currentPasswordLabel.topToSuperview(offset: 25)
        self.currentPasswordLabel.leftToSuperview(offset: 16)
        
        self.passwordContainer.addSubview(self.currentTextField)
        self.currentTextField.rightToSuperview(offset: -16)
        self.currentTextField.centerY(to: self.currentPasswordLabel)
        
        self.passwordContainer.addSubview(self.currentDividerLineView)
        self.currentDividerLineView.bottom(to: self.currentPasswordLabel, offset: 11)
        self.currentDividerLineView.leftToSuperview(offset: 16)
        self.currentDividerLineView.rightToSuperview(offset: -16)
        
        self.passwordContainer.addSubview(self.newPasswordLabel)
        self.newPasswordLabel.topToBottom(of: self.currentDividerLineView, offset: 30)
        self.newPasswordLabel.left(to: self.currentPasswordLabel)
        
        self.passwordContainer.addSubview(self.newPasswordTextField)
        self.newPasswordTextField.right(to: self.currentTextField)
        self.newPasswordTextField.centerY(to: self.newPasswordLabel)
        
        self.passwordContainer.addSubview(self.newDividerLineView)
        self.newDividerLineView.bottom(to: self.newPasswordLabel, offset: 11)
        self.newDividerLineView.left(to: self.currentDividerLineView)
        self.newDividerLineView.right(to: self.currentDividerLineView)
        
        self.passwordContainer.addSubview(self.confirmPasswordLabel)
        self.confirmPasswordLabel.topToBottom(of: self.newDividerLineView, offset: 30)
        self.confirmPasswordLabel.left(to: self.currentPasswordLabel)

        self.passwordContainer.addSubview(self.confirmPasswordTextField)
        self.confirmPasswordTextField.right(to: self.currentTextField)
        self.confirmPasswordTextField.centerY(to: self.confirmPasswordLabel)

        self.passwordContainer.addSubview(self.confirmDividerLineView)
        self.confirmDividerLineView.bottom(to: self.confirmPasswordLabel, offset: 11)
        self.confirmDividerLineView.left(to: self.currentDividerLineView)
        self.confirmDividerLineView.right(to: self.currentDividerLineView)
        
        self.view.addSubview(self.updateButton)
        self.updateButton.topToBottom(of: self.passwordContainer, offset: 48)
        self.updateButton.leftToSuperview(offset: 30)
        self.updateButton.rightToSuperview(offset: -30)
        
        self.view.addSubview(self.cancelButton)
        self.cancelButton.topToBottom(of: self.updateButton, offset: 18)
        self.cancelButton.left(to: self.updateButton)
        self.cancelButton.right(to: self.updateButton)
    }
}
//MARK: - @objc
extension EditPasswordController {
    @objc func didTapBack() {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapUpdate() {
        let confirmVC = ConfirmationLinkController()
        confirmVC.isModalInPresentation = true
        confirmVC.entryPath = .password
        confirmVC.delegate = self
        
        self.view.endEditing(true)
        self.present(confirmVC, animated: true)
    }
}
//MARK: - UITextField Delegate
extension EditPasswordController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//    }
}
//MARK: - Confirmation Delegate
extension EditPasswordController: ConfirmationDelegate {
    func updateGlobal() {
        print(#function)
    }
}
