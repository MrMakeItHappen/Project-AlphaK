//
//  SoloVideoCallController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/1/23.
//

import UIKit

enum EffectsFeedType: String, CaseIterable {
    case effects
    case backgrounds
    case lightings
    case active
}

final class SoloVideoCallController: UIViewController {
    private var timer: Timer = Timer()
    private var timerCount: Int = 0
    private var isShowingMoreOptions = false
    private var isShowingEffects = false
    private var mainContainerBottomConstraint: NSLayoutConstraint?
    private var feedType: EffectsFeedType = .effects
    
    private let effectsExamples = Effect.effectsExamples
    private let backgroundExamples = Effect.backgroundExamples
    private let lightingExamples = Effect.lightingsExamples
    private let activeExamples = Effect.activeExamples
    
    private let backgroundBlackColor = UIColor.black.withAlphaComponent(0.80)

    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.tintColor = UIColor(hexString: "#757575")
        button.width(20)
        button.height(20)
        let image = UIImage(named: "BackIcon")?.withTintColor(UIColor(hexString: "#2D2D2D"))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let addParticipantsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.tintColor = UIColor(hexString: "#2D2D2D")
        button.width(24)
        button.height(24)
        button.setImage(UIImage(named: "AddParticipantsIcon"), for: .normal)
        return button
    }()
    
    private let flipCameraButton: UIButton = {
        let button = UIButton(type: .custom)
        let size: CGFloat = 50
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(hexString: "#C7C7C7")
        button.tintColor = .white
        button.width(size)
        button.height(size)
        button.layer.cornerRadius = size / 2
        let icon = UIImage(named: "CameraFlipIcon")?.withTintColor(.white)
        button.setImage(icon, for: .normal)
        return button
    }()
    
    private let callingThisUserLabel: UILabel = {
        let label = UILabel()
        label.text = "Justin Heart"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#2D2D2D")
        return label
    }()
    
    private let onlineStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Online"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 15)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .center
        label.textColor = UIColor.kwiksGreen
        return label
    }()
    
    private let connectionStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Connecting..."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#2D2D2D")
        return label
    }()
    
    private let callDurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#2D2D2D")
        return label
    }()
    
    private let callingThisUserImageView: UIImageView = {
        let imageView = UIImageView()
        let size: CGFloat = 177
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.height(size)
        imageView.width(size)
        imageView.layer.cornerRadius = size / 2
        imageView.layer.borderColor = UIColor.kwiksGreen.cgColor
        imageView.layer.borderWidth = 2
        
        let image = UIImage(named: "MalePlaceholder")
        imageView.image = image
        return imageView
    }()
    
    private let effectsButton: UIButton = {
        let button = UIButton(type: .custom)
        let size: CGFloat = 50
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(hexString: "#C7C7C7")
        button.tintColor = .white
        button.width(size)
        button.height(size)
        button.layer.cornerRadius = size / 2
        let icon = UIImage(named: "EffectsIcon")?.withTintColor(.white)
        button.setImage(icon, for: .normal)
        return button
    }()
    
    private let volumeButton: UIButton = {
        let button = UIButton(type: .custom)
        let size: CGFloat = 50
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(hexString: "#C7C7C7")
        button.tintColor = .white
        button.width(size)
        button.height(size)
        button.layer.cornerRadius = size / 2
        let icon = UIImage(named: "VolumeIcon")?.withTintColor(.white)
        button.setImage(icon, for: .normal)
        return button
    }()
    
    private let videoButton: UIButton = {
        let button = UIButton(type: .custom)
        let size: CGFloat = 50
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.kwiksGreen
        button.tintColor = .white
        button.width(size)
        button.height(size)
        button.layer.cornerRadius = size / 2
        let icon = UIImage(named: "CameraIcon")?.withTintColor(.white)
        button.setImage(icon, for: .normal)
        return button
    }()
    
    private let endCallButton: UIButton = {
        let button = UIButton(type: .custom)
        let size: CGFloat = 50
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.systemRed
        button.tintColor = .white
        button.width(size)
        button.height(size)
        button.layer.cornerRadius = size / 2
        let icon = UIImage(named: "EndCallIcon")?.withTintColor(.white)
        button.setImage(icon, for: .normal)
        return button
    }()
    
    private let moreOptionsButton: UIButton = {
        let button = UIButton(type: .custom)
        let size: CGFloat = 50
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(hexString: "#C7C7C7")
        button.width(size)
        button.height(size)
        button.layer.cornerRadius = size / 2
        let icon = UIImage(systemName: "chevron.up")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(icon, for: .normal)
        return button
    }()
    
    private let sendMessageButton: UIButton = {
        let button = UIButton(type: .custom)
        let size: CGFloat = 50
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(hexString: "#C7C7C7")
        button.tintColor = .white
        button.width(size)
        button.height(size)
        button.layer.cornerRadius = size / 2
        let icon = UIImage(named: "SendMessageIcon")?.withTintColor(.white)
        button.setImage(icon, for: .normal)
        button.alpha = 0
        return button
    }()
    
    private let giftButton: UIButton = {
        let button = UIButton(type: .custom)
        let size: CGFloat = 50
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.kwiksGreen
        button.tintColor = .white
        button.width(size)
        button.height(size)
        button.layer.cornerRadius = size / 2
        let icon = UIImage(named: "MoneySignIcon")?.withTintColor(.white)
        button.setImage(icon, for: .normal)
        button.alpha = 0
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.delaysContentTouches = false
        scrollView.clipsToBounds = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.height(32)
        scrollView.alpha = 0
        return scrollView
    }()

    private let scrollViewContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 0
        view.clipsToBounds = true
        view.height(32)
        return view
    }()
    
    private lazy var effectsCategoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Effects", for: .normal)
        button.titleLabel?.font = .segoeUISemiBold(size: 15)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor.kwiksGreen
        button.height(30)
        button.width(84)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(didTapEffectCategory), for: .touchUpInside)
        return button
    }()
    
    private lazy var backgroundCategoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Backgrounds", for: .normal)
        button.titleLabel?.font = .segoeUISemiBold(size: 15)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor.black.withAlphaComponent(0.80)
        button.height(30)
        button.width(130)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(didTapBackgroundCategory), for: .touchUpInside)
        return button
    }()
    
    private lazy var lightingCategoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Lightings", for: .normal)
        button.titleLabel?.font = .segoeUISemiBold(size: 15)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor.black.withAlphaComponent(0.80)
        button.height(30)
        button.width(102)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(didTapLightingCategory), for: .touchUpInside)
        return button
    }()
    
    private lazy var activeCategoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Active", for: .normal)
        button.titleLabel?.font = .segoeUISemiBold(size: 15)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor.black.withAlphaComponent(0.80)
        button.height(30)
        button.width(130)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(didTapActiveCategory), for: .touchUpInside)
        return button
    }()
    
    private lazy var effectsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(EffectsCollectionViewCell.self, forCellWithReuseIdentifier: EffectsCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        collectionView.height(50)
        collectionView.alpha = 0
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Configure Controller
extension SoloVideoCallController {
    private func configure() {
        self.view.backgroundColor = .white
        self.flipCameraButton.alpha = 0
        
        self.backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        self.addParticipantsButton.addTarget(self, action: #selector(didTapAddParticipants), for: .touchUpInside)
        self.flipCameraButton.addTarget(self, action: #selector(didTapFlipCamera), for: .touchUpInside)
        
        self.effectsButton.addTarget(self, action: #selector(didTapEffects), for: .touchUpInside)
        self.videoButton.addTarget(self, action: #selector(didTapVideo), for: .touchUpInside)
        self.volumeButton.addTarget(self, action: #selector(didTapVolume), for: .touchUpInside)
        self.endCallButton.addTarget(self, action: #selector(didTapEndCall), for: .touchUpInside)
        self.moreOptionsButton.addTarget(self, action: #selector(didTapMoreOptions), for: .touchUpInside)
        
        self.sendMessageButton.addTarget(self, action: #selector(didTapSendMessage), for: .touchUpInside)
        self.giftButton.addTarget(self, action: #selector(didTapSendGift), for: .touchUpInside)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCounter), userInfo: nil, repeats: true)
        }
    }
}

//MARK: - Layout UI
extension SoloVideoCallController {
    private func layoutUI() {
        self.view.addSubview(self.backButton)
        self.backButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.backButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.addParticipantsButton)
        self.addParticipantsButton.centerY(to: self.backButton)
        self.addParticipantsButton.rightToSuperview(offset: -22)
        
        self.view.addSubview(self.flipCameraButton)
        self.flipCameraButton.topToBottom(of: self.addParticipantsButton, offset: 43)
        self.flipCameraButton.right(to: self.addParticipantsButton)
        
        self.view.addSubview(self.callingThisUserLabel)
        self.callingThisUserLabel.centerY(to: self.backButton)
        self.callingThisUserLabel.rightToLeft(of: self.addParticipantsButton, offset: -10)
        self.callingThisUserLabel.leftToRight(of: self.backButton, offset: 10)
        
        self.view.addSubview(self.onlineStatusLabel)
        self.onlineStatusLabel.topToBottom(of: self.callingThisUserLabel, offset: 0)
        self.onlineStatusLabel.left(to: self.callingThisUserLabel)
        self.onlineStatusLabel.right(to: self.callingThisUserLabel)
        
        self.view.addSubview(self.connectionStatusLabel)
        self.connectionStatusLabel.topToBottom(of: self.onlineStatusLabel, offset: 90)
        self.connectionStatusLabel.centerXToSuperview()
        
        self.view.addSubview(self.callDurationLabel)
        self.callDurationLabel.topToBottom(of: self.connectionStatusLabel)
        self.callDurationLabel.centerXToSuperview()
        
        self.view.addSubview(self.callingThisUserImageView)
        self.callingThisUserImageView.centerInSuperview()
        
        self.view.addSubview(self.videoButton)
        self.videoButton.centerXToSuperview()
        self.videoButton.bottomToSuperview(usingSafeArea: true)
        
        self.view.addSubview(self.endCallButton)
        self.endCallButton.top(to: self.videoButton)
        self.endCallButton.leftToRight(of: self.videoButton, offset: 15)
        
        self.view.addSubview(self.moreOptionsButton)
        self.moreOptionsButton.top(to: self.videoButton)
        self.moreOptionsButton.leftToRight(of: self.endCallButton, offset: 15)
        
        self.view.addSubview(self.volumeButton)
        self.volumeButton.top(to: self.videoButton)
        self.volumeButton.rightToLeft(of: self.videoButton, offset: -15)
        
        self.view.addSubview(self.effectsButton)
        self.effectsButton.rightToLeft(of: self.volumeButton, offset: -15)
        self.mainContainerBottomConstraint = self.effectsButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        self.mainContainerBottomConstraint?.isActive = true
        
        self.view.addSubview(self.sendMessageButton)
        self.sendMessageButton.right(to: self.moreOptionsButton)
        self.sendMessageButton.bottomToTop(of: self.moreOptionsButton, offset: -15)

        self.view.addSubview(self.giftButton)
        self.giftButton.right(to: self.sendMessageButton)
        self.giftButton.bottomToTop(of: self.sendMessageButton, offset: -10)
        
        self.view.addSubview(self.scrollView)
        self.scrollView.bottomToSuperview(usingSafeArea: true)
        self.scrollView.left(to: self.effectsButton)
        self.scrollView.rightToSuperview()

        self.scrollView.addSubview(self.scrollViewContentView)
        self.scrollViewContentView.topToSuperview()
        self.scrollViewContentView.leftToSuperview()
        self.scrollViewContentView.rightToSuperview()
        self.scrollViewContentView.bottomToSuperview()
        
        self.scrollViewContentView.addSubview(self.effectsCategoryButton)
        self.effectsCategoryButton.centerYToSuperview()
        self.effectsCategoryButton.leftToSuperview()
        
        self.scrollViewContentView.addSubview(self.backgroundCategoryButton)
        self.backgroundCategoryButton.centerYToSuperview()
        self.backgroundCategoryButton.leftToRight(of: self.effectsCategoryButton, offset: 12)
        
        self.scrollViewContentView.addSubview(self.lightingCategoryButton)
        self.lightingCategoryButton.centerYToSuperview()
        self.lightingCategoryButton.leftToRight(of: self.backgroundCategoryButton, offset: 12)
        
        self.scrollViewContentView.addSubview(self.activeCategoryButton)
        self.activeCategoryButton.centerYToSuperview()
        self.activeCategoryButton.leftToRight(of: self.lightingCategoryButton, offset: 12)
        
        self.view.addSubview(self.effectsCollectionView)
        self.effectsCollectionView.bottomToSuperview(offset: -45, usingSafeArea: true)
        self.effectsCollectionView.left(to: self.volumeButton)
        self.effectsCollectionView.rightToSuperview()
        
        self.scrollViewContentView.right(to: self.activeCategoryButton, offset: 12)
    }
}

//MARK: - Helpers
extension SoloVideoCallController {
    func secondsToMintues(seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func createTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
}

//MARK: - @objc
extension SoloVideoCallController {
    @objc func didTapBack() {
        print(#function)
    }
    
    @objc func didTapFlipCamera() {
        print(#function)
    }
    
    @objc func didTapAddParticipants() {
        let addVC = AddParticipantsController()
        addVC.presentingController = self
        addVC.modalPresentationStyle = .overFullScreen

        self.navigationController?.present(addVC, animated: true)
    }
    
    @objc func didTapEffects() {
        isShowingEffects.toggle()
        self.effectsCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
        
        if isShowingEffects {
            
            self.mainContainerBottomConstraint?.constant = -45
            
            UIView.animate(withDuration: 0.33) {
                self.view.layoutIfNeeded()
            }
            
            UIView.animate(withDuration: 0.15, delay: 0.1, options: .curveLinear, animations: {
                self.effectsButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.volumeButton.alpha = 0
                self.videoButton.alpha = 0
                self.endCallButton.alpha = 0
                self.moreOptionsButton.alpha = 0
                self.scrollView.alpha = 1
                self.effectsCollectionView.alpha = 1
                
            }) { (success) in
                UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear, animations: {
                    self.effectsButton.transform = .identity
                    self.effectsButton.setImage(UIImage(named: "CloseEffectIcon"), for: .normal)
                    self.effectsButton.backgroundColor = UIColor.black.withAlphaComponent(0.80)
                    self.effectsButton.layer.cornerRadius = 17
                }, completion: nil)
            }
            
        } else {
            UIView.animate(withDuration: 0.15, delay: 0.1, options: .curveLinear, animations: {
                self.effectsButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.volumeButton.alpha = 1
                self.videoButton.alpha = 1
                self.endCallButton.alpha = 1
                self.moreOptionsButton.alpha = 1
                self.scrollView.alpha = 0
                self.effectsCollectionView.alpha = 0
                
            }) { (success) in
                UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear, animations: {
                    self.effectsButton.transform = .identity
                    self.effectsButton.setImage(UIImage(named: "EffectsIcon")?.withTintColor(.white), for: .normal)
                    self.effectsButton.backgroundColor = UIColor(hexString: "#C7C7C7")
                    self.effectsButton.layer.cornerRadius = 25
                    self.mainContainerBottomConstraint?.constant = 0
                }, completion: nil)
            }
        }
    }
    
    @objc func didTapEffectCategory() {
        self.feedType = .effects
        
        self.effectsCategoryButton.backgroundColor = UIColor.kwiksGreen
        self.effectsCategoryButton.tintColor = .black
        
        self.backgroundCategoryButton.backgroundColor = self.backgroundBlackColor
        self.backgroundCategoryButton.tintColor = .white
        
        self.lightingCategoryButton.backgroundColor = self.backgroundBlackColor
        self.lightingCategoryButton.tintColor = .white
        
        self.activeCategoryButton.backgroundColor = self.backgroundBlackColor
        self.activeCategoryButton.tintColor = .white
        
        self.effectsCollectionView.reloadData()
        self.effectsCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
    }
    
    @objc func didTapBackgroundCategory() {
        self.feedType = .backgrounds
        
        self.backgroundCategoryButton.backgroundColor = UIColor.kwiksGreen
        self.backgroundCategoryButton.tintColor = .black
        
        self.effectsCategoryButton.backgroundColor = self.backgroundBlackColor
        self.effectsCategoryButton.tintColor = .white
        
        self.lightingCategoryButton.backgroundColor = self.backgroundBlackColor
        self.lightingCategoryButton.tintColor = .white
        
        self.activeCategoryButton.backgroundColor = self.backgroundBlackColor
        self.activeCategoryButton.tintColor = .white
        
        self.effectsCollectionView.reloadData()
        self.effectsCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
    }
    
    @objc func didTapLightingCategory() {
        self.feedType = .lightings
        
        self.lightingCategoryButton.backgroundColor = UIColor.kwiksGreen
        self.lightingCategoryButton.tintColor = .black
        
        self.effectsCategoryButton.backgroundColor = self.backgroundBlackColor
        self.effectsCategoryButton.tintColor = .white
        
        self.backgroundCategoryButton.backgroundColor = self.backgroundBlackColor
        self.backgroundCategoryButton.tintColor = .white
        
        self.activeCategoryButton.backgroundColor = self.backgroundBlackColor
        self.activeCategoryButton.tintColor = .white
        
        self.effectsCollectionView.reloadData()
        self.effectsCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
    }
    
    @objc func didTapActiveCategory() {
        self.feedType = .active
        
        self.activeCategoryButton.backgroundColor = UIColor.kwiksGreen
        self.activeCategoryButton.tintColor = .black
        
        self.effectsCategoryButton.backgroundColor = self.backgroundBlackColor
        self.effectsCategoryButton.tintColor = .white
        
        self.backgroundCategoryButton.backgroundColor = self.backgroundBlackColor
        self.backgroundCategoryButton.tintColor = .white
        
        self.lightingCategoryButton.backgroundColor = self.backgroundBlackColor
        self.lightingCategoryButton.tintColor = .white
        
        self.effectsCollectionView.reloadData()
        self.effectsCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
    }
    
    @objc func didTapVolume() {
        print(#function)
    }
    
    @objc func didTapVideo() {
        print(#function)
    }
    
    @objc func didTapEndCall() {
        self.timer.invalidate()
        self.connectionStatusLabel.text = "Call Ended"
    }
    
    @objc func didTapMoreOptions() {
        
        if !isShowingMoreOptions {
            UIView.animate(withDuration: 0.50) {
                self.moreOptionsButton.transform = self.moreOptionsButton.transform.rotated(by: CGFloat(Double(180) * .pi / 180))
                
                self.sendMessageButton.alpha = 1
                self.giftButton.alpha = 1
            }
            
            self.isShowingMoreOptions.toggle()
            
        } else {
            UIView.animate(withDuration: 0.50) {
                self.moreOptionsButton.transform = self.moreOptionsButton.transform.rotated(by: CGFloat(Double(180) * .pi / 180))
                
                self.sendMessageButton.alpha = 0
                self.giftButton.alpha = 0
            }
            
            self.isShowingMoreOptions.toggle()
        }
    }
    
    @objc func didTapSendMessage() {
        print(#function)
    }
    
    @objc func didTapSendGift() {
        print(#function)
    }
    
    @objc func timerCounter() {
        self.timerCount += 1
        
        let time = secondsToMintues(seconds: timerCount)
        let timeString = createTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        
        self.connectionStatusLabel.text = "Connected"
        self.callDurationLabel.text = timeString
    }
}
//MARK: - CollectionView DataSource & Delegate
extension SoloVideoCallController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.feedType {
        case .effects:
            return self.effectsExamples.count
            
        case .backgrounds:
            return self.backgroundExamples.count
            
        case .lightings:
            return self.lightingExamples.count
            
        case .active:
            return self.activeExamples.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EffectsCollectionViewCell.identifier, for: indexPath) as! EffectsCollectionViewCell
        
        switch self.feedType {
            
        case .effects:
            let effect = self.effectsExamples[indexPath.item]
            cell.configure(with: effect)
            
        case .backgrounds:
            let effect = self.backgroundExamples[indexPath.item]
            cell.configure(with: effect)
            
        case .lightings:
            let effect = self.lightingExamples[indexPath.item]
            cell.configure(with: effect)
            
        case .active:
            let effect = self.activeExamples[indexPath.item]
            cell.configure(with: effect)
        }
        
        return cell
    }
}
