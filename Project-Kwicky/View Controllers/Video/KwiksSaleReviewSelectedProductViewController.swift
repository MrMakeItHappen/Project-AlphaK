//
//  KwiksSaleReviewSelectedProductViewController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/21/23.
//

import UIKit

final class KwiksSaleReviewSelectedProductViewController: UIViewController {
    var selectedItem: KwiksSaleItem!
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        
        let image = UIImage(named: "ProductReviewBackground")
        imageView.image = image
        return imageView
    }()
    
    private lazy var customBackButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.kwiksTextBlack
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        button.height(23)
        button.width(33)
        button.setImage(UIImage(named: "KwiksBackArrow"), for: .normal)
        return button
    }()
    
    private let kwikLabel: UILabel = {
        let label = UILabel()
        label.text = "Kwik"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let saleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sale"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#467C05")
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .segoeUISemiBold(size: 15)
        
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .capsule
        configuration.attributedTitle = AttributedString("Next", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapNext()
        }))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.backgroundColor = .kwiksGreen
        button.tintColor = .black
        button.height(50)
        return button
    }()
    
    private let chooseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 36)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.85
        label.attributedText = NSMutableAttributedString(string: "Review your \nproduct", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        return label
    }()
    
    private let productContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.layer.cornerRadius = 24
        view.backgroundColor = .white
        view.height(430)
        return view
    }()
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(150)
        imageView.width(150)
        
        let image = UIImage(named: "ProductPlaceholder02")
        imageView.image = image
        return imageView
    }()
    
    private let itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let itemPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$999.99"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 24)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#53CF53")
        return label
    }()
    
    private let itemDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 14)
        label.numberOfLines = 4
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#515158")
        return label
    }()
    
    private let estimateContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.kwiksGreen.cgColor
        view.layer.borderWidth = 1.5
        view.backgroundColor = .clear
        view.height(65)
        return view
    }()
    
    private let estimateLabel: UILabel = {
        let label = UILabel()
        label.text = "Estimated Earning Per Sale: $999.99"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Configure Controller
extension KwiksSaleReviewSelectedProductViewController {
    private func configure() {
        self.view.backgroundColor = UIColor.black
        self.itemNameLabel.text = self.selectedItem.productName
    }
}

//MARK: - Layout UI
extension KwiksSaleReviewSelectedProductViewController {
    private func layoutUI() {
        self.view.addSubview(self.backgroundImageView)
        self.backgroundImageView.edgesToSuperview()
        
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.kwikLabel)
        self.kwikLabel.centerY(to: self.customBackButton, offset: -2)
        self.kwikLabel.leftToRight(of: self.customBackButton, offset: 18)
        
        self.view.addSubview(self.saleLabel)
        self.saleLabel.leftToRight(of: self.kwikLabel)
        self.saleLabel.centerY(to: self.kwikLabel)
        
        self.view.addSubview(self.nextButton)
        self.nextButton.bottomToSuperview(offset: -10, usingSafeArea: true)
        self.nextButton.leftToSuperview(offset: 30)
        self.nextButton.rightToSuperview(offset: -30)
        
        self.view.addSubview(self.chooseLabel)
        self.chooseLabel.topToBottom(of: self.kwikLabel, offset: 21)
        self.chooseLabel.leftToSuperview(offset: 30)
        self.chooseLabel.rightToSuperview(offset: -30)
        
        self.view.addSubview(self.productContainerView)
        self.productContainerView.topToBottom(of: self.chooseLabel, offset: 30)
        self.productContainerView.leftToSuperview(offset: 30)
        self.productContainerView.rightToSuperview(offset: -30)
        
        self.productContainerView.addSubview(self.itemImageView)
        self.itemImageView.centerXToSuperview()
        self.itemImageView.topToSuperview(offset: 32)
        
        self.productContainerView.addSubview(self.itemNameLabel)
        self.itemNameLabel.leftToSuperview(offset: 24)
        self.itemNameLabel.topToBottom(of: self.itemImageView, offset: 15)
        self.itemNameLabel.rightToSuperview(offset: -110)
        
        self.productContainerView.addSubview(self.itemPriceLabel)
        itemPriceLabel.rightToSuperview(offset: -24)
        itemPriceLabel.centerY(to: self.itemNameLabel)
        
        self.productContainerView.addSubview(self.estimateContainerView)
        self.estimateContainerView.bottomToSuperview(offset: -28)
        self.estimateContainerView.leftToSuperview(offset: 24)
        self.estimateContainerView.rightToSuperview(offset: -24)
        
        self.estimateContainerView.addSubview(self.estimateLabel)
        self.estimateLabel.leftToSuperview(offset: 20)
        self.estimateLabel.rightToSuperview(offset: -20)
        self.estimateLabel.centerYToSuperview()
        
        self.productContainerView.addSubview(self.itemDescriptionLabel)
        self.itemDescriptionLabel.left(to: self.itemNameLabel)
        self.itemDescriptionLabel.right(to: self.itemPriceLabel)
        self.itemDescriptionLabel.topToBottom(of: self.itemNameLabel, offset: -10)
        self.itemDescriptionLabel.bottomToTop(of: self.estimateContainerView, offset: 0)
    }
}

//MARK: - @objc
extension KwiksSaleReviewSelectedProductViewController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapNext() {
        print(#function)
    }
}
