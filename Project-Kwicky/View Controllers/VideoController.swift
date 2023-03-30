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
    
    var isShowingOptions = false
    var mainContainerBottomConstraint: NSLayoutConstraint?
    var userCreatedVideo: KwiksVideo?
    var popUpAlert = KwiksSystemPopups()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor.black
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
    
    private let templatesLabel: UILabel = {
        let label = UILabel()
        label.text = "Templates"
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
    
    private let recordIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(130)
        imageView.width(130)
        
        let image = UIImage(named: "KwiksVideoRecordIcon")
        imageView.image = image
        return imageView
    }()
    
    private let hiddenRecordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutTopUI()
        self.layoutBottomUI()
        self.layoutLeadingUI()
        
        _allAvailableVideoMusic = AvailableMusic.allTempSongs
    }
}
//MARK: - Configure View Controller
extension VideoController {
    private func configure() {
        self.view.backgroundColor = UIColor(hexString: "#202020")
        
        self.closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        self.cameraLightButton.addTarget(self, action: #selector(didTapCameraLight), for: .touchDown)
        
        self.hiddenAddMusicButton.addTarget(self, action: #selector(didTapAddMusic), for: .touchDown)
        self.hiddenRecordButton.addTarget(self, action: #selector(didTapRecord), for: .touchDown)
        
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
        
        self.containerView.addSubview(self.templatesLabel)
        self.templatesLabel.leftToRight(of: self.cameraLabel, offset: 22)
        self.templatesLabel.centerY(to: self.cameraLabel)
        
        self.containerView.addSubview(self.hiddenTemplatesButton)
        self.hiddenTemplatesButton.top(to: self.templatesLabel, offset: -2)
        self.hiddenTemplatesButton.right(to: self.templatesLabel, offset: 2)
        self.hiddenTemplatesButton.left(to: self.templatesLabel, offset: -2)
        self.hiddenTemplatesButton.bottom(to: self.templatesLabel, offset: 2)
        
        self.containerView.addSubview(self.recordIconImageView)
        self.recordIconImageView.centerXToSuperview()
        self.recordIconImageView.bottomToTop(of: self.cameraLabel, offset: -20)
        
        self.containerView.addSubview(self.hiddenRecordButton)
        self.hiddenRecordButton.top(to: self.recordIconImageView, offset: -2)
        self.hiddenRecordButton.right(to: self.recordIconImageView, offset: 2)
        self.hiddenRecordButton.left(to: self.recordIconImageView, offset: -2)
        self.hiddenRecordButton.bottom(to: self.recordIconImageView, offset: 2)
        
        self.containerView.addSubview(self.effectsIconImageView)
        self.effectsIconImageView.centerY(to: self.recordIconImageView)
        self.effectsIconImageView.rightToLeft(of: self.recordIconImageView, offset: -50)
        
        self.containerView.addSubview(self.effectsButton)
        self.effectsButton.top(to: self.effectsIconImageView, offset: -15)
        self.effectsButton.right(to: self.effectsIconImageView, offset: 15)
        self.effectsButton.left(to: self.effectsIconImageView, offset: -15)
        self.effectsButton.bottom(to: self.effectsIconImageView, offset: 15)
        
        self.containerView.addSubview(self.effectsLabel)
        self.effectsLabel.centerX(to: self.effectsIconImageView)
        self.effectsLabel.topToBottom(of: self.effectsButton, offset: 5)
        
        self.containerView.addSubview(self.uploadIconImageView)
        self.uploadIconImageView.centerY(to: self.recordIconImageView)
        self.uploadIconImageView.leftToRight(of: self.recordIconImageView, offset: 50)
        
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
        self.stickersLabel.bottomToTop(of: self.hiddenRecordButton, offset: -55)
        
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
        print(#function)
        self.popUpAlert = KwiksSystemPopups(presentingViewController: self, popupType: .UpdateKwiks)
        self.popUpAlert.engagePopup()
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
