//
//  PrivacyController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/27/23.
//

import UIKit

final class PrivacyController: UIViewController {
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
        label.text = "Privacy"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    //Private Account Section
    private let privateContainerView = UIView.createSettingsContainer()
    private let privateLabel = UILabel.createSettingsLabel(with: "Private Account")
    private let privateSublabel = UILabel.createSettingsSublabel(with: "Only friends will be able to view your videos.")
    private lazy var privateToggle = UIButton.createSettingsToggleButton(with: #selector(didTapPrivate), for: self)
    
    //Activity Status Section
    private let activityContainerView = UIView.createSettingsContainer()
    
    //Interactions Section
    private let interactionsHeader = UILabel.createSettingsHeaderLabel(with: "Interactions")
    private let interactionsContainerView = UIView.createSettingsContainer()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }

}
//MARK: - Configure Controller
extension PrivacyController {
    private func configure() {
        self.view.backgroundColor = .white
    }
}

//MARK: - Layout UI
extension PrivacyController {
    private func layoutUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerY(to: self.customBackButton)
        self.titleLabel.centerXToSuperview()
    }
}

//MARK: - Helpers
extension PrivacyController {
    
}

//MARK: - @objc
extension PrivacyController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapPrivate() {
        print(#function)
    }
    
    @objc func didTapActivity() {
        print(#function)
    }
    
    @objc func didTapPost() {
        print(#function)
    }
    
    @objc func didTapComments() {
        print(#function)
    }
    
    @objc func didTapMentions() {
        print(#function)
    }
    
    @objc func didTapDirect() {
        print(#function)
    }
}
