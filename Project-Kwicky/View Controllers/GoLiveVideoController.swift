//
//  GoLiveVideoController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/17/23.
//

import UIKit

final class GoLiveVideoController: UIViewController {
    var currentLiveVideo: KwiksVideo?
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.setImage(UIImage(named: "Go Live Close Button"), for: .normal)
        button.width(40)
        button.height(40)
        return button
    }()
    
    private let hostContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.height(50)
        view.width(160)
        view.layer.cornerRadius = 24
        return view
    }()
    
    private let hostImageView: UIImageView = {
        let imageView = UIImageView()
        let imageSize: CGFloat = 38
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.height(imageSize)
        imageView.width(imageSize)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize / 2
        imageView.layer.borderColor = UIColor.kwiksGreen.cgColor
        imageView.layer.borderWidth = 1
        
        let image = UIImage(named: "VideoSoundPlaceholderImage")
        imageView.image = image
        return imageView
    }()
    
    private let hostNameLabel: UILabel = {
        let label = UILabel()
        label.text = "@LazySunday69420"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let hostVerifiedImageView: UIImageView = {
        let imageView = UIImageView()
        let imageSize: CGFloat = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.height(imageSize)
        imageView.width(imageSize)
        imageView.layer.masksToBounds = true
        
        let image = UIImage(named: "VerifiedKwiksMemberIcon")
        imageView.image = image
        return imageView
    }()
    
    private let liveView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(hexString: "#FF0000", alpha: 1)
        view.height(14)
        view.width(37)
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let liveLabel: UILabel = {
        let label = UILabel()
        label.text = "LIVE"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 11)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    private let viewCountIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.height(11)
        imageView.width(11)
        
        let image = UIImage(named: "ViewersIcon")
        imageView.image = image
        return imageView
    }()
    
    private let viewersLabel: UILabel = {
        let label = UILabel()
        label.text = "999M"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let firstPlaceContributorImageView: UIImageView = {
        let imageView = UIImageView()
        let imageSize: CGFloat = 40
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.height(imageSize)
        imageView.width(imageSize)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize / 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1.5
        
        let image = UIImage(named: "FemalePlaceholder")
        imageView.image = image
        return imageView
    }()
    
    private let firstPlaceCrownImageView: UIImageView = {
        let imageView = UIImageView()
        let imageSize: CGFloat = 18
        let image = UIImage(named: "TopContributorIcon")
        
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.height(imageSize)
        imageView.width(imageSize)
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let secondPlaceContributorImageView: UIImageView = {
        let imageView = UIImageView()
        let imageSize: CGFloat = 40
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.height(imageSize)
        imageView.width(imageSize)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize / 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1.5
        
        let image = UIImage(named: "MalePlaceholder")
        imageView.image = image
        return imageView
    }()
    
    private let earnedAmountView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.layer.cornerRadius = 12
        view.height(25)
        view.width(88)
        return view
    }()
    
    private let moneySignImageView: UIImageView = {
        let imageView = UIImageView()
        let imageSize: CGFloat = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.height(imageSize)
        imageView.width(imageSize)
        imageView.layer.masksToBounds = true
        
        let image = UIImage(named: "KwiksMoneySymbol")
        imageView.image = image
        return imageView
    }()
    
    private let earnedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "999999"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.height(10)
        imageView.width(10)
        
        let image = UIImage(named: "GreyNextIcon")
        imageView.image = image
        return imageView
    }()
    
    private let hiddenEarnedAmountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let commentContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.layer.cornerRadius = 45 / 2
        view.height(45)
        return view
    }()
    
    private let commentImageView: UIImageView = {
        let imageView = UIImageView()
        let imageSize: CGFloat = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.height(imageSize)
        imageView.width(imageSize)
        imageView.layer.masksToBounds = true
        
        let image = UIImage(named: "CommentTextFieldIcon")
        imageView.image = image
        return imageView
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "Say Something..."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let sendMoneyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.setImage(UIImage(named: "SendMoneyIcon"), for: .normal)
        button.width(45)
        button.height(45)
        return button
    }()
    
    private let sendCommentContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.layer.cornerRadius = 45 / 2
        view.height(45)
        view.width(45)
        return view
    }()
    
    private let sendCommentImageView: UIImageView = {
        let imageView = UIImageView()
        let imageSize: CGFloat = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.height(imageSize)
        imageView.width(imageSize)
        imageView.layer.masksToBounds = true
        
        let image = UIImage(named: "SendCommentIcon")
        imageView.image = image
        return imageView
    }()
    
    private let hiddenSendCommentButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private lazy var commentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 292, height: 46)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(GoLiveCommentCollectionViewCell.self, forCellWithReuseIdentifier: GoLiveCommentCollectionViewCell.identifier)
        collectionView.height(184)
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        return collectionView
    }()
    
//    private lazy var commentTextField: UITextField = {
//        let textField = UITextField(frame: .zero)
//        let placeholder = "Say Something..."
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
//        imageView.image = UIImage(named: "CommentTextFieldIcon")
//
//        textField.placeholder = placeholder
//        textField.textAlignment = .left
//        textField.textColor = .white
//        textField.leftViewMode = .always
//        textField.leftView = imageView
//        textField.font = UIFont.interRegular(size: 18)
//        textField.allowsEditingTextAttributes = false
//        textField.autocorrectionType = .no
//        textField.autocapitalizationType = .none
//        textField.delegate = self
//        textField.backgroundColor = UIColor(hexString: "#585757", alpha: 1)
//        textField.returnKeyType = .done
//        textField.clipsToBounds = true
//        textField.layer.masksToBounds = true
//        textField.layer.cornerRadius = 25
//        textField.height(50)
//        textField.width(258)
//        textField.setLeftPaddingPoints(30)
//        return textField
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutTopUI()
        self.layoutBottomUI()
    }
}
//MARK: - Configure View Controller
extension GoLiveVideoController {
    private func configure() {
        self.view.backgroundColor = .black
        self.view.backgroundColor = .white
        
        self.closeButton.addTarget(self, action: #selector(didTapClose), for: .touchDown)
        self.hiddenEarnedAmountButton.addTarget(self, action: #selector(didTapEarnedAmount), for: .touchDown)
        self.sendMoneyButton.addTarget(self, action: #selector(didTapSendMoney), for: .touchDown)
        self.hiddenSendCommentButton.addTarget(self, action: #selector(didTapSendComment), for: .touchDown)
    }
}
//MARK: - Layout UI
extension GoLiveVideoController {
    private func layoutTopUI() {
        self.view.addSubview(self.closeButton)
        self.closeButton.topToSuperview(offset: 10, usingSafeArea: true)
        self.closeButton.rightToSuperview(offset: -22)
        
        self.view.addSubview(self.hostContainerView)
        self.hostContainerView.centerY(to: self.closeButton)
        self.hostContainerView.leftToSuperview(offset: 22)
        
        self.hostContainerView.addSubview(self.hostImageView)
        self.hostImageView.centerYToSuperview()
        self.hostImageView.leftToSuperview(offset: 7)
        
        self.hostContainerView.addSubview(self.hostNameLabel)
        self.hostNameLabel.top(to: self.hostImageView)
        self.hostNameLabel.leftToRight(of: self.hostImageView, offset: 8)
        self.hostNameLabel.rightToSuperview(offset: -30)
        
        self.hostContainerView.addSubview(self.hostVerifiedImageView)
        self.hostVerifiedImageView.leftToRight(of: self.hostNameLabel, offset: 3)
        self.hostVerifiedImageView.centerY(to: self.hostNameLabel, offset: 4)
        
        self.hostContainerView.addSubview(self.liveView)
        self.liveView.bottom(to: self.hostImageView, offset: -1)
        self.liveView.left(to: self.hostNameLabel)
        
        self.liveView.addSubview(self.liveLabel)
        self.liveLabel.centerXToSuperview()
        self.liveLabel.centerYToSuperview(offset: -1)
        
        self.hostContainerView.addSubview(self.viewCountIconImageView)
        self.viewCountIconImageView.centerY(to: self.liveView)
        self.viewCountIconImageView.leftToRight(of: self.liveView, offset: 8)
        
        self.hostContainerView.addSubview(self.viewersLabel)
        self.viewersLabel.centerY(to: self.liveView, offset: -1)
        self.viewersLabel.leftToRight(of: self.viewCountIconImageView, offset: 4)
        self.viewersLabel.rightToSuperview(offset: -4)
        
        self.view.addSubview(self.firstPlaceContributorImageView)
        self.firstPlaceContributorImageView.centerY(to: self.closeButton)
        self.firstPlaceContributorImageView.leftToRight(of: self.hostContainerView, offset: 22)
        
        self.view.addSubview(self.firstPlaceCrownImageView)
        self.firstPlaceCrownImageView.right(to: self.firstPlaceContributorImageView)
        self.firstPlaceCrownImageView.top(to: self.firstPlaceContributorImageView, offset: -6)
        
        self.view.addSubview(self.secondPlaceContributorImageView)
        self.secondPlaceContributorImageView.centerY(to: self.closeButton)
        self.secondPlaceContributorImageView.leftToRight(of: self.firstPlaceContributorImageView, offset: 12)
        
        self.view.addSubview(self.earnedAmountView)
        self.earnedAmountView.topToBottom(of: self.hostContainerView, offset: 6)
        self.earnedAmountView.left(to: self.hostContainerView, offset: 4)
        
        self.earnedAmountView.addSubview(self.moneySignImageView)
        self.moneySignImageView.leftToSuperview(offset: 9)
        self.moneySignImageView.centerYToSuperview()
        
        self.earnedAmountView.addSubview(self.earnedAmountLabel)
        self.earnedAmountLabel.leftToRight(of: self.moneySignImageView, offset: 2)
        self.earnedAmountLabel.rightToSuperview(offset: -2)
        self.earnedAmountLabel.centerYToSuperview(offset: -1)
        
        self.earnedAmountView.addSubview(self.chevronImageView)
        self.chevronImageView.rightToSuperview(offset: -4)
        self.chevronImageView.centerYToSuperview()
        
        self.view.addSubview(self.hiddenEarnedAmountButton)
        self.hiddenEarnedAmountButton.top(to: self.earnedAmountView, offset: -2)
        self.hiddenEarnedAmountButton.right(to: self.earnedAmountView, offset: 2)
        self.hiddenEarnedAmountButton.left(to: self.earnedAmountView, offset: -2)
        self.hiddenEarnedAmountButton.bottom(to: self.earnedAmountView, offset: 2)
    }
    
    private func layoutBottomUI() {
        self.view.addSubview(self.sendMoneyButton)
        self.sendMoneyButton.bottomToSuperview(usingSafeArea: true)
        self.sendMoneyButton.rightToSuperview(offset: -22)
        
        self.view.addSubview(self.sendCommentContainerView)
        self.sendCommentContainerView.centerY(to: self.sendMoneyButton)
        self.sendCommentContainerView.rightToLeft(of: self.sendMoneyButton, offset: -10)
        
        self.sendCommentContainerView.addSubview(self.sendCommentImageView)
        self.sendCommentImageView.centerInSuperview()
        
        self.view.addSubview(self.hiddenSendCommentButton)
        self.hiddenSendCommentButton.top(to: self.sendCommentContainerView)
        self.hiddenSendCommentButton.right(to: self.sendCommentContainerView)
        self.hiddenSendCommentButton.bottom(to: self.sendCommentContainerView)
        self.hiddenSendCommentButton.left(to: self.sendCommentContainerView)
        
        self.view.addSubview(self.commentContainerView)
        self.commentContainerView.centerY(to: self.sendMoneyButton)
        self.commentContainerView.leftToSuperview(offset: 22)
        self.commentContainerView.rightToLeft(of: self.sendCommentContainerView, offset: -16)
        
        self.commentContainerView.addSubview(self.commentImageView)
        self.commentImageView.leftToSuperview(offset: 13)
        self.commentImageView.centerYToSuperview()
        
        self.commentContainerView.addSubview(self.commentLabel)
        self.commentLabel.leftToRight(of: self.commentImageView, offset: 11)
        self.commentLabel.centerYToSuperview()
        
        self.view.addSubview(self.commentCollectionView)
        self.commentCollectionView.bottomToTop(of: self.commentContainerView, offset: -20)
        self.commentCollectionView.leftToSuperview(offset: 22)
        self.commentCollectionView.right(to: self.sendCommentContainerView, offset: -10)
    }
}
//MARK: - @objc
extension GoLiveVideoController {
    @objc func didTapClose() {
        self.dismiss(animated: true)
    }
    
    @objc func didTapEarnedAmount() {
        print(#function)
    }
    
    @objc func didTapSendComment() {
        print(#function)
    }
    
    @objc func didTapSendMoney() {
        print(#function)
    }
}
//MARK: - CollectionView DataSource & Delegate
extension GoLiveVideoController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoLiveCommentCollectionViewCell.identifier, for: indexPath) as! GoLiveCommentCollectionViewCell
        
        return cell
    }
    
}
//MARK: - UITextField Delegate
extension GoLiveVideoController: UITextFieldDelegate {
    
}
