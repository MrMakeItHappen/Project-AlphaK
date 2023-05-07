//
//  DeactivateAccountController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 5/7/23.
//

import UIKit

final class DeactivateAccountController: UIViewController {
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
        label.text = "Deactivate Account"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    private let deactivateContainer = UIView.createSettingsContainer()
    private let deactivateLabel = UILabel.createSettingsTitleLabel(with: "Deactivate this account?")
    private let deactivateChevron = UIImageView.createChevron()
    private let deactivateSubTitleLabel = UILabel.createSettingsSublabel(with: "")
    
    private let deactivateButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor(hexString: "FF5959")
        button.setTitle("Deactivate", for: .normal)
        button.titleLabel?.font = .segoeUISemiBold(size: 18)
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
extension DeactivateAccountController {
    private func configure() {
        self.view.backgroundColor = .white
        self.deactivateButton.addTarget(self, action: #selector(didTapDeactivate), for: .touchUpInside)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        self.deactivateSubTitleLabel.attributedText = NSMutableAttributedString(string: "If you deactivate your account:\n - No one can see your account or its content.\n - Kwiks will keep your data, so you can reactivate your account within 30 days.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}

//MARK: - Layout UI
extension DeactivateAccountController {
    private func layoutUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerY(to: self.customBackButton)
        self.titleLabel.centerXToSuperview()
        
        self.view.addSubview(self.deactivateContainer)
        self.deactivateContainer.topToBottom(of: self.customBackButton, offset: 35)
        self.deactivateContainer.leftToSuperview(offset: 6)
        self.deactivateContainer.rightToSuperview(offset: -6)
        
        self.deactivateContainer.addSubview(self.deactivateLabel)
        self.deactivateLabel.topToSuperview(offset: 20)
        self.deactivateLabel.leftToSuperview(offset: 16)
        
        self.deactivateContainer.addSubview(self.deactivateSubTitleLabel)
        self.deactivateSubTitleLabel.topToBottom(of: self.deactivateLabel, offset: 11)
        self.deactivateSubTitleLabel.leftToSuperview(offset: 16)
        self.deactivateSubTitleLabel.rightToSuperview(offset: -16)
        
        self.deactivateContainer.addSubview(self.deactivateButton)
        self.deactivateButton.topToBottom(of: self.deactivateSubTitleLabel, offset: 40)
        self.deactivateButton.left(to: self.deactivateSubTitleLabel)
        self.deactivateButton.right(to: self.deactivateSubTitleLabel)
        
        self.deactivateContainer.bottom(to: self.deactivateButton, offset: 30)
    }
}

//MARK: - Helpers
extension DeactivateAccountController {
    
}

//MARK: - @objc
extension DeactivateAccountController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //TODO: Upon deactivation. Log out user and return to Simple Login VC.
    @objc func didTapDeactivate() {
        let confirmVC = ConfirmationLinkController()
        confirmVC.isModalInPresentation = true
        confirmVC.entryPath = .deactivate
        self.present(confirmVC, animated: true)
    }
}
