//
//  DeleteOrDeactivateController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 5/7/23.
//

import UIKit

final class DeleteOrDeactivateController: UIViewController {
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
        label.text = "Delete or Deactivate"
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
    private let deactivateLabel = UILabel.createSettingsTitleLabel(with: "Deactivate account?")
    private let deactivateChevron = UIImageView.createChevron()
    private let deactivateSubTitleLabel = UILabel.createSettingsSublabel(with: "No one can see your account including its content.\nYou can reactivate your account anytime.")
    private lazy var hiddenDeactivateButton = UIButton.createHiddenButton(with: #selector(didTapDeactivate), for: self)
    
    private let deleteContainer = UIView.createSettingsContainer()
    private let deleteLabel = UILabel.createSettingsTitleLabel(with: "Delete account permanently?")
    private let deleteChevron = UIImageView.createChevron()
    private let deleteSubTitleLabel = UILabel.createSettingsSublabel(with: "Your account and content will be deleted \npermanently. You may cancel the deletion request \nand reactive your account within 30 days.")
    private lazy var hiddenDeleteButton = UIButton.createHiddenButton(with: #selector(didTapDelete), for: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Configure Controller
extension DeleteOrDeactivateController {
    private func configure() {
        self.view.backgroundColor = .white
    }
}

//MARK: - Layout UI
extension DeleteOrDeactivateController {
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
        
        self.deactivateContainer.addSubview(self.deactivateChevron)
        self.deactivateChevron.centerY(to: self.deactivateLabel)
        self.deactivateChevron.rightToSuperview(offset: -16)
        
        self.deactivateContainer.addSubview(self.deactivateSubTitleLabel)
        self.deactivateSubTitleLabel.topToBottom(of: self.deactivateLabel, offset: 11)
        self.deactivateSubTitleLabel.left(to: self.deactivateLabel, offset: 1)
        self.deactivateSubTitleLabel.right(to: self.deactivateChevron)
        
        self.deactivateContainer.addSubview(self.hiddenDeactivateButton)
        self.hiddenDeactivateButton.edgesToSuperview()
        
        self.deactivateContainer.bottom(to: self.deactivateSubTitleLabel, offset: 30)
        
        self.view.addSubview(self.deleteContainer)
        self.deleteContainer.topToBottom(of: self.deactivateContainer, offset: 20)
        self.deleteContainer.left(to: self.deactivateContainer)
        self.deleteContainer.right(to: self.deactivateContainer)
        
        self.deleteContainer.addSubview(self.deleteLabel)
        self.deleteLabel.topToSuperview(offset: 20)
        self.deleteLabel.leftToSuperview(offset: 16)
        
        self.deleteContainer.addSubview(self.deleteChevron)
        self.deleteChevron.centerY(to: self.deleteLabel)
        self.deleteChevron.rightToSuperview(offset: -16)
        
        self.deleteContainer.addSubview(self.deleteSubTitleLabel)
        self.deleteSubTitleLabel.topToBottom(of: self.deleteLabel, offset: 11)
        self.deleteSubTitleLabel.left(to: self.deleteLabel, offset: 1)
        self.deleteSubTitleLabel.right(to: self.deleteChevron)
        
        self.deleteContainer.addSubview(self.hiddenDeleteButton)
        self.hiddenDeleteButton.edgesToSuperview()
        
        self.deleteContainer.bottom(to: self.deleteSubTitleLabel, offset: 30)
    }
}

//MARK: - Helpers
extension DeleteOrDeactivateController {
    
}

//MARK: - @objc
extension DeleteOrDeactivateController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapDeactivate() {
        let deactivateVC = DeactivateAccountController()
        self.navigationController?.pushViewController(deactivateVC, animated: true)
    }
    
    @objc func didTapDelete() {
        let deleteVC = DeleteAccountController()
        self.navigationController?.pushViewController(deleteVC, animated: true)
    }
}
