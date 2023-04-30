//
//  SecurityController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/30/23.
//

import UIKit

final class SecurityController: UIViewController {
    var twoFactorMethod: VerifyType = .none {
        
        didSet {
            switch self.twoFactorMethod {
            case .none:
                self.twoFactorStatus.text = "Turn On"
                
            case .sms:
                self.twoFactorStatus.text = "SMS"
                
            case .email:
                self.twoFactorStatus.text = "Email"
            }
        }
    }

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
        label.text = "Security"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    private let twoFactorContainer = UIView.createSettingsContainer()
    private let twoFactorTitleLabel = UILabel.createSettingsLabel(with: "Two Factor Authentication")
    private let twoFactorSubtitleLabel = UILabel.createSettingsSublabel(with: "We will ask for a code for every unrecognised device or browser login.")
    private let twoFactorChevron = UIImageView.createChevron()
    private lazy var hiddenTwoFactorButton = UIButton.createHiddenButton(with: #selector(didTapTwoFactor), for: self)
    
    private let twoFactorStatus: UILabel = {
        let label = UILabel()
        label.text = "Turn On"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#848484")
        return label
    }()
    
    private let unrecognisedContainer = UIView.createSettingsContainer()
    private let unrecognisedTitleLabel = UILabel.createSettingsLabel(with: "Unrecognised Login Alert")
    private let unrecognisedSubtitleLabel = UILabel.createSettingsSublabel(with: "We will notify you if anyone logs in from a device or browser you don't usually use.")
    private lazy var unrecognisedToggle = UIButton.createSettingsToggleButton(with: #selector(didTapAlertMe), for: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Configure Controller
extension SecurityController {
    private func configure() {
        self.view.backgroundColor = .white
    }
}

//MARK: - Layout UI
extension SecurityController {
    private func layoutUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerY(to: self.customBackButton)
        self.titleLabel.centerXToSuperview()
        
        self.view.addSubview(self.twoFactorContainer)
        self.twoFactorContainer.topToBottom(of: self.titleLabel, offset: 25)
        self.twoFactorContainer.leftToSuperview()
        self.twoFactorContainer.rightToSuperview()
        
        self.twoFactorContainer.addSubview(self.twoFactorTitleLabel)
        self.twoFactorTitleLabel.topToSuperview(offset: 20)
        self.twoFactorTitleLabel.leftToSuperview(offset: 14)
        
        self.twoFactorContainer.addSubview(self.twoFactorChevron)
        self.twoFactorChevron.centerY(to: self.twoFactorTitleLabel)
        self.twoFactorChevron.rightToSuperview(offset: -15)
        
        self.twoFactorContainer.addSubview(self.twoFactorStatus)
        self.twoFactorStatus.rightToLeft(of: self.twoFactorChevron, offset: -10)
        self.twoFactorStatus.centerY(to: self.twoFactorChevron)
        
        self.twoFactorContainer.addSubview(self.twoFactorSubtitleLabel)
        self.twoFactorSubtitleLabel.topToBottom(of: self.twoFactorTitleLabel, offset: 10)
        self.twoFactorSubtitleLabel.left(to: self.twoFactorTitleLabel)
        self.twoFactorSubtitleLabel.right(to: self.twoFactorChevron)
        
        self.twoFactorContainer.addSubview(self.hiddenTwoFactorButton)
        self.hiddenTwoFactorButton.top(to: self.twoFactorStatus, offset: -2)
        self.hiddenTwoFactorButton.left(to: self.twoFactorStatus, offset: -2)
        self.hiddenTwoFactorButton.bottom(to: self.twoFactorStatus, offset: 2)
        self.hiddenTwoFactorButton.right(to: self.twoFactorChevron, offset: 2)
        
        self.twoFactorContainer.bottom(to: self.twoFactorSubtitleLabel, offset: 20)
        
        self.view.addSubview(self.unrecognisedContainer)
        self.unrecognisedContainer.topToBottom(of: self.twoFactorContainer, offset: 20)
        self.unrecognisedContainer.leftToSuperview()
        self.unrecognisedContainer.rightToSuperview()
        
        self.unrecognisedContainer.addSubview(self.unrecognisedTitleLabel)
        self.unrecognisedTitleLabel.topToSuperview(offset: 20)
        self.unrecognisedTitleLabel.leftToSuperview(offset: 14)
        
        self.unrecognisedContainer.addSubview(self.unrecognisedToggle)
        self.unrecognisedToggle.rightToSuperview(offset: -14)
        self.unrecognisedToggle.centerY(to: self.unrecognisedTitleLabel)
        
        self.unrecognisedContainer.addSubview(self.unrecognisedSubtitleLabel)
        self.unrecognisedSubtitleLabel.topToBottom(of: self.unrecognisedTitleLabel, offset: 10)
        self.unrecognisedSubtitleLabel.left(to: self.unrecognisedTitleLabel)
        self.unrecognisedSubtitleLabel.right(to: self.unrecognisedToggle)
        
        self.unrecognisedContainer.bottom(to: self.unrecognisedSubtitleLabel, offset: 20)
    }
}

//MARK: - Helpers
extension SecurityController {
    
}

//MARK: - @objc
extension SecurityController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapTwoFactor() {
        let popUpVC = TwoFactorPopUpController()
        popUpVC.modalPresentationStyle = .overCurrentContext
        popUpVC.homeController = self
        popUpVC.method = self.twoFactorMethod
        
        self.navigationController?.present(popUpVC, animated: true)
    }
    
    @objc func didTapAlertMe() {
        print(#function)
        self.unrecognisedToggle.isSelected.toggle()
    }
}
