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
    
    //MARK: - Private Account Section
    private let privateContainerView = UIView.createSettingsContainer()
    private let privateLabel = UILabel.createSettingsTitleLabel(with: "Private Account")
    private let privateSublabel = UILabel.createSettingsSublabel(with: "Only friends will be able to view your videos.")
    private lazy var privateToggle = UIButton.createSettingsToggleButton(with: #selector(didTapPrivate), for: self)
    
    //MARK: - Activity Status Section
    private let activityContainerView = UIView.createSettingsContainer()
    private let activityLabel = UILabel.createSettingsTitleLabel(with: "Activity Status")
    private let activitySublabel = UILabel.createSettingsSublabel(with: "If the activity status feature is enabled, both you and your followers can view each other's activity status. ")
    private lazy var activityToggle = UIButton.createSettingsToggleButton(with: #selector(didTapActivity), for: self)
    
    private let interactionsHeader = UILabel.createSettingsSectionHeader(with: "Interactions")
    private let interactionsContainerView = UIView.createSettingsContainer()
    
    //MARK: - Post Section
    var postVisibility: PrivacyType = .everyone {
        
        didSet {
            switch self.postVisibility {
            case .everyone:
                self.postVisibilityLabel.text = "Everyone"
                
            case .friends:
                self.postVisibilityLabel.text = "Friends"
                
            case .onlyMe:
                self.postVisibilityLabel.text = "Only Me"
            }
        }
    }
    
    private let postLabel = UILabel.createSettingsTitleLabel(with: "Post")
    private let postChevron = UIImageView.createChevron()
    private lazy var postVisibilityLabel = self.createVisibilityLabel(with: "Everyone")
    private lazy var postHiddenButton = UIButton.createHiddenButton(with: #selector(didTapPost), for: self)
    
    //MARK: - Comment Section
    var commentVisibility: PrivacyType = .everyone {
        
        didSet {
            switch self.commentVisibility {
            case .everyone:
                self.commentVisibilityLabel.text = "Everyone"
                
            case .friends:
                self.commentVisibilityLabel.text = "Friends"
                
            case .onlyMe:
                self.commentVisibilityLabel.text = "Only Me"
            }
        }
    }
    
    private let commentLabel = UILabel.createSettingsTitleLabel(with: "Comments")
    private let commentChevron = UIImageView.createChevron()
    private lazy var commentVisibilityLabel = self.createVisibilityLabel(with: "Everyone")
    private lazy var commentHiddenButton = UIButton.createHiddenButton(with: #selector(didTapComments), for: self)
    
    //MARK: - Mention Section
    var mentionVisibility: PrivacyType = .friends {
        
        didSet {
            switch self.mentionVisibility {
            case .everyone:
                self.mentionVisibilityLabel.text = "Everyone"
                
            case .friends:
                self.mentionVisibilityLabel.text = "Friends"
                
            case .onlyMe:
                self.mentionVisibilityLabel.text = "Only Me"
            }
        }
    }
    
    private let mentionLabel = UILabel.createSettingsTitleLabel(with: "Mentions")
    private let mentionChevron = UIImageView.createChevron()
    private lazy var mentionVisibilityLabel = self.createVisibilityLabel(with: "Everyone")
    private lazy var mentionHiddenButton = UIButton.createHiddenButton(with: #selector(didTapMentions), for: self)
    
    //MARK: - Direct Message Section
    var diretMessageVisibility: PrivacyType = .friends {
        
        didSet {
            switch self.diretMessageVisibility {
            case .everyone:
                self.diretVisibilityLabel.text = "Everyone"
                
            case .friends:
                self.diretVisibilityLabel.text = "Friends"
                
            case .onlyMe:
                self.diretVisibilityLabel.text = "Only Me"
            }
        }
    }
    
    private let directLabel = UILabel.createSettingsTitleLabel(with: "Direct Messages")
    private let directChevron = UIImageView.createChevron()
    private lazy var diretVisibilityLabel = self.createVisibilityLabel(with: "Friends")
    private lazy var diretHiddenButton = UIButton.createHiddenButton(with: #selector(didTapDirect), for: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
        self.view.addSubview(self.privateContainerView)
        self.privateContainerView.topToBottom(of: self.titleLabel, offset: 25)
        self.privateContainerView.leftToSuperview()
        self.privateContainerView.rightToSuperview()
        
        self.privateContainerView.addSubview(self.privateLabel)
        self.privateLabel.topToSuperview(offset: 20)
        self.privateLabel.leftToSuperview(offset: 14)
        
        self.privateContainerView.addSubview(self.privateToggle)
        self.privateToggle.rightToSuperview(offset: -14)
        self.privateToggle.centerY(to: self.privateLabel)
        
        self.privateContainerView.addSubview(self.privateSublabel)
        self.privateSublabel.topToBottom(of: self.privateLabel, offset: 10)
        self.privateSublabel.left(to: self.privateLabel)
        self.privateSublabel.right(to: self.privateToggle)
        
        self.privateContainerView.bottom(to: self.privateSublabel, offset: 20)
        
        self.view.addSubview(self.activityContainerView)
        self.activityContainerView.topToBottom(of: self.privateContainerView, offset: 20)
        self.activityContainerView.leftToSuperview()
        self.activityContainerView.rightToSuperview()
        
        self.activityContainerView.addSubview(self.activityLabel)
        self.activityLabel.topToSuperview(offset: 20)
        self.activityLabel.leftToSuperview(offset: 14)
        
        self.activityContainerView.addSubview(self.activityToggle)
        self.activityToggle.rightToSuperview(offset: -14)
        self.activityToggle.centerY(to: self.activityLabel)
        
        self.activityContainerView.addSubview(self.activitySublabel)
        self.activitySublabel.topToBottom(of: self.activityLabel, offset: 10)
        self.activitySublabel.left(to: self.activityLabel)
        self.activitySublabel.right(to: self.activityToggle)
        
        self.activityContainerView.bottom(to: self.activitySublabel, offset: 20)
        
        self.view.addSubview(self.interactionsHeader)
        self.interactionsHeader.topToBottom(of: self.activityContainerView, offset: 25)
        self.interactionsHeader.leftToSuperview(offset: 21)
        
        self.view.addSubview(self.interactionsContainerView)
        self.interactionsContainerView.topToBottom(of: self.interactionsHeader, offset: 10)
        self.interactionsContainerView.leftToSuperview()
        self.interactionsContainerView.rightToSuperview()
        
        self.interactionsContainerView.addSubview(self.postLabel)
        self.postLabel.topToSuperview(offset: 26)
        self.postLabel.leftToSuperview(offset: 15)
        
        self.interactionsContainerView.addSubview(self.postChevron)
        self.postChevron.centerY(to: self.postLabel)
        self.postChevron.rightToSuperview(offset: -15)
        
        self.interactionsContainerView.addSubview(self.postVisibilityLabel)
        self.postVisibilityLabel.rightToLeft(of: self.postChevron, offset: -20)
        self.postVisibilityLabel.centerY(to: self.postChevron)
        
        self.interactionsContainerView.addSubview(self.postHiddenButton)
        self.postHiddenButton.top(to: self.postLabel, offset: -2)
        self.postHiddenButton.left(to: self.postLabel, offset: -2)
        self.postHiddenButton.bottom(to: self.postLabel, offset: 2)
        self.postHiddenButton.right(to: self.postChevron, offset: 2)
        
        self.interactionsContainerView.addSubview(self.commentLabel)
        self.commentLabel.topToBottom(of: self.postLabel, offset: 36)
        self.commentLabel.left(to: self.postLabel)
        
        self.interactionsContainerView.addSubview(self.commentChevron)
        self.commentChevron.centerY(to: self.commentLabel)
        self.commentChevron.right(to: self.postChevron)
        
        self.interactionsContainerView.addSubview(self.commentVisibilityLabel)
        self.commentVisibilityLabel.rightToLeft(of: self.commentChevron, offset: -20)
        self.commentVisibilityLabel.centerY(to: self.commentChevron)
        
        self.interactionsContainerView.addSubview(self.commentHiddenButton)
        self.commentHiddenButton.top(to: self.commentLabel, offset: -2)
        self.commentHiddenButton.left(to: self.commentLabel, offset: -2)
        self.commentHiddenButton.bottom(to: self.commentLabel, offset: 2)
        self.commentHiddenButton.right(to: self.commentChevron, offset: 2)
        
        self.interactionsContainerView.addSubview(self.mentionLabel)
        self.mentionLabel.topToBottom(of: self.commentLabel, offset: 36)
        self.mentionLabel.left(to: self.postLabel)
        
        self.interactionsContainerView.addSubview(self.mentionChevron)
        self.mentionChevron.centerY(to: self.mentionLabel)
        self.mentionChevron.right(to: self.postChevron)
        
        self.interactionsContainerView.addSubview(self.mentionVisibilityLabel)
        self.mentionVisibilityLabel.rightToLeft(of: self.mentionChevron, offset: -20)
        self.mentionVisibilityLabel.centerY(to: self.mentionChevron)
        
        self.interactionsContainerView.addSubview(self.mentionHiddenButton)
        self.mentionHiddenButton.top(to: self.mentionLabel, offset: -2)
        self.mentionHiddenButton.left(to: self.mentionLabel, offset: -2)
        self.mentionHiddenButton.bottom(to: self.mentionLabel, offset: 2)
        self.mentionHiddenButton.right(to: self.mentionChevron, offset: 2)
        
        self.interactionsContainerView.addSubview(self.directLabel)
        self.directLabel.topToBottom(of: self.mentionLabel, offset: 36)
        self.directLabel.left(to: self.postLabel)
        
        self.interactionsContainerView.addSubview(self.directChevron)
        self.directChevron.centerY(to: self.directLabel)
        self.directChevron.right(to: self.postChevron)
        
        self.interactionsContainerView.addSubview(self.diretVisibilityLabel)
        self.diretVisibilityLabel.rightToLeft(of: self.directChevron, offset: -20)
        self.diretVisibilityLabel.centerY(to: self.directChevron)
        
        self.interactionsContainerView.addSubview(self.diretHiddenButton)
        self.diretHiddenButton.top(to: self.directLabel, offset: -2)
        self.diretHiddenButton.left(to: self.directLabel, offset: -2)
        self.diretHiddenButton.bottom(to: self.directLabel, offset: 2)
        self.diretHiddenButton.right(to: self.directChevron, offset: 2)
        
        self.interactionsContainerView.bottom(to: self.directLabel, offset: 20)
    }
}

//MARK: - Helpers
extension PrivacyController {
    private func createVisibilityLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#848484")
        return label
    }
}

//MARK: - @objc
extension PrivacyController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapPrivate() {
        print(#function)
        self.privateToggle.isSelected.toggle()
    }
    
    @objc func didTapActivity() {
        print(#function)
        self.activityToggle.isSelected.toggle()
    }
    
    @objc func didTapPost() {
        let popUpVC = VisibilityPopUpController()
        popUpVC.modalPresentationStyle = .overCurrentContext
        popUpVC.homeController = self
        popUpVC.entryPath = .posts
        popUpVC.visibility = self.postVisibility
        
        self.navigationController?.present(popUpVC, animated: true)
    }
    
    @objc func didTapComments() {
        let popUpVC = VisibilityPopUpController()
        popUpVC.modalPresentationStyle = .overCurrentContext
        popUpVC.homeController = self
        popUpVC.entryPath = .comments
        popUpVC.visibility = self.commentVisibility
        
        self.navigationController?.present(popUpVC, animated: true)
    }
    
    @objc func didTapMentions() {
        let popUpVC = VisibilityPopUpController()
        popUpVC.modalPresentationStyle = .overCurrentContext
        popUpVC.homeController = self
        popUpVC.entryPath = .mentions
        popUpVC.visibility = self.mentionVisibility
        
        self.navigationController?.present(popUpVC, animated: true)
    }
    
    @objc func didTapDirect() {
        let popUpVC = VisibilityPopUpController()
        popUpVC.modalPresentationStyle = .overCurrentContext
        popUpVC.homeController = self
        popUpVC.entryPath = .directMessages
        popUpVC.visibility = self.diretMessageVisibility
        
        self.navigationController?.present(popUpVC, animated: true)
    }
}
