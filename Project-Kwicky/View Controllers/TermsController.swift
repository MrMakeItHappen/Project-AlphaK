//
//  TermsController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/18/23.
//

import UIKit

final class TermsController: UIViewController {
    
    private let agreementLabel: UILabel = {
        let label = UILabel()
        label.text = "Agreement"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 16)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.5725490196, green: 0.5725490196, blue: 0.5725490196, alpha: 0.7)
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton.createCloseButton()
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return button
    }()
    
    private let termsLabel: UILabel = {
        let label = UILabel()
        label.text = "Terms of Service"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 38)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1)
        return label
    }()
    
    private lazy var acceptButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .interRegular(size: 16)
        
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .capsule
        configuration.attributedTitle = AttributedString("Confirm", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapAccept()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
        button.tintColor = .black
        button.layer.cornerRadius = 25
        button.height(50)
        button.isEnabled = false
        return button
    }()
    
    private lazy var checkmarkButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.kwiksGreen
        button.addTarget(self, action: #selector(didTapCheckmark), for: .touchUpInside)
        button.setImage(UIImage(named: "CheckmarkNotSelected"), for: .normal)
        button.height(20)
        button.width(20)
        return button
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "I agree with the"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 13)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private let bottomColorLabel: UILabel = {
        let label = UILabel()
        label.text = "Terms and Conditions"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 13)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksGreen
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.delaysContentTouches = false
        scrollView.clipsToBounds = true
        scrollView.showsVerticalScrollIndicator = true
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
    
    private let termsSectionOneHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem Ipsum"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interMedium(size: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private let termsSectionOneLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam/n/nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 14)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        return label
    }()
    
    private let termsSectionTwoHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem Ipsum"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interMedium(size: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private let termsSectionTwoLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 14)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        return label
    }()
    
    private let termsSectionThreeHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem Ipsum"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interMedium(size: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private let termsSectionThreeLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 14)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        return label
    }()
    
    private let termsSectionFourHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem Ipsum"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interMedium(size: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private let termsSectionFourLabel: UILabel = {
        let label = UILabel()
        label.text = "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 14)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        return label
    }()
    
    private let termsSectionFiveHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem Ipsum"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interMedium(size: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private let termsSectionFiveLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 14)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.layoutUI()
    }
}
//MARK: - Layout UI
extension TermsController {
    private func layoutUI() {
        self.view.addSubview(self.agreementLabel)
        self.agreementLabel.topToSuperview(offset: 30, usingSafeArea: true)
        self.agreementLabel.leftToSuperview(offset: 40)
        
        self.view.addSubview(self.closeButton)
        self.closeButton.rightToSuperview(offset: -40)
        self.closeButton.centerY(to: self.agreementLabel)
        
        self.view.addSubview(self.termsLabel)
        self.termsLabel.topToBottom(of: self.agreementLabel, offset: 10)
        self.termsLabel.left(to: self.agreementLabel)
        self.termsLabel.right(to: self.closeButton)
        
        self.view.addSubview(self.acceptButton)
        self.acceptButton.bottomToSuperview(offset: -50, usingSafeArea: true)
        self.acceptButton.left(to: self.agreementLabel)
        self.acceptButton.right(to: self.closeButton)
        
        self.view.addSubview(self.checkmarkButton)
        self.checkmarkButton.bottomToTop(of: self.acceptButton, offset: -30)
        self.checkmarkButton.left(to: self.acceptButton)
        
        self.view.addSubview(self.bottomLabel)
        self.bottomLabel.centerY(to: self.checkmarkButton)
        self.bottomLabel.leftToRight(of: self.checkmarkButton, offset: 20)
        
        self.view.addSubview(self.bottomColorLabel)
        self.bottomColorLabel.centerY(to: self.checkmarkButton)
        self.bottomColorLabel.leftToRight(of: self.bottomLabel, offset: 4)
        
        self.view.addSubview(self.scrollView)
        self.scrollView.topToBottom(of: self.termsLabel, offset: 46)
        self.scrollView.leftToSuperview(offset: 40)
        self.scrollView.rightToSuperview(offset: -40)
        self.scrollView.bottomToTop(of: self.bottomLabel, offset: -20)
        
        self.scrollView.addSubview(self.scrollViewContentView)
        self.scrollViewContentView.edgesToSuperview()
        self.scrollViewContentView.width(to: self.scrollView)
        
        self.scrollViewContentView.addSubview(self.termsSectionOneHeaderLabel)
        self.termsSectionOneHeaderLabel.topToSuperview()
        self.termsSectionOneHeaderLabel.leftToSuperview()
        
        self.scrollViewContentView.addSubview(self.termsSectionOneLabel)
        self.termsSectionOneLabel.topToBottom(of: self.termsSectionOneHeaderLabel, offset: 7)
        self.termsSectionOneLabel.left(to: self.termsSectionOneHeaderLabel)
        self.termsSectionOneLabel.rightToSuperview(offset: -30)
        
        self.scrollViewContentView.addSubview(self.termsSectionTwoHeaderLabel)
        self.termsSectionTwoHeaderLabel.topToBottom(of: self.termsSectionOneLabel, offset: 32)
        self.termsSectionTwoHeaderLabel.left(to: self.termsSectionOneLabel)
        self.termsSectionTwoHeaderLabel.right(to: self.termsSectionOneLabel)
        
        self.scrollViewContentView.addSubview(self.termsSectionTwoLabel)
        self.termsSectionTwoLabel.topToBottom(of: self.termsSectionTwoHeaderLabel, offset: 7)
        self.termsSectionTwoLabel.left(to: self.termsSectionOneLabel)
        self.termsSectionTwoLabel.right(to: self.termsSectionOneLabel)
        
        self.scrollViewContentView.addSubview(self.termsSectionThreeHeaderLabel)
        self.termsSectionThreeHeaderLabel.topToBottom(of: self.termsSectionTwoLabel, offset: 32)
        self.termsSectionThreeHeaderLabel.left(to: self.termsSectionOneLabel)
        self.termsSectionThreeHeaderLabel.right(to: self.termsSectionOneLabel)
        
        self.scrollViewContentView.addSubview(self.termsSectionThreeLabel)
        self.termsSectionThreeLabel.topToBottom(of: self.termsSectionThreeHeaderLabel, offset: 7)
        self.termsSectionThreeLabel.left(to: self.termsSectionOneLabel)
        self.termsSectionThreeLabel.right(to: self.termsSectionOneLabel)
        
        self.scrollViewContentView.addSubview(self.termsSectionFourHeaderLabel)
        self.termsSectionFourHeaderLabel.topToBottom(of: self.termsSectionThreeLabel, offset: 32)
        self.termsSectionFourHeaderLabel.left(to: self.termsSectionOneLabel)
        self.termsSectionFourHeaderLabel.right(to: self.termsSectionOneLabel)
        
        self.scrollViewContentView.addSubview(self.termsSectionFourLabel)
        self.termsSectionFourLabel.topToBottom(of: self.termsSectionFourHeaderLabel, offset: 7)
        self.termsSectionFourLabel.left(to: self.termsSectionOneLabel)
        self.termsSectionFourLabel.right(to: self.termsSectionOneLabel)
        
        self.scrollViewContentView.addSubview(self.termsSectionFiveHeaderLabel)
        self.termsSectionFiveHeaderLabel.topToBottom(of: self.termsSectionFourLabel, offset: 32)
        self.termsSectionFiveHeaderLabel.left(to: self.termsSectionOneLabel)
        self.termsSectionFiveHeaderLabel.right(to: self.termsSectionOneLabel)
        
        self.scrollViewContentView.addSubview(self.termsSectionFiveLabel)
        self.termsSectionFiveLabel.topToBottom(of: self.termsSectionFiveHeaderLabel, offset: 7)
        self.termsSectionFiveLabel.left(to: self.termsSectionOneLabel)
        self.termsSectionFiveLabel.right(to: self.termsSectionOneLabel)
        
        self.scrollViewContentView.bottom(to: self.termsSectionFiveLabel, offset: 10)
    }
}
//MARK: - @objc
extension TermsController {
    @objc func didTapClose() {
        print(#function)
        self.navigationController?.dismiss(animated: true)
    }
    
    @objc func didTapAccept() {
        print(#function)
    }
    
    @objc func didTapCheckmark(_ sender: UIButton) {
        print(#function)
        
        UIView.animate(withDuration: 0.15, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear, animations: {
                sender.transform = .identity
                sender.setImage(UIImage(named: "CheckmarkSelected"), for: .normal)
                sender.isUserInteractionEnabled = false
            }, completion: nil)
        }
        
        //Handle user agreed to terms here.
    }
}
