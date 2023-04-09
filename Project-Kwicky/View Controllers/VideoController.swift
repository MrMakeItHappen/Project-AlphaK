//
//  VideoController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/19/23.
//

import UIKit
import KwiksSystemsPopups

//TODO: Fetch any available music here. Can be processed in the background while user makes video adjustments.

final class VideoController: UIViewController {
    private let effectsExamples = Effect.effectExamples
    private var timer: Timer = Timer()
    private var timerCount: Int = 5
    
    private let stopImageIcon = UIImage(systemName: "stop.fill")
    private let playImageIcon = UIImage(named: "KwiksLogoWhite")
    
    var isShowingOptions = false
    var isShowingTimer = false
    var isRecording = false
    var mainContainerBottomConstraint: NSLayoutConstraint?
    var userCreatedVideo: KwiksVideo?
    var popUpAlert = KwiksSystemPopups()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor.systemBlue
        view.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 40)
        return view
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.tintColor = .white
        button.setImage(UIImage(named: "CloseIcon"), for: .normal)
        button.width(20)
        button.height(20)
        return button
    }()
    
    private let addMusicContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(hexString: "#4F4F4F", alpha: 1)
        view.layer.cornerRadius = 18
        view.height(36)
        view.width(130)
        return view
    }()
    
    private let addMusicIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(16)
        imageView.width(16)
        
        let image = UIImage(named: "AddMusicIcon")
        imageView.image = image
        return imageView
    }()
    
    private let addMusicLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Music"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let hiddenAddMusicButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let cameraLightButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.tintColor = .white
        button.setImage(UIImage(named: "OffCameraLightIcon"), for: .normal)
        button.width(24)
        button.height(24)
        return button
    }()
    
    private let cameraSelectionView: UIView = {
        let view = UIView()
        let size: CGFloat = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor.kwiksGreen
        view.layer.cornerRadius = size / 2
        view.height(size)
        view.width(size)
        return view
    }()
    
    private let cameraLabel: UILabel = {
        let label = UILabel()
        label.text = "Camera"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 15)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let liveLabel: UILabel = {
        let label = UILabel()
        label.text = "Live"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 15)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#4F4F4F", alpha: 1)
        return label
    }()
    
    private let hiddenTemplatesButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let recordButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: "KwiksLogoWhite")
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 0)
        
        let button = UIButton(configuration: configuration)
        let size: CGFloat = 82
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = size / 2
        button.clipsToBounds = true
        button.backgroundColor = UIColor.kwiksGreen
        button.tintColor = .white
        button.height(size)
        button.width(size)
        return button
    }()
    
    private let effectsIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(20)
        imageView.width(20)
        
        let image = UIImage(named: "EffectsIcon")
        imageView.image = image
        return imageView
    }()
    
    private let effectsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hexString: "#2B2B2B", alpha: 1).cgColor
        return button
    }()
    
    private let effectsLabel: UILabel = {
        let label = UILabel()
        label.text = "Effects"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let uploadIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(20)
        imageView.width(20)
        
        let image = UIImage(named: "UploadImageIcon")
        imageView.image = image
        return imageView
    }()
    
    private let uploadVideoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hexString: "#2B2B2B", alpha: 1).cgColor
        return button
    }()
    
    private let uploadLabel: UILabel = {
        let label = UILabel()
        label.text = "Upload"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let stickersLabel: UILabel = {
        let label = UILabel()
        label.text = "Stickers"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let stickersIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(28)
        imageView.width(28)
        
        let image = UIImage(named: "StickersIcon")
        imageView.image = image
        return imageView
    }()
    
    private let hiddenUnknownShapeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let cropLabel: UILabel = {
        let label = UILabel()
        label.text = "Crop"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    private let cropIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(28)
        imageView.width(28)
        
        let image = UIImage(named: "CropIcon")
        imageView.image = image
        return imageView
    }()
    
    private let hiddenShapeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let beautifyLabel: UILabel = {
        let label = UILabel()
        label.text = "Beautify"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let beautifyIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(28)
        imageView.width(28)
        
        let image = UIImage(named: "BeautifyIcon")
        imageView.image = image
        return imageView
    }()
    
    private let hiddenBeautifyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "Timer"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let timerIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(28)
        imageView.width(28)
        
        let image = UIImage(named: "TimerIcon")
        imageView.image = image
        return imageView
    }()
    
    private let hiddenTimerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let timerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.layer.cornerRadius = 30
        view.height(107)
        view.width(150)
        view.alpha = 0
        return view
    }()
    
    private lazy var tenSecondButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .segoeUIRegular(size: 16)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("10s", attributes: attributeContainer)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapTenSeconds()
        }))
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.clear
        button.width(72)
        button.height(43)
        return button
    }()
    
    private lazy var twentySecondButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .segoeUIRegular(size: 16)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("20s", attributes: attributeContainer)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapTwentySeconds()
        }))
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.clear
        button.width(72)
        button.height(43)
        return button
    }()
    
    private lazy var thirtySecondButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .segoeUIRegular(size: 16)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("30s", attributes: attributeContainer)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapThirtySeconds()
        }))
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.clear
        button.width(72)
        button.height(43)
        return button
    }()
    
    private lazy var sixtySecondButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .segoeUIRegular(size: 16)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("60s", attributes: attributeContainer)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapSixtySeconds()
        }))
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.clear
        button.width(72)
        button.height(43)
        return button
    }()
    
    private let timerDurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 16)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    private let flipLabel: UILabel = {
        let label = UILabel()
        label.text = " Flip"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let flipIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(28)
        imageView.width(28)
        
        let image = UIImage(named: "FlipCameraIcon")
        imageView.image = image
        return imageView
    }()
    
    private let hiddenFlipButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private lazy var effectsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 60)
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
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 25)
        
        return collectionView
    }()
    
    private let shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 6
        layer.strokeColor = UIColor.systemRed.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeEnd = 0
        return layer
    }()
    
    private let trackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 6
        layer.strokeColor = UIColor.black.withAlphaComponent(0.75).cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeEnd = 1
        return layer
    }()
    
    private let recordAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        return animation
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutTopUI()
        self.layoutBottomUI()
        self.layoutLeadingUI()
        
        _allAvailableVideoMusic = AvailableMusic.allTempSongs
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let circlePath = UIBezierPath(arcCenter: recordButton.center, radius: 46, startAngle: -(.pi / 2), endAngle: .pi * 2, clockwise: true)
        self.shapeLayer.path = circlePath.cgPath
        self.trackLayer.path = circlePath.cgPath
        
        self.view.layer.addSublayer(self.trackLayer)
        self.view.layer.addSublayer(self.shapeLayer)
    }
}
//MARK: - Configure View Controller
extension VideoController {
    private func configure() {
        self.view.backgroundColor = UIColor(hexString: "#202020")
        
        self.closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        self.cameraLightButton.addTarget(self, action: #selector(didTapCameraLight), for: .touchDown)
        
        self.hiddenAddMusicButton.addTarget(self, action: #selector(didTapAddMusic), for: .touchDown)
        self.recordButton.addTarget(self, action: #selector(didTapRecord), for: .touchDown)
        
        self.hiddenTemplatesButton.addTarget(self, action: #selector(didTapTemplates), for: .touchDown)
        
        self.hiddenUnknownShapeButton.addTarget(self, action: #selector(didTapUnknown), for: .touchDown)
        self.hiddenShapeButton.addTarget(self, action: #selector(didTapShapes), for: .touchDown)
        self.hiddenBeautifyButton.addTarget(self, action: #selector(didTapBeautify), for: .touchDown)
        self.hiddenTimerButton.addTarget(self, action: #selector(didTapTimer), for: .touchDown)
        self.hiddenFlipButton.addTarget(self, action: #selector(didTapFlipCamera), for: .touchDown)
        
        self.effectsButton.addTarget(self, action: #selector(didTapEffects), for: .touchDown)
        self.uploadVideoButton.addTarget(self, action: #selector(didTapUpload), for: .touchDown)
    }
}
//MARK: - Layout UI
extension VideoController {
    private func layoutTopUI() {
        self.view.addSubview(self.containerView)
        self.containerView.topToSuperview()
        self.containerView.leftToSuperview()
        self.containerView.rightToSuperview()
        self.mainContainerBottomConstraint = self.containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        self.mainContainerBottomConstraint?.isActive = true
        
        self.view.addSubview(self.effectsCollectionView)
        self.view.sendSubviewToBack(self.effectsCollectionView)
        self.effectsCollectionView.topToBottom(of: self.containerView, offset: 10)
        self.effectsCollectionView.leftToSuperview(offset: 25)
        self.effectsCollectionView.rightToSuperview()
        self.effectsCollectionView.bottomToSuperview(usingSafeArea: true)
        
        self.containerView.addSubview(self.addMusicContainerView)
        self.addMusicContainerView.topToSuperview(usingSafeArea: true)
        self.addMusicContainerView.centerXToSuperview()
        
        self.addMusicContainerView.addSubview(self.addMusicIconImageView)
        self.addMusicIconImageView.centerYToSuperview()
        self.addMusicIconImageView.leftToSuperview(offset: 15)
        
        self.addMusicContainerView.addSubview(self.addMusicLabel)
        self.addMusicLabel.centerYToSuperview()
        self.addMusicLabel.leftToRight(of: self.addMusicIconImageView, offset: 12)
        
        self.containerView.addSubview(self.hiddenAddMusicButton)
        self.hiddenAddMusicButton.top(to: self.addMusicContainerView)
        self.hiddenAddMusicButton.bottom(to: self.addMusicContainerView)
        self.hiddenAddMusicButton.left(to: self.addMusicContainerView)
        self.hiddenAddMusicButton.right(to: self.addMusicContainerView)
        
        self.containerView.addSubview(self.closeButton)
        self.closeButton.centerY(to: self.addMusicContainerView)
        self.closeButton.rightToLeft(of: self.addMusicContainerView, offset: -80)
        
        self.containerView.addSubview(self.cameraLightButton)
        self.cameraLightButton.centerY(to: self.addMusicContainerView)
        self.cameraLightButton.leftToRight(of: self.addMusicContainerView, offset: 80)
    }
    
    private func layoutBottomUI() {
        self.containerView.addSubview(self.cameraSelectionView)
        self.cameraSelectionView.bottomToSuperview(offset: -26)
        self.cameraSelectionView.centerXToSuperview()
        
        self.containerView.addSubview(self.cameraLabel)
        self.cameraLabel.centerXToSuperview()
        self.cameraLabel.bottomToTop(of: self.cameraSelectionView, offset: -10)
        
        self.containerView.addSubview(self.liveLabel)
        self.liveLabel.leftToRight(of: self.cameraLabel, offset: 22)
        self.liveLabel.centerY(to: self.cameraLabel)
        
        self.containerView.addSubview(self.hiddenTemplatesButton)
        self.hiddenTemplatesButton.top(to: self.liveLabel, offset: -2)
        self.hiddenTemplatesButton.right(to: self.liveLabel, offset: 2)
        self.hiddenTemplatesButton.left(to: self.liveLabel, offset: -2)
        self.hiddenTemplatesButton.bottom(to: self.liveLabel, offset: 2)
        
        self.containerView.addSubview(self.recordButton)
        self.recordButton.centerXToSuperview()
        self.recordButton.bottomToTop(of: self.cameraLabel, offset: -20)
        
        self.containerView.addSubview(self.effectsIconImageView)
        self.effectsIconImageView.centerY(to: self.recordButton)
        self.effectsIconImageView.rightToLeft(of: self.recordButton, offset: -50)
        
        self.containerView.addSubview(self.effectsButton)
        self.effectsButton.top(to: self.effectsIconImageView, offset: -15)
        self.effectsButton.right(to: self.effectsIconImageView, offset: 15)
        self.effectsButton.left(to: self.effectsIconImageView, offset: -15)
        self.effectsButton.bottom(to: self.effectsIconImageView, offset: 15)
        
        self.containerView.addSubview(self.effectsLabel)
        self.effectsLabel.centerX(to: self.effectsIconImageView)
        self.effectsLabel.topToBottom(of: self.effectsButton, offset: 5)
        
        self.containerView.addSubview(self.uploadIconImageView)
        self.uploadIconImageView.centerY(to: self.recordButton)
        self.uploadIconImageView.leftToRight(of: self.recordButton, offset: 50)
        
        self.containerView.addSubview(self.uploadVideoButton)
        self.uploadVideoButton.top(to: self.uploadIconImageView, offset: -15)
        self.uploadVideoButton.right(to: self.uploadIconImageView, offset: 15)
        self.uploadVideoButton.left(to: self.uploadIconImageView, offset: -15)
        self.uploadVideoButton.bottom(to: self.uploadIconImageView, offset: 15)
        
        self.containerView.addSubview(self.uploadLabel)
        self.uploadLabel.centerX(to: self.uploadIconImageView)
        self.uploadLabel.topToBottom(of: self.uploadVideoButton, offset: 5)
    }
    
    private func layoutLeadingUI() {
        self.containerView.addSubview(self.stickersLabel)
        self.stickersLabel.leftToSuperview(offset: 23)
        self.stickersLabel.bottomToTop(of: self.recordButton, offset: -55)
        
        self.containerView.addSubview(self.stickersIconImageView)
        self.stickersIconImageView.bottomToTop(of: self.stickersLabel, offset: -8)
        self.stickersIconImageView.centerX(to: self.stickersLabel)
        
        self.containerView.addSubview(self.hiddenUnknownShapeButton)
        self.hiddenUnknownShapeButton.top(to: self.stickersIconImageView, offset: -2)
        self.hiddenUnknownShapeButton.right(to: self.stickersLabel, offset: 2)
        self.hiddenUnknownShapeButton.left(to: self.stickersLabel, offset: -2)
        self.hiddenUnknownShapeButton.bottom(to: self.stickersLabel, offset: 2)
        
        self.containerView.addSubview(self.cropLabel)
        self.cropLabel.centerX(to: self.stickersLabel)
        self.cropLabel.bottomToTop(of: self.stickersIconImageView, offset: -28)
        
        self.containerView.addSubview(self.cropIconImageView)
        self.cropIconImageView.bottomToTop(of: self.cropLabel, offset: -8)
        self.cropIconImageView.centerX(to: self.stickersLabel)
        
        self.containerView.addSubview(self.hiddenShapeButton)
        self.hiddenShapeButton.top(to: self.cropIconImageView, offset: -2)
        self.hiddenShapeButton.right(to: self.cropLabel, offset: 2)
        self.hiddenShapeButton.left(to: self.cropLabel, offset: -2)
        self.hiddenShapeButton.bottom(to: self.cropLabel, offset: 2)
        
        self.containerView.addSubview(self.beautifyLabel)
        self.beautifyLabel.centerX(to: self.stickersLabel)
        self.beautifyLabel.bottomToTop(of: self.cropIconImageView, offset: -28)
        
        self.containerView.addSubview(self.beautifyIconImageView)
        self.beautifyIconImageView.bottomToTop(of: self.beautifyLabel, offset: -8)
        self.beautifyIconImageView.centerX(to: self.stickersLabel)
        
        self.containerView.addSubview(self.hiddenBeautifyButton)
        self.hiddenBeautifyButton.top(to: self.beautifyIconImageView, offset: -2)
        self.hiddenBeautifyButton.right(to: self.beautifyLabel, offset: 2)
        self.hiddenBeautifyButton.left(to: self.beautifyLabel, offset: -2)
        self.hiddenBeautifyButton.bottom(to: self.beautifyLabel, offset: 2)
        
        self.containerView.addSubview(self.timerLabel)
        self.timerLabel.centerX(to: self.stickersLabel)
        self.timerLabel.bottomToTop(of: self.beautifyIconImageView, offset: -28)
        
        self.containerView.addSubview(self.timerIconImageView)
        self.timerIconImageView.bottomToTop(of: self.timerLabel, offset: -8)
        self.timerIconImageView.centerX(to: self.stickersLabel)
        
        self.containerView.addSubview(self.hiddenTimerButton)
        self.hiddenTimerButton.top(to: self.timerIconImageView, offset: -2)
        self.hiddenTimerButton.right(to: self.timerLabel, offset: 2)
        self.hiddenTimerButton.left(to: self.timerLabel, offset: -2)
        self.hiddenTimerButton.bottom(to: self.timerLabel, offset: 2)
        
        self.containerView.addSubview(self.timerContainer)
        self.timerContainer.top(to: self.timerIconImageView, offset: -4)
        self.timerContainer.leftToRight(of: self.timerIconImageView, offset: 20)
        
        self.timerContainer.addSubview(self.tenSecondButton)
        self.tenSecondButton.topToSuperview(offset: 8)
        self.tenSecondButton.leftToSuperview(offset: 8)
        
        self.timerContainer.addSubview(self.twentySecondButton)
        self.twentySecondButton.topToSuperview(offset: 8)
        self.twentySecondButton.rightToSuperview(offset: -8)
        
        self.timerContainer.addSubview(self.thirtySecondButton)
        self.thirtySecondButton.bottomToSuperview(offset: -8)
        self.thirtySecondButton.left(to: self.tenSecondButton)
        
        self.timerContainer.addSubview(self.sixtySecondButton)
        self.sixtySecondButton.bottomToSuperview(offset: -8)
        self.sixtySecondButton.right(to: self.twentySecondButton)
        
        self.containerView.addSubview(self.timerDurationLabel)
        self.timerDurationLabel.bottomToTop(of: self.recordButton, offset: -16)
        self.timerDurationLabel.left(to: self.recordButton)
        self.timerDurationLabel.right(to: self.recordButton)
        
        self.containerView.addSubview(self.flipLabel)
        self.flipLabel.centerX(to: self.stickersLabel)
        self.flipLabel.bottomToTop(of: self.timerIconImageView, offset: -28)
        
        self.containerView.addSubview(self.flipIconImageView)
        self.flipIconImageView.bottomToTop(of: self.flipLabel, offset: -8)
        self.flipIconImageView.centerX(to: self.stickersLabel)
        
        self.containerView.addSubview(self.hiddenFlipButton)
        self.hiddenFlipButton.top(to: self.flipIconImageView, offset: -2)
        self.hiddenFlipButton.right(to: self.flipLabel, offset: 2)
        self.hiddenFlipButton.left(to: self.flipLabel, offset: -2)
        self.hiddenFlipButton.bottom(to: self.flipLabel, offset: 2)
    }
}
//MARK: - Helpers
extension VideoController {
    private func secondsToMintues(seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    private func createTimeString(minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    private func deselectAllTimerButtons() {
        self.tenSecondButton.tintColor = .white
        self.tenSecondButton.backgroundColor = .clear
        
        self.twentySecondButton.tintColor = .white
        self.twentySecondButton.backgroundColor = .clear
        
        self.thirtySecondButton.tintColor = .white
        self.thirtySecondButton.backgroundColor = .clear
        
        self.sixtySecondButton.tintColor = .white
        self.sixtySecondButton.backgroundColor = .clear
    }
}
//MARK: - @objc
extension VideoController {
    @objc func didTapClose() {
        self.dismiss(animated: true)
    }
    
    @objc func didTapCameraLight() {
        print(#function)
    }
    
    @objc func didTapAddMusic() {
        let addMusicVC = AddMusicToVideoViewController()
        self.navigationController?.pushViewController(addMusicVC, animated: true)
    }
    
    @objc func didTapFlipCamera() {
        print(#function)
    }
    
    @objc func didTapTimer() {
        print(#function)
        self.isShowingTimer.toggle()
        self.deselectAllTimerButtons()
        
        if isShowingTimer {
            UIView.animate(withDuration: 0.75) {
                self.timerContainer.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.75) {
                self.timerContainer.alpha = 0
            }
        }
    }
    
    @objc func timerCounter() {if self.timerCount > 0 {
            self.timerCount -= 1
            
        } else {
            self.timer.invalidate()
            self.timerCount = 5
            self.timerDurationLabel.text = "👍🏽"
            return
        }
        
        var timeString = "00:"
        timeString += String(format: "%02d", timerCount)
        
        self.timerDurationLabel.text = timeString
    }
    
    @objc func didTapTenSeconds() {
        self.tenSecondButton.tintColor = .kwiksTextBlack
        self.tenSecondButton.backgroundColor = .white
        
        self.twentySecondButton.tintColor = .white
        self.twentySecondButton.backgroundColor = .clear
        
        self.thirtySecondButton.tintColor = .white
        self.thirtySecondButton.backgroundColor = .clear
        
        self.sixtySecondButton.tintColor = .white
        self.sixtySecondButton.backgroundColor = .clear
        
        self.timerDurationLabel.text = "00:10"
        self.timerCount = 10
    }
    
    @objc func didTapTwentySeconds() {
        self.twentySecondButton.tintColor = .kwiksTextBlack
        self.twentySecondButton.backgroundColor = .white
        
        self.tenSecondButton.tintColor = .white
        self.tenSecondButton.backgroundColor = .clear
        
        self.thirtySecondButton.tintColor = .white
        self.thirtySecondButton.backgroundColor = .clear
        
        self.sixtySecondButton.tintColor = .white
        self.sixtySecondButton.backgroundColor = .clear
        
        self.timerDurationLabel.text = "00:20"
        self.timerCount = 20
    }
    
    @objc func didTapThirtySeconds() {
        self.thirtySecondButton.tintColor = .kwiksTextBlack
        self.thirtySecondButton.backgroundColor = .white
        
        self.tenSecondButton.tintColor = .white
        self.tenSecondButton.backgroundColor = .clear
        
        self.twentySecondButton.tintColor = .white
        self.twentySecondButton.backgroundColor = .clear
        
        self.sixtySecondButton.tintColor = .white
        self.sixtySecondButton.backgroundColor = .clear
        
        self.timerDurationLabel.text = "00:30"
        self.timerCount = 30
    }
    
    @objc func didTapSixtySeconds() {
        self.sixtySecondButton.tintColor = .kwiksTextBlack
        self.sixtySecondButton.backgroundColor = .white
        
        self.tenSecondButton.tintColor = .white
        self.tenSecondButton.backgroundColor = .clear
        
        self.twentySecondButton.tintColor = .white
        self.twentySecondButton.backgroundColor = .clear
        
        self.thirtySecondButton.tintColor = .white
        self.thirtySecondButton.backgroundColor = .clear
        
        self.timerDurationLabel.text = "00:60"
        self.timerCount = 60
    }
    
    @objc func didTapBeautify() {
        print(#function)
    }
    
    @objc func didTapShapes() {
        print(#function)
    }
    
    @objc func didTapUnknown() {
        print(#function)
    }
    
    @objc func didTapEffects() {
        isShowingOptions.toggle()
        
        if isShowingOptions == true {
            self.closeButton.alpha = 0
            self.cameraLightButton.alpha = 0
            self.addMusicContainerView.alpha = 0
            
            self.closeButton.isUserInteractionEnabled = false
            self.cameraLightButton.isUserInteractionEnabled = false
            self.hiddenAddMusicButton.isUserInteractionEnabled = false
            
            self.containerView.layoutIfNeeded()
            self.mainContainerBottomConstraint?.constant = -126
            
            UIView.animate(withDuration: 0.33) {
                self.containerView.layoutIfNeeded()
            }
            
            UIView.animate(withDuration: 0.15, delay: 0.1, options: .curveLinear, animations: {
                self.effectsIconImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                
            }) { (success) in
                UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear, animations: {
                    self.effectsIconImageView.transform = .identity
                    self.effectsIconImageView.image = UIImage(named: "SelectedEffectsIcon")
                    self.effectsButton.backgroundColor = UIColor(red: 0.604, green: 0.906, blue: 0.412, alpha: 0.21)
                }, completion: nil)
            }
            
        } else {
            self.closeButton.isUserInteractionEnabled = true
            self.cameraLightButton.isUserInteractionEnabled = true
            self.hiddenAddMusicButton.isUserInteractionEnabled = true
            
            UIView.animate(withDuration: 0.15, delay: 0.1, options: .curveLinear, animations: {
                self.effectsIconImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                
            }) { (success) in
                UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear, animations: {
                    self.effectsIconImageView.transform = .identity
                    self.effectsIconImageView.image = UIImage(named: "EffectsIcon")
                    self.effectsButton.backgroundColor = UIColor.clear
                }, completion: { _ in
                    UIView.animate(withDuration: 0.33) {
                        self.closeButton.alpha = 1
                        self.cameraLightButton.alpha = 1
                        self.addMusicContainerView.alpha = 1
                        
                        self.mainContainerBottomConstraint?.constant = 0
                    }
                })
            }
        }
    }
    
    @objc func didTapUpload() {
        let fileSaveVC = VideoFileSaveController()
        self.navigationController?.pushViewController(fileSaveVC, animated: true)
    }
    
    @objc func didTapRecord() {
        UIView.animate(withDuration: 0.75) {
            self.timerContainer.alpha = 0
            self.isShowingTimer = false
        }
        
        self.recordButton.alpha = 0
        self.recordAnimation.duration = CFTimeInterval(self.timerCount)
        
        if !self.isRecording {
            
            UIView.animate(withDuration: 0.50) {
                self.recordButton.alpha = 1
                self.recordButton.backgroundColor = UIColor.kwiksGreen.withAlphaComponent(0.50)
                self.recordButton.setImage(self.stopImageIcon, for: .normal)
            }
            
            self.recordAnimation.toValue = 1
            self.isRecording = true
            
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCounter), userInfo: nil, repeats: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.shapeLayer.add(self.recordAnimation, forKey: "animation")
            }
            
        } else {
            
            UIView.animate(withDuration: 0.50) {
                self.recordButton.alpha = 1
                self.recordButton.backgroundColor = UIColor.kwiksGreen
                self.recordButton.setImage(self.playImageIcon, for: .normal)
            }
            
            self.timerDurationLabel.text = ""
            self.recordAnimation.toValue = 0
            self.isRecording = false
            self.timer.invalidate()
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.shapeLayer.add(self.recordAnimation, forKey: "animation")
            }
        }
    }
    
    @objc func didTapCamera() {
        print(#function)
    }
    
    @objc func didTapTemplates() {
        print(#function)
    }
}
//MARK: - Collectionview DataSource & Delegate
extension VideoController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.effectsExamples.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EffectsCollectionViewCell.identifier, for: indexPath) as! EffectsCollectionViewCell
        let effect = self.effectsExamples[indexPath.item]
        cell.configure(with: effect)
        return cell
    }
}
