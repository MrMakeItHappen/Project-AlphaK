//
//  SignUpDetailController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/11/23.
//

import UIKit

final class SignUpDetailController: UIViewController, UITextFieldDelegate {
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
    
    private lazy var fullNameTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        let placeholder = "ex. Kwiks App"
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addGradientBackground()
        self.layoutUI()
    }

}
//MARK: - Configure Controller
extension SignUpDetailController {
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
        self.titleLabel.topToSuperview(offset: 60)
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
        
        self.loginContainerView.addSubview(self.fullNameTextField)
        self.fullNameTextField.topToBottom(of: self.detailsLabel, offset: 34)
        self.fullNameTextField.leftToSuperview(offset: 40)
        self.fullNameTextField.rightToSuperview(offset: -40)
        
        self.loginContainerView.addSubview(self.fullNameLabel)
        self.fullNameLabel.top(to: self.fullNameTextField, offset: -8)
        self.fullNameLabel.left(to: self.fullNameTextField, offset: 22)
    }
}
