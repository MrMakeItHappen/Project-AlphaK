//
//  SelectUsernameController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/19/23.
//

import UIKit

final class SelectUsernameController: UIViewController {
    private let availableIcon = UIImage(named: "CheckmarkSelected")
    private let unavailableIcon = UIImage(systemName: "x.circle.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create username"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interSemiBold(size: 32)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose a username for your new account. You can always change it later."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 18)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        return label
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        let placeholder = "ex. Kwiks"
        textField.placeholder = placeholder
        textField.textAlignment = .left
        textField.textColor = .black
        textField.font = UIFont.interMedium(size: 20)
        textField.autocorrectionType = .no
        textField.delegate = self
        textField.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
        textField.returnKeyType = .done
        textField.keyboardType = .namePhonePad
        textField.layer.cornerRadius = 10
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.clipsToBounds = true
        textField.layer.masksToBounds = true
        textField.height(60)
        textField.setLeftPaddingPoints(30)
        textField.setRightPaddingPoints(40)
        textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        return textField
    }()
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 0
        imageView.height(20)
        imageView.width(20)
        return imageView
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.layoutUI()
    }
}
//MARK: - Layout UI
extension SelectUsernameController {
    private func layoutUI() {
        self.view.addSubview(self.titleLabel)
        self.titleLabel.topToSuperview(offset: 126)
        self.titleLabel.leftToSuperview(offset: 40)
        
        self.view.addSubview(self.subTitleLabel)
        self.subTitleLabel.topToBottom(of: self.titleLabel, offset: 20)
        self.subTitleLabel.left(to: self.titleLabel)
        self.subTitleLabel.rightToSuperview(offset: -40)
        
        self.view.addSubview(self.usernameTextField)
        self.usernameTextField.topToBottom(of: self.subTitleLabel, offset: 55)
        self.usernameTextField.leftToSuperview(offset: 30)
        self.usernameTextField.rightToSuperview(offset: -30)
        
        self.view.addSubview(self.checkmarkImageView)
        self.checkmarkImageView.centerY(to: self.usernameTextField)
        self.checkmarkImageView.right(to: self.usernameTextField, offset: -20)
        
        self.view.addSubview(self.confirmButton)
        self.confirmButton.topToBottom(of: self.usernameTextField, offset: 30)
        self.confirmButton.left(to: self.usernameTextField)
        self.confirmButton.right(to: self.usernameTextField)
    }
}
//MARK: - @objc
extension SelectUsernameController {
    @objc func textFieldDidChange(textField: UITextField) {
        //TODO: Implement profanity/vulgar checks.
        let availableUsernames = ["MarkBlum", "MarkGlixman", "Davidi", "Mark", "Blum", "Glixman"]
        let cleanNames = availableUsernames.map { $0.lowercased() }
        guard let username = textField.text?.lowercased() else { return }
        
        if cleanNames.contains(username) {
            UIView.animate(withDuration: 0.15, delay: 0.1, options: .curveLinear, animations: {
                self.checkmarkImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                
            }) { (success) in
                UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear, animations: {
                    self.checkmarkImageView.transform = .identity
                    self.checkmarkImageView.image = self.availableIcon
                    
                    self.confirmButton.isEnabled = true
                    self.confirmButton.backgroundColor = .kwiksGreen
                })
            }
            
        } else {
            self.checkmarkImageView.image = self.unavailableIcon
            self.confirmButton.isEnabled = false
            self.confirmButton.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
        }
    }
    
    @objc func didTapConfirm() {
        self.usernameTextField.resignFirstResponder()
        
        let homeVC = TabViewController()
        homeVC.modalPresentationStyle = .fullScreen
        
        self.present(homeVC, animated: true)
    }
}
//MARK: - UITextField Delegates
//TODO: User tapping Done should dismiss keyboard and prsent next screen
extension SelectUsernameController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text {
            
            let maxLength = 24
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            
            textField.text = text
            return newString.length <= maxLength
        }
        
        return true
    }
}
