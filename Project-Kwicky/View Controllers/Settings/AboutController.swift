//
//  AboutController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/27/23.
//

import UIKit

final class AboutController: UIViewController {
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
        label.text = "About"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.height(136)
        imageView.width(128)
        imageView.layer.masksToBounds = true
        
        let image = UIImage(named: "KwiksLogo01")
        imageView.image = image
        return imageView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.delaysContentTouches = false
        scrollView.clipsToBounds = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private let scrollViewContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 0
        view.clipsToBounds = true
        return view
    }()
    
    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.text = "About Kwiks"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let aboutDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 16)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#848484")
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.10
        label.attributedText = NSMutableAttributedString(string: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indusbook.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private let termsLabel: UILabel = {
        let label = UILabel()
        label.text = "Terms of Service"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let termsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 16)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#848484")
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.10
        label.attributedText = NSMutableAttributedString(string: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private let privacyLabel: UILabel = {
        let label = UILabel()
        label.text = "Privacy Policy"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let privacyDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 16)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#848484")
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.10
        label.attributedText = NSMutableAttributedString(string: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}

//MARK: - Configure Controller
extension AboutController {
    private func configure() {
        self.view.backgroundColor = .white
    }
}

//MARK: - Layout UI
extension AboutController {
    private func layoutUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerY(to: self.customBackButton)
        self.titleLabel.centerXToSuperview()
        
        self.view.addSubview(self.logoImageView)
        self.logoImageView.topToBottom(of: self.titleLabel, offset: 55)
        self.logoImageView.centerXToSuperview()
        
        self.view.addSubview(self.scrollView)
        self.scrollView.topToBottom(of: self.logoImageView, offset: 40)
        self.scrollView.leftToSuperview(offset: 30)
        self.scrollView.rightToSuperview(offset: -30)
        self.scrollView.bottomToSuperview(usingSafeArea: true)

        self.scrollView.addSubview(self.scrollViewContentView)
        self.scrollViewContentView.edgesToSuperview()
        self.scrollViewContentView.width(to: self.scrollView)
        
        self.scrollViewContentView.addSubview(self.aboutLabel)
        self.aboutLabel.topToSuperview()
        self.aboutLabel.leftToSuperview()
        
        self.scrollViewContentView.addSubview(self.aboutDescriptionLabel)
        self.aboutDescriptionLabel.topToBottom(of: self.aboutLabel, offset: 10)
        self.aboutDescriptionLabel.leftToSuperview()
        self.aboutDescriptionLabel.rightToSuperview()
        
        self.scrollViewContentView.addSubview(self.termsLabel)
        self.termsLabel.topToBottom(of: self.aboutDescriptionLabel, offset: 30)
        self.termsLabel.leftToSuperview()
        self.termsLabel.rightToSuperview()
        
        self.scrollViewContentView.addSubview(self.termsDescriptionLabel)
        self.termsDescriptionLabel.topToBottom(of: self.termsLabel, offset: 10)
        self.termsDescriptionLabel.leftToSuperview()
        self.termsDescriptionLabel.rightToSuperview()
        
        self.scrollViewContentView.addSubview(self.privacyLabel)
        self.privacyLabel.topToBottom(of: self.termsDescriptionLabel, offset: 30)
        self.privacyLabel.leftToSuperview()
        self.privacyLabel.rightToSuperview()
        
        self.scrollViewContentView.addSubview(self.privacyDescriptionLabel)
        self.privacyDescriptionLabel.topToBottom(of: self.privacyLabel, offset: 10)
        self.privacyDescriptionLabel.leftToSuperview()
        self.privacyDescriptionLabel.rightToSuperview()
        
        self.scrollViewContentView.bottom(to: self.privacyDescriptionLabel, offset: 30)
    }
}

//MARK: - Helpers
extension AboutController {
    
}

//MARK: - @objc
extension AboutController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
