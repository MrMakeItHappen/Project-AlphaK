//
//  InfoUpdatedPopUpView.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 5/1/23.
//

import UIKit

final class InfoUpdatedPopUpView: UIView {
    private var singleTapGesture = UITapGestureRecognizer()
    private let popUpHeight: CGFloat = 358
    
    lazy var entryPath: PathType = .none {
        didSet {
            switch self.entryPath {
            case .phone:
                self.subLabel.text = "Your phone number has been updated successfully!"
                
            case .email:
                self.subLabel.text = "Your email has been updated successfully!"
                
            case .password:
                self.subLabel.text = "Your password has been updated successfully!"
                
            case .deactivate:
                self.subLabel.text = "Your account has been deactivated successfully!"
                
            case .delete:
                self.subLabel.text = "Ohh! Hope to see you soon..."
                
            case .none:
                break
            }
        }
    }
    
    weak var homeController: ConfirmationLinkController?
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.kwiksPopupTint
        view.isUserInteractionEnabled = true
        view.alpha = 0.0
        return view
    }()
    
    private let contentContainer : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 24
        return view
    }()
    
    private let successImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.layer.masksToBounds = true
        imageView.height(113)
        imageView.width(120)
        
        let image = UIImage(named: "UpdatePopUpImage")
        imageView.image = image
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Success!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 16)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.kwiksGreen
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .segoeUIBold(size: 16)
        button.layer.cornerRadius = 25
        button.height(50)
        button.width(132)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        self.layoutUI()
    }
    
    private func configure() {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = true
        
        self.singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToClose))
        self.continueButton.addTarget(self, action: #selector(tapToClose), for: .touchUpInside)
        self.backgroundView.addGestureRecognizer(self.singleTapGesture)
        
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn) {
            self.backgroundView.alpha = 1.0
        } completion: { complete in
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear) {
                self.contentContainer.frame = CGRect(x: ((_globalDeviceWidth - (_globalDeviceWidth - 60)) / 2), y: (0), width: _globalDeviceWidth - 60, height: self.popUpHeight)
                self.contentContainer.center.y = self.center.y
                self.layoutIfNeeded()
            }
        }
    }
    
    private func layoutUI() {
        self.addSubview(self.backgroundView)
        self.backgroundView.edgesToSuperview()
        
        self.addSubview(self.contentContainer)
        self.contentContainer.frame = CGRect(x: ((_globalDeviceWidth - (_globalDeviceWidth - 60)) / 2), y: _globalDeviceHeight, width: _globalDeviceWidth - 60, height: self.popUpHeight)
        
        self.contentContainer.addSubview(self.successImageView)
        self.successImageView.topToSuperview(offset: 40)
        self.successImageView.centerXToSuperview()
        
        self.contentContainer.addSubview(self.titleLabel)
        self.titleLabel.centerXToSuperview()
        self.titleLabel.topToBottom(of: self.successImageView, offset: 15)
        
        self.contentContainer.addSubview(self.subLabel)
        self.subLabel.topToBottom(of: self.titleLabel, offset: 10)
        self.subLabel.rightToSuperview(offset: -69)
        self.subLabel.leftToSuperview(offset: 69)
        
        self.contentContainer.addSubview(self.continueButton)
        self.continueButton.topToBottom(of: self.subLabel, offset: 20)
        self.continueButton.centerXToSuperview()
    }
    
    @objc func tapToClose() {
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut) {
            self.contentContainer.frame = CGRect(x: ((_globalDeviceWidth - (_globalDeviceWidth - 60)) / 2), y: _globalDeviceHeight, width: _globalDeviceWidth - 60, height: self.popUpHeight)
            self.backgroundView.alpha = 0.0
            self.layoutIfNeeded()
        } completion: { complete in
            self.homeController?.didTapClose()
            self.removeFromSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
