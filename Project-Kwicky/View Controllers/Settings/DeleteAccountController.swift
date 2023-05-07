//
//  DeleteAccountController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 5/7/23.
//

import UIKit

final class DeleteAccountController: UIViewController {
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
        label.text = "Delete Account"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    private let deleteContainer = UIView.createSettingsContainer()
    private let deleteLabel = UILabel.createSettingsTitleLabel(with: "Delete this account permanently?")
    private let deleteChevron = UIImageView.createChevron()
    private let deleteSubTitleLabel = UILabel.createSettingsSublabel(with: "")
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor(hexString: "FF5959")
        button.setTitle("Delete Account", for: .normal)
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
extension DeleteAccountController {
    private func configure() {
        self.view.backgroundColor = .white
        self.deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        self.deleteSubTitleLabel.attributedText = NSMutableAttributedString(string: "If you delete your account:\n - Kwiks will keep your data, so you can reactivate your account within 30 days.\n - After 30 days, this account will be deleted permanently.\n - Permanent deletion cannot be undone.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}

//MARK: - Layout UI
extension DeleteAccountController {
    private func layoutUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerY(to: self.customBackButton)
        self.titleLabel.centerXToSuperview()
        
        self.view.addSubview(self.deleteContainer)
        self.deleteContainer.topToBottom(of: self.customBackButton, offset: 35)
        self.deleteContainer.leftToSuperview(offset: 6)
        self.deleteContainer.rightToSuperview(offset: -6)
        
        self.deleteContainer.addSubview(self.deleteLabel)
        self.deleteLabel.topToSuperview(offset: 20)
        self.deleteLabel.leftToSuperview(offset: 16)
        
        self.deleteContainer.addSubview(self.deleteSubTitleLabel)
        self.deleteSubTitleLabel.topToBottom(of: self.deleteLabel, offset: 11)
        self.deleteSubTitleLabel.leftToSuperview(offset: 16)
        self.deleteSubTitleLabel.rightToSuperview(offset: -16)
        
        self.deleteContainer.addSubview(self.deleteButton)
        self.deleteButton.topToBottom(of: self.deleteSubTitleLabel, offset: 40)
        self.deleteButton.left(to: self.deleteSubTitleLabel)
        self.deleteButton.right(to: self.deleteSubTitleLabel)
        
        self.deleteContainer.bottom(to: self.deleteButton, offset: 30)
    }
}

//MARK: - Helpers
extension DeleteAccountController {
    
}

//MARK: - @objc
extension DeleteAccountController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //TODO: Upon deletion. Log out user and return to Simple Login VC.
    @objc func didTapDelete() {
        let confirmVC = ConfirmationLinkController()
        confirmVC.isModalInPresentation = true
        confirmVC.entryPath = .delete
        self.present(confirmVC, animated: true)
    }
}
