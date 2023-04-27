//
//  AccountController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/22/23.
//

import UIKit

final class AccountController: UIViewController {
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
        label.text = "Account"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        view.layer.cornerRadius = 9
        return view
    }()
    
    private let accountInfoLabel = UILabel.createSettingsLabel(with: "Account Information")
    private let passwordLabel = UILabel.createSettingsLabel(with: "Password")
    private let downloadLabel = UILabel.createSettingsLabel(with: "Download Your Data")
    private let deactivateLabel = UILabel.createSettingsLabel(with: "Deactivate Or Delete Account")
    
    private lazy var accountChevron = UIImageView.createChevron()
    private lazy var passwordChevron = UIImageView.createChevron()
    private lazy var downloadChevron = UIImageView.createChevron()
    private lazy var deactivateChevron = UIImageView.createChevron()
    
    private lazy var hiddenAccountButton = self.createHiddenButton(with: #selector(didTapAccountInfo))
    private lazy var hiddenPasswordButton = self.createHiddenButton(with: #selector(didTapPassword))
    private lazy var hiddenDownloadButton = self.createHiddenButton(with: #selector(didTapDownloadData))
    private lazy var hiddenDeactivateButton = self.createHiddenButton(with: #selector(didTapDeactivate))
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Get a copy of your KWIKS data"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#A9A9A9")
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.layoutUI()
    }
}
//MARK: - Layout UI
extension AccountController {
    private func layoutUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerY(to: self.customBackButton)
        self.titleLabel.centerXToSuperview()
        
        self.view.addSubview(self.containerView)
        self.containerView.topToBottom(of: self.customBackButton, offset: 35)
        self.containerView.leftToSuperview(offset: 6)
        self.containerView.rightToSuperview(offset: -6)
        
        self.containerView.addSubview(self.accountInfoLabel)
        self.accountInfoLabel.topToSuperview(offset: 25)
        self.accountInfoLabel.leftToSuperview(offset: 16)
        
        self.containerView.addSubview(self.accountChevron)
        self.accountChevron.centerY(to: self.accountInfoLabel)
        self.accountChevron.rightToSuperview(offset: -16)
        
        self.containerView.addSubview(self.hiddenAccountButton)
        self.hiddenAccountButton.top(to: self.accountInfoLabel, offset: -4)
        self.hiddenAccountButton.left(to: self.accountInfoLabel)
        self.hiddenAccountButton.bottom(to: self.accountInfoLabel, offset: 4)
        self.hiddenAccountButton.right(to: self.accountChevron)
        
        self.containerView.addSubview(self.passwordLabel)
        self.passwordLabel.topToBottom(of: self.accountInfoLabel, offset: 35)
        self.passwordLabel.left(to: self.accountInfoLabel)
        
        self.containerView.addSubview(self.passwordChevron)
        self.passwordChevron.centerY(to: self.passwordLabel)
        self.passwordChevron.right(to: self.accountChevron)
        
        self.containerView.addSubview(self.hiddenPasswordButton)
        self.hiddenPasswordButton.top(to: self.passwordLabel, offset: -4)
        self.hiddenPasswordButton.left(to: self.passwordLabel)
        self.hiddenPasswordButton.bottom(to: self.passwordLabel, offset: 4)
        self.hiddenPasswordButton.right(to: self.passwordChevron)
        
        self.containerView.addSubview(self.downloadLabel)
        self.downloadLabel.topToBottom(of: self.passwordLabel, offset: 35)
        self.downloadLabel.left(to: self.accountInfoLabel)

        self.containerView.addSubview(self.downloadChevron)
        self.downloadChevron.centerY(to: self.downloadLabel)
        self.downloadChevron.right(to: self.accountChevron)

        self.containerView.addSubview(self.hiddenDownloadButton)
        self.hiddenDownloadButton.top(to: self.downloadLabel, offset: -4)
        self.hiddenDownloadButton.left(to: self.downloadLabel)
        self.hiddenDownloadButton.bottom(to: self.downloadLabel, offset: 4)
        self.hiddenDownloadButton.right(to: self.accountChevron)
        
        self.containerView.addSubview(self.subTitleLabel)
        self.subTitleLabel.topToBottom(of: self.hiddenDownloadButton, offset: 4)
        self.subTitleLabel.left(to: self.downloadLabel, offset: 1)
        self.subTitleLabel.right(to: self.downloadChevron)
        
        self.containerView.addSubview(self.deactivateLabel)
        self.deactivateLabel.topToBottom(of: self.subTitleLabel, offset: 35)
        self.deactivateLabel.left(to: self.accountInfoLabel)

        self.containerView.addSubview(self.deactivateChevron)
        self.deactivateChevron.centerY(to: self.deactivateLabel)
        self.deactivateChevron.right(to: self.accountChevron)

        self.containerView.addSubview(self.hiddenDeactivateButton)
        self.hiddenDeactivateButton.top(to: self.deactivateLabel, offset: -4)
        self.hiddenDeactivateButton.left(to: self.deactivateLabel)
        self.hiddenDeactivateButton.bottom(to: self.deactivateLabel, offset: 4)
        self.hiddenDeactivateButton.right(to: self.accountChevron)
        
        self.containerView.bottom(to: self.hiddenDeactivateButton, offset: 30)
    }
}
//MARK: - Helpers
extension AccountController {
    private func createHiddenButton(with selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
}
//MARK: - @objc
extension AccountController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapAccountInfo() {
        print(#function)
    }
    
    @objc func didTapPassword() {
        print(#function)
    }
    
    @objc func didTapDownloadData() {
        print(#function)
    }
    
    @objc func didTapDeactivate() {
        print(#function)
    }
}
