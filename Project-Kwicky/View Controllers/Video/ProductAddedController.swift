//
//  ProductAddedController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/23/23.
//

import UIKit

final class ProductAddedController: UIViewController {
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 22
        view.height(350)
        return view
    }()
    
    private lazy var continueButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .segoeUIBold(size: 15)
        
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .capsule
        configuration.attributedTitle = AttributedString("Continue", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapContinue()
        }))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.backgroundColor = .kwiksGreen
        button.tintColor = .white
        button.height(50)
        button.width(172)
        return button
    }()
    
    private let confettiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(98)
        imageView.width(84)
        
        let image = UIImage(named: "ConfettiIcon")
        imageView.image = image
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Product Added Successfully!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.text = "Your selected product has been linked with your video."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 16)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#686868")
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.layoutUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    private func layoutUI() {
        self.view.addSubview(self.containerView)
        self.containerView.leftToSuperview(offset: 40)
        self.containerView.rightToSuperview(offset: -40)
        self.containerView.centerXToSuperview()
        self.containerView.centerYToSuperview()
        
        self.containerView.addSubview(self.continueButton)
        self.continueButton.bottomToSuperview(offset: -36)
        self.continueButton.centerXToSuperview()
        
        self.containerView.addSubview(self.confettiImageView)
        self.confettiImageView.topToSuperview(offset: 38)
        self.confettiImageView.centerXToSuperview()
        
        self.containerView.addSubview(self.titleLabel)
        self.titleLabel.topToBottom(of: self.confettiImageView, offset: 10)
        self.titleLabel.rightToSuperview(offset: -42)
        self.titleLabel.leftToSuperview(offset: 42)
        
        self.containerView.addSubview(self.subLabel)
        self.subLabel.topToBottom(of: self.titleLabel, offset: 10)
        self.subLabel.leftToSuperview(offset: 46)
        self.subLabel.rightToSuperview(offset: -46)
    }
}
//MARK: - @objc
extension ProductAddedController {
    @objc func didTapContinue() {
        self.dismiss(animated: true)
    }
}
