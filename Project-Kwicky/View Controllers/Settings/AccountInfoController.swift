//
//  AccountInfoController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 5/1/23.
//

import UIKit

final class AccountInfoController: UIViewController {
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
        label.text = "Account information"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    private let infoContainer = UIView.createSettingsContainer()
    
    private let phoneNumberHeaderLabel = UILabel.createSettingsTitleLabel(with: "Phone Number")
    private let phoneNumberSubLabel = UILabel.createSettingsSublabel(with: _userPhoneNumber!)
    private let phoneNumberChevron = UIImageView.createChevron()
    private lazy var hiddenPhoneNumberButton = UIButton.createHiddenButton(with: #selector(didTapPhoneNumber), for: self)
    
    private let emailHeaderLabel = UILabel.createSettingsTitleLabel(with: "Email")
    private let emailSubLabel = UILabel.createSettingsSublabel(with: _userEmailAddress!)
    private let emailChevron = UIImageView.createChevron()
    private lazy var hiddenEmailButton = UIButton.createHiddenButton(with: #selector(didTapEmail), for: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.phoneNumberSubLabel.text = _userPhoneNumber
        self.emailSubLabel.text = _userEmailAddress
    }
}
//MARK: - Configure Controller
extension AccountInfoController {
    private func configure() {
        self.view.backgroundColor = .white
    }
}

//MARK: - Layout UI
extension AccountInfoController {
    private func layoutUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerY(to: self.customBackButton)
        self.titleLabel.centerXToSuperview()
        
        self.view.addSubview(self.infoContainer)
        self.infoContainer.topToBottom(of: self.customBackButton, offset: 35)
        self.infoContainer.leftToSuperview(offset: 6)
        self.infoContainer.rightToSuperview(offset: -6)
        
        self.infoContainer.addSubview(self.phoneNumberHeaderLabel)
        self.phoneNumberHeaderLabel.topToSuperview(offset: 25)
        self.phoneNumberHeaderLabel.leftToSuperview(offset: 16)
        
        self.infoContainer.addSubview(self.phoneNumberChevron)
        self.phoneNumberChevron.centerY(to: self.phoneNumberHeaderLabel)
        self.phoneNumberChevron.rightToSuperview(offset: -16)
        
        self.infoContainer.addSubview(self.phoneNumberSubLabel)
        self.phoneNumberSubLabel.topToBottom(of: self.phoneNumberHeaderLabel, offset: 5)
        self.phoneNumberSubLabel.left(to: self.phoneNumberHeaderLabel)
        self.phoneNumberSubLabel.right(to: self.phoneNumberChevron)
        
        self.infoContainer.addSubview(self.hiddenPhoneNumberButton)
        self.hiddenPhoneNumberButton.top(to: self.phoneNumberHeaderLabel)
        self.hiddenPhoneNumberButton.bottom(to: self.phoneNumberSubLabel)
        self.hiddenPhoneNumberButton.left(to: self.phoneNumberHeaderLabel)
        self.hiddenPhoneNumberButton.right(to: self.phoneNumberChevron)
        
        self.infoContainer.addSubview(self.emailHeaderLabel)
        self.emailHeaderLabel.topToBottom(of: self.phoneNumberSubLabel, offset: 30)
        self.emailHeaderLabel.left(to: self.phoneNumberHeaderLabel)
        
        self.infoContainer.addSubview(self.emailChevron)
        self.emailChevron.centerY(to: self.emailHeaderLabel)
        self.emailChevron.rightToSuperview(offset: -16)
        
        self.infoContainer.addSubview(self.emailSubLabel)
        self.emailSubLabel.topToBottom(of: self.emailHeaderLabel, offset: 5)
        self.emailSubLabel.left(to: self.emailHeaderLabel)
        self.emailSubLabel.right(to: self.emailChevron)
        
        self.infoContainer.addSubview(self.hiddenEmailButton)
        self.hiddenEmailButton.top(to: self.emailHeaderLabel)
        self.hiddenEmailButton.bottom(to: self.emailSubLabel)
        self.hiddenEmailButton.left(to: self.emailHeaderLabel)
        self.hiddenEmailButton.right(to: self.emailChevron)
        
        self.infoContainer.bottom(to: self.emailSubLabel, offset: 20)
    }
}

//MARK: - Helpers
extension AccountInfoController {
    
}

//MARK: - @objc
extension AccountInfoController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapPhoneNumber() {
        let editPhoneVC = EditPhoneNumberController()
        self.navigationController?.pushViewController(editPhoneVC, animated: true)
    }
    
    @objc func didTapEmail() {
        let editEmailVC = EditEmailController()
        self.navigationController?.pushViewController(editEmailVC, animated: true)
    }
}
