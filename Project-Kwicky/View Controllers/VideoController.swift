//
//  VideoController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/19/23.
//

import UIKit
import KwiksSystemsPopups

//TODO: Fetch any available music here. Can be processed in the background while user makes video adjustments.
//TODO: Convert timerCount to date. Default countdown should be 3 minutes.

final class VideoController: UIViewController {
    var userCreatedVideo: KwiksVideo?
    private var beautify: Beautify = Beautify(type: .none, smoothValue: 50, contrastValue: 50, lipsValue: 50, teethValue: 50, lipstickValue: 50, contourValue: 50)
    
    private let effectsExamples = Effect.effectExamples
    private let beautifyData = Effect.beautifyExamples
    private let stickerExamples = Sticker.allTempStickers
    private var timer: Timer = Timer()
    private var timerCount: Int = 60
    
    private let stopImageIcon = UIImage(systemName: "stop.fill")
    private let playImageIcon = UIImage(named: "KwiksLogoWhite")
    
    private var isShowingOptions = false
    private var isShowingTimer = false
    private var isShowingBeautify = false
    private var isShowingStickers = false
    private var isRecording = false
    private var mainContainerBottomConstraint: NSLayoutConstraint?
    private var popUpAlert = KwiksSystemPopups()
    private var beautifyIndexPath: IndexPath?
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor.kwiksTextBlack
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
    
    private let hiddenLiveButton: UIButton = {
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
        button.layer.borderColor = UIColor(hexString: "#575757").cgColor
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
        button.layer.borderColor = UIColor(hexString: "#575757").cgColor
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
    
    private let hiddenStickersButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let stickerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor.clear
        view.roundCorners(corners: [.topLeft, .topRight], radius: 26)
        view.alpha = 0
        return view
    }()
    
    private let blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        return blurView
    }()
    
    private lazy var trendingCategoryButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .segoeUIRegular(size: 14)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("Trending", attributes: attributeContainer)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapTrending()
        }))
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 0.50
        button.layer.borderColor = UIColor.kwiksGreen.cgColor
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.60)
        button.width(75)
        button.height(30)
        return button
    }()
    
    private lazy var newCategoryButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .segoeUIRegular(size: 14)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("New", attributes: attributeContainer)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapNew()
        }))
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 0.50
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.60)
        button.width(48)
        button.height(30)
        return button
    }()
    
    private lazy var funnyCategoryButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .segoeUIRegular(size: 14)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("Funny", attributes: attributeContainer)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapFunny()
        }))
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 0.50
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.60)
        button.width(57)
        button.height(30)
        return button
    }()
    
    private lazy var interactiveCategoryButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .segoeUIRegular(size: 14)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("Interactive", attributes: attributeContainer)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapInteractive()
        }))
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 0.50
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.60)
        button.width(83)
        button.height(30)
        return button
    }()
    
    private lazy var animalCategoryButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .segoeUIRegular(size: 14)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("Animal", attributes: attributeContainer)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapAnimal()
        }))
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 0.50
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.60)
        button.width(67)
        button.height(30)
        return button
    }()
    
    private lazy var stickerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
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
        collectionView.register(StickerCollectionViewCell.self, forCellWithReuseIdentifier: StickerCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.tag = 2
        return collectionView
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
    
    private let hiddenCropButton: UIButton = {
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
        collectionView.tag = 0
        return collectionView
    }()
    
    private let faceLabel: UILabel = {
        let label = UILabel()
        label.text = "Face"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 15)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.isUserInteractionEnabled = false
        label.alpha = 0
        return label
    }()
    
    private lazy var progressSlider: UISlider = {
        let slider = UISlider()
        let configuration = UIImage.SymbolConfiguration(pointSize: 20)
        let image = UIImage(systemName: "circle.fill", withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        slider.setThumbImage(image, for: .normal)
        slider.setThumbImage(image, for: .highlighted)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.backgroundColor = .clear
        slider.layer.masksToBounds = true
        slider.isContinuous = true
        slider.minimumTrackTintColor = UIColor.kwiksGreen
        slider.maximumTrackTintColor = UIColor.white
        slider.value = 50
        slider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
        slider.alpha = 0
        slider.isUserInteractionEnabled = false
        return slider
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "50"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 16)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.alpha = 0
        return label
    }()
    
    private lazy var beautifyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 80)
        layout.minimumInteritemSpacing = 18
        layout.minimumLineSpacing = 18
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(BeautifyCollectionViewCell.self, forCellWithReuseIdentifier: BeautifyCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.height(82)
        collectionView.alpha = 0
        collectionView.isUserInteractionEnabled = false
        collectionView.tag = 1
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
    
    private lazy var videoSetupButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: "ForwardArrow")
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapSetup()
        }))
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.kwiksGreen
        button.width(186)
        button.height(50)
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutTopUI()
        self.layoutBottomUI()
        self.layoutLeadingUI()
        
        _allAvailableVideoMusic = Music.allTempSongs
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.addShapeLayers()
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
        
        self.hiddenLiveButton.addTarget(self, action: #selector(didTapLive), for: .touchDown)
        self.hiddenStickersButton.addTarget(self, action: #selector(didTapSticker), for: .touchDown)
        self.hiddenCropButton.addTarget(self, action: #selector(didTapCrop), for: .touchDown)
        
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
        
        //Temp. Remove after testing
        let backgroundImage = UIImage(named: "FemalePlaceholder02")
        let backgroundImageView = UIImageView(frame: .zero)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = backgroundImage
        
        self.containerView.addSubview(backgroundImageView)
        backgroundImageView.edgesToSuperview()
        //
        
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
        
        self.containerView.addSubview(self.hiddenLiveButton)
        self.hiddenLiveButton.top(to: self.liveLabel, offset: -2)
        self.hiddenLiveButton.right(to: self.liveLabel, offset: 2)
        self.hiddenLiveButton.left(to: self.liveLabel, offset: -2)
        self.hiddenLiveButton.bottom(to: self.liveLabel, offset: 2)
        
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
        
        self.containerView.addSubview(self.beautifyCollectionView)
        self.beautifyCollectionView.leftToSuperview(offset: 30)
        self.beautifyCollectionView.rightToSuperview()
        self.beautifyCollectionView.bottomToSuperview(usingSafeArea: true)
        
        self.containerView.addSubview(self.faceLabel)
        self.faceLabel.bottomToTop(of: self.beautifyCollectionView, offset: -12)
        self.faceLabel.left(to: self.beautifyCollectionView)
        
        self.containerView.addSubview(self.progressSlider)
        self.progressSlider.bottomToTop(of: self.faceLabel, offset: -10)
        self.progressSlider.leftToSuperview(offset: 30)
        self.progressSlider.rightToSuperview(offset: -30)
        
        self.containerView.addSubview(self.progressLabel)
        self.progressLabel.bottomToTop(of: self.progressSlider, offset: -10)
        self.progressLabel.centerXToSuperview()
        
        self.containerView.addSubview(self.videoSetupButton)
        self.videoSetupButton.centerXToSuperview()
        self.videoSetupButton.bottomToSuperview(usingSafeArea: true)
    }
    
    private func layoutLeadingUI() {
        self.containerView.addSubview(self.stickersLabel)
        self.stickersLabel.leftToSuperview(offset: 23)
        self.stickersLabel.bottomToTop(of: self.recordButton, offset: -80)
        
        self.containerView.addSubview(self.stickersIconImageView)
        self.stickersIconImageView.bottomToTop(of: self.stickersLabel, offset: -8)
        self.stickersIconImageView.centerX(to: self.stickersLabel)
        
        self.containerView.addSubview(self.hiddenStickersButton)
        self.hiddenStickersButton.top(to: self.stickersIconImageView, offset: -2)
        self.hiddenStickersButton.right(to: self.stickersLabel, offset: 2)
        self.hiddenStickersButton.left(to: self.stickersLabel, offset: -2)
        self.hiddenStickersButton.bottom(to: self.stickersLabel, offset: 2)
        
        self.containerView.addSubview(self.stickerContainer)
        self.stickerContainer.bottomToSuperview()
        self.stickerContainer.leftToSuperview()
        self.stickerContainer.rightToSuperview()
        self.stickerContainer.topToBottom(of: self.stickersLabel, offset: 20)
        
        self.stickerContainer.addSubview(self.blurView)
        self.blurView.edgesToSuperview()
        self.stickerContainer.sendSubviewToBack(self.blurView)
        
        self.stickerContainer.addSubview(self.trendingCategoryButton)
        self.trendingCategoryButton.leftToSuperview(offset: 20)
        self.trendingCategoryButton.topToSuperview(offset: 27)
        
        self.stickerContainer.addSubview(self.newCategoryButton)
        self.newCategoryButton.centerY(to: self.trendingCategoryButton)
        self.newCategoryButton.leftToRight(of: self.trendingCategoryButton, offset: 5)
        
        self.stickerContainer.addSubview(self.funnyCategoryButton)
        self.funnyCategoryButton.centerY(to: self.trendingCategoryButton)
        self.funnyCategoryButton.leftToRight(of: self.newCategoryButton, offset: 5)
        
        self.stickerContainer.addSubview(self.interactiveCategoryButton)
        self.interactiveCategoryButton.centerY(to: self.trendingCategoryButton)
        self.interactiveCategoryButton.leftToRight(of: self.funnyCategoryButton, offset: 5)
        
        self.stickerContainer.addSubview(self.animalCategoryButton)
        self.animalCategoryButton.centerY(to: self.trendingCategoryButton)
        self.animalCategoryButton.leftToRight(of: self.interactiveCategoryButton, offset: 5)
        
        self.stickerContainer.addSubview(self.stickerCollectionView)
        self.stickerCollectionView.topToBottom(of: self.trendingCategoryButton, offset: 20)
        self.stickerCollectionView.left(to: self.trendingCategoryButton)
        self.stickerCollectionView.right(to: self.animalCategoryButton)
        self.stickerCollectionView.bottomToSuperview(offset: -20)
        
        self.containerView.addSubview(self.cropLabel)
        self.cropLabel.centerX(to: self.stickersLabel)
        self.cropLabel.bottomToTop(of: self.stickersIconImageView, offset: -28)
        
        self.containerView.addSubview(self.cropIconImageView)
        self.cropIconImageView.bottomToTop(of: self.cropLabel, offset: -8)
        self.cropIconImageView.centerX(to: self.stickersLabel)
        
        self.containerView.addSubview(self.hiddenCropButton)
        self.hiddenCropButton.top(to: self.cropIconImageView, offset: -2)
        self.hiddenCropButton.right(to: self.cropLabel, offset: 2)
        self.hiddenCropButton.left(to: self.cropLabel, offset: -2)
        self.hiddenCropButton.bottom(to: self.cropLabel, offset: 2)
        
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
    
    private func startVideoTimer() {
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
    }
    
    private func endVideoTimer() {
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
    
    private func addShapeLayers() {
        let circlePath = UIBezierPath(arcCenter: recordButton.center, radius: 46, startAngle: -(.pi / 2), endAngle: .pi * 2, clockwise: true)
        self.shapeLayer.path = circlePath.cgPath
        self.trackLayer.path = circlePath.cgPath
        
        self.view.layer.addSublayer(self.trackLayer)
        self.view.layer.addSublayer(self.shapeLayer)
    }
    
    private func hideNonBeautifyOptions() {
        
        UIView.animate(withDuration: 0.75) {
            self.flipIconImageView.alpha = 0
            self.flipLabel.alpha = 0
            self.hiddenFlipButton.isUserInteractionEnabled = false
            
            self.timerIconImageView.alpha = 0
            self.timerLabel.alpha = 0
            self.hiddenTimerButton.isUserInteractionEnabled = false
            
            self.cropIconImageView.alpha = 0
            self.cropLabel.alpha = 0
            self.hiddenCropButton.isUserInteractionEnabled = false
            
            self.stickersIconImageView.alpha = 0
            self.stickersLabel.alpha = 0
            self.hiddenStickersButton.isUserInteractionEnabled = false
            
            self.closeButton.alpha = 0
            self.closeButton.isUserInteractionEnabled = false
            
            self.addMusicContainerView.alpha = 0
            self.addMusicContainerView.isUserInteractionEnabled = false
            
            self.cameraLightButton.alpha = 0
            self.cameraLightButton.isUserInteractionEnabled = false
            
            self.cameraSelectionView.alpha = 0
            self.recordButton.alpha = 0
            self.recordButton.isUserInteractionEnabled = false
            
            self.shapeLayer.isHidden = true
            self.trackLayer.isHidden = true
            
            self.cameraLabel.alpha = 0
            self.liveLabel.alpha = 0
            self.hiddenLiveButton.alpha = 0
            self.hiddenLiveButton.isUserInteractionEnabled = false
            
            self.effectsLabel.alpha = 0
            self.effectsIconImageView.alpha = 0
            self.effectsButton.alpha = 0
            self.effectsButton.isUserInteractionEnabled = false
            
            self.uploadLabel.alpha = 0
            self.uploadIconImageView.alpha = 0
            self.uploadVideoButton.alpha = 0
            self.uploadVideoButton.isUserInteractionEnabled = false
        } completion: { success in
            
            UIView.animate(withDuration: 0.50) {
                self.beautifyCollectionView.isUserInteractionEnabled = true
                self.beautifyCollectionView.alpha = 1
                self.faceLabel.alpha = 1
            }
            
        }
    }
    
    private func hideNonStickerOptions() {
        
        UIView.animate(withDuration: 0.75) {
            self.flipIconImageView.alpha = 0
            self.flipLabel.alpha = 0
            self.hiddenFlipButton.isUserInteractionEnabled = false
            
            self.timerIconImageView.alpha = 0
            self.timerLabel.alpha = 0
            self.hiddenTimerButton.isUserInteractionEnabled = false
            
            self.cropIconImageView.alpha = 0
            self.cropLabel.alpha = 0
            self.hiddenCropButton.isUserInteractionEnabled = false
            
            self.beautifyIconImageView.alpha = 0
            self.beautifyLabel.alpha = 0
            self.hiddenBeautifyButton.isUserInteractionEnabled = false
            
            self.closeButton.alpha = 0
            self.closeButton.isUserInteractionEnabled = false
            
            self.addMusicContainerView.alpha = 0
            self.addMusicContainerView.isUserInteractionEnabled = false
            
            self.cameraLightButton.alpha = 0
            self.cameraLightButton.isUserInteractionEnabled = false
            
            self.cameraSelectionView.alpha = 0
            self.recordButton.alpha = 0
            self.recordButton.isUserInteractionEnabled = false
            
            self.shapeLayer.isHidden = true
            self.trackLayer.isHidden = true
            
            self.cameraLabel.alpha = 0
            self.liveLabel.alpha = 0
            self.hiddenLiveButton.alpha = 0
            self.hiddenLiveButton.isUserInteractionEnabled = false
            
            self.effectsLabel.alpha = 0
            self.effectsIconImageView.alpha = 0
            self.effectsButton.alpha = 0
            self.effectsButton.isUserInteractionEnabled = false
            
            self.uploadLabel.alpha = 0
            self.uploadIconImageView.alpha = 0
            self.uploadVideoButton.alpha = 0
            self.uploadVideoButton.isUserInteractionEnabled = false
        } completion: { success in
            UIView.animate(withDuration: 0.70) {
                self.stickerContainer.alpha = 1
            }
        }
    }
    
    private func showAllOptions() {
        self.faceLabel.alpha = 0
        self.faceLabel.isUserInteractionEnabled = false
        
        self.progressLabel.alpha = 0
        self.progressSlider.alpha = 0
        self.progressSlider.isUserInteractionEnabled = false
        
        self.beautifyCollectionView.alpha = 0
        self.beautifyCollectionView.isUserInteractionEnabled = false
        
        self.stickerContainer.alpha = 0
        
        UIView.animate(withDuration: 0.75) {
            self.flipIconImageView.alpha = 1
            self.flipLabel.alpha = 1
            self.hiddenFlipButton.isUserInteractionEnabled = true
            
            self.timerIconImageView.alpha = 1
            self.timerLabel.alpha = 1
            self.hiddenTimerButton.isUserInteractionEnabled = true
            
            self.beautifyIconImageView.alpha = 1
            self.beautifyLabel.alpha = 1
            self.hiddenBeautifyButton.isUserInteractionEnabled = true
            
            self.cropIconImageView.alpha = 1
            self.cropLabel.alpha = 1
            self.hiddenCropButton.isUserInteractionEnabled = true
            
            self.stickersIconImageView.alpha = 1
            self.stickersLabel.alpha = 1
            self.hiddenStickersButton.isUserInteractionEnabled = true
            
            self.closeButton.alpha = 1
            self.closeButton.isUserInteractionEnabled = true
            
            self.addMusicContainerView.alpha = 1
            self.addMusicContainerView.isUserInteractionEnabled = true
            
            self.cameraLightButton.alpha = 1
            self.cameraLightButton.isUserInteractionEnabled = true
            
            self.cameraSelectionView.alpha = 1
            self.recordButton.alpha = 1
            self.recordButton.isUserInteractionEnabled = true
            
            self.cameraLabel.alpha = 1
            self.liveLabel.alpha = 1
            self.hiddenLiveButton.alpha = 1
            self.hiddenLiveButton.isUserInteractionEnabled = true
            
            self.effectsLabel.alpha = 1
            self.effectsIconImageView.alpha = 1
            self.effectsButton.alpha = 1
            self.effectsButton.isUserInteractionEnabled = true
            
            self.uploadLabel.alpha = 1
            self.uploadIconImageView.alpha = 1
            self.uploadVideoButton.alpha = 1
            self.uploadVideoButton.isUserInteractionEnabled = true
            
            self.shapeLayer.isHidden = false
            self.trackLayer.isHidden = false
        }
    }
    
    private func hideAllOptions() {
        self.cameraLightButton.isHidden = true
        
        self.flipLabel.isHidden = true
        self.flipIconImageView.isHidden = true
        self.hiddenFlipButton.isHidden = true
        
        self.timerLabel.isHidden = true
        self.timerIconImageView.isHidden = true
        self.hiddenTimerButton.isHidden = true
        
        self.beautifyLabel.isHidden = true
        self.beautifyIconImageView.isHidden = true
        self.hiddenBeautifyButton.isHidden = true
        
        self.cropLabel.isHidden = true
        self.cropIconImageView.isHidden = true
        self.hiddenCropButton.isHidden = true
        
        self.stickersLabel.isHidden = true
        self.stickersIconImageView.isHidden = true
        self.hiddenStickersButton.isHidden = true
        
        self.effectsLabel.alpha = 0
        self.effectsIconImageView.alpha = 0
        self.effectsButton.alpha = 0
        self.effectsButton.isUserInteractionEnabled = false
        
        self.uploadLabel.alpha = 0
        self.uploadIconImageView.alpha = 0
        self.uploadVideoButton.alpha = 0
        self.uploadVideoButton.isUserInteractionEnabled = false
        
        self.recordButton.alpha = 0
        self.recordButton.isUserInteractionEnabled = false
        
        self.cameraLabel.alpha = 0
        self.liveLabel.alpha = 0
        self.hiddenLiveButton.alpha = 0
        self.hiddenLiveButton.isUserInteractionEnabled = false
        
        self.shapeLayer.isHidden = true
        self.trackLayer.isHidden = true
        
        self.videoSetupButton.isHidden = false
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
        let addMusicVC = AddMusicToVideoController()
        self.navigationController?.pushViewController(addMusicVC, animated: true)
    }
    
    @objc func didTapFlipCamera() {
        self.hideAllOptions()
    }
    
    @objc func didTapTimer() {
        self.isShowingTimer.toggle()
        
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
    
    @objc func timerCounter() {
        var timeString = ""
        
        if self.timerCount > 0 {
            self.timerCount -= 1
            
        } else {
            self.timer.invalidate()
            self.timerCount = 0
            self.timerDurationLabel.text = "👍🏽"
            return
        }
        
        timeString += "00:"
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
        self.isShowingBeautify.toggle()
        
        if isShowingBeautify {
            self.hideNonBeautifyOptions()
        } else {
            self.showAllOptions()
        }
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider) {
        
        let roundedValue = Int(sender.value)
        
        switch self.beautify.type {
        case .smooth:
            self.beautify.smoothValue = roundedValue
            self.progressLabel.text = "\(roundedValue)"
            return
            
        case .contrast:
            self.beautify.contrastValue = roundedValue
            self.progressLabel.text = "\(roundedValue)"
            return
            
        case .lips:
            self.beautify.lipsValue = roundedValue
            self.progressLabel.text = "\(roundedValue)"
            return
            
        case .teeth:
            self.beautify.teethValue = roundedValue
            self.progressLabel.text = "\(roundedValue)"
            return
            
        case .lipstick:
            self.beautify.lipstickValue = roundedValue
            self.progressLabel.text = "\(roundedValue)"
            return
            
        case .contour:
            self.beautify.contourValue = roundedValue
            self.progressLabel.text = "\(roundedValue)"
            return
            
        default:
            return
        }
    }
    
    @objc func didTapCrop() {
        print(#function)
    }
    
    @objc func didTapSticker() {
        self.isShowingStickers.toggle()
        
        if isShowingStickers {
            self.hideNonStickerOptions()
        } else {
            self.showAllOptions()
        }
    }
    
    @objc func didTapTrending() {
        self.trendingCategoryButton.layer.borderColor = UIColor.kwiksGreen.cgColor
        
        self.newCategoryButton.layer.borderColor = UIColor.clear.cgColor
        self.funnyCategoryButton.layer.borderColor = UIColor.clear.cgColor
        self.interactiveCategoryButton.layer.borderColor = UIColor.clear.cgColor
        self.animalCategoryButton.layer.borderColor = UIColor.clear.cgColor
        
        //TODO: Download new sticker data. Then reload data.
        self.stickerCollectionView.reloadData()
    }
    
    @objc func didTapNew() {
        self.newCategoryButton.layer.borderColor = UIColor.kwiksGreen.cgColor
        
        self.trendingCategoryButton.layer.borderColor = UIColor.clear.cgColor
        self.funnyCategoryButton.layer.borderColor = UIColor.clear.cgColor
        self.interactiveCategoryButton.layer.borderColor = UIColor.clear.cgColor
        self.animalCategoryButton.layer.borderColor = UIColor.clear.cgColor
        
        //TODO: Download new sticker data. Then reload data.
        self.stickerCollectionView.reloadData()
    }
    
    @objc func didTapFunny() {
        self.funnyCategoryButton.layer.borderColor = UIColor.kwiksGreen.cgColor
        
        self.trendingCategoryButton.layer.borderColor = UIColor.clear.cgColor
        self.newCategoryButton.layer.borderColor = UIColor.clear.cgColor
        self.interactiveCategoryButton.layer.borderColor = UIColor.clear.cgColor
        self.animalCategoryButton.layer.borderColor = UIColor.clear.cgColor
        
        //TODO: Download new sticker data. Then reload data.
        self.stickerCollectionView.reloadData()
    }
    
    @objc func didTapInteractive() {
        self.interactiveCategoryButton.layer.borderColor = UIColor.kwiksGreen.cgColor
        
        self.trendingCategoryButton.layer.borderColor = UIColor.clear.cgColor
        self.newCategoryButton.layer.borderColor = UIColor.clear.cgColor
        self.funnyCategoryButton.layer.borderColor = UIColor.clear.cgColor
        self.animalCategoryButton.layer.borderColor = UIColor.clear.cgColor
        
        //TODO: Download new sticker data. Then reload data.
        self.stickerCollectionView.reloadData()
    }
    
    @objc func didTapAnimal() {
        self.animalCategoryButton.layer.borderColor = UIColor.kwiksGreen.cgColor
        
        self.trendingCategoryButton.layer.borderColor = UIColor.clear.cgColor
        self.newCategoryButton.layer.borderColor = UIColor.clear.cgColor
        self.funnyCategoryButton.layer.borderColor = UIColor.clear.cgColor
        self.interactiveCategoryButton.layer.borderColor = UIColor.clear.cgColor
        
        //TODO: Download new sticker data. Then reload data.
        self.stickerCollectionView.reloadData()
    }
    
    @objc func didTapEffects() {
        isShowingOptions.toggle()
        
        if isShowingOptions == true {
            self.closeButton.alpha = 0
            self.cameraLightButton.alpha = 0
            self.addMusicContainerView.alpha = 0
            self.shapeLayer.isHidden = true
            self.trackLayer.isHidden = true
            
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
                        self.containerView.layoutIfNeeded()
                    }
                })
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.shapeLayer.isHidden = false
                self.trackLayer.isHidden = false
            }
        }
    }
    
    @objc func didTapUpload() {
        print(#function)
    }
    
    //TODO: Configure for when no timer is selected
    @objc func didTapRecord() {
        self.deselectAllTimerButtons()
        
        UIView.animate(withDuration: 0.75) {
            self.timerContainer.alpha = 0
            self.isShowingTimer = false
        }
        
        self.recordButton.alpha = 0
        self.recordAnimation.duration = CFTimeInterval(self.timerCount)
        
        if !self.isRecording {
            self.startVideoTimer()
            
        } else {
            self.endVideoTimer()
        }
    }
    
    @objc func didTapCamera() {
        print(#function)
    }
    
    @objc func didTapLive() {
        print(#function)
    }
    
    @objc func didTapSetup() {
        let fileSaveVC = VideoShareController()
        self.navigationController?.pushViewController(fileSaveVC, animated: true)
    }
}
//MARK: - Collectionview DataSource & Delegate
extension VideoController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.tag {
        case 0:
            //Effects CollectionView
            return self.effectsExamples.count
            
        case 1:
            //Beautify CollectionView
            return self.beautifyData.count
            
        case 2:
            //Sticker CollectionView
            return self.stickerExamples.count
            
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 0:
            //Effects CollectionView
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EffectsCollectionViewCell.identifier, for: indexPath) as! EffectsCollectionViewCell
            let effect = self.effectsExamples[indexPath.item]
            cell.configure(with: effect)
            return cell
            
        case 1:
            //Beautify CollectionView
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeautifyCollectionViewCell.identifier, for: indexPath) as! BeautifyCollectionViewCell
            let effect = self.beautifyData[indexPath.item]
            cell.configure(with: effect)
            return cell
            
        case 2:
            //Sticker CollectionView
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerCollectionViewCell.identifier, for: indexPath) as! StickerCollectionViewCell
            let sticker = self.stickerExamples[indexPath.item]
            cell.configure(with: sticker)
            return cell
            
            //Shouldn't hit here. App will explode
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView.tag {
        case 0:
            //Effects CollectionView
            return
            
        case 1:
            //Beautify CollectionView
            if let cell = collectionView.cellForItem(at: indexPath) as? BeautifyCollectionViewCell {
                cell.iconImageView.layer.borderColor = UIColor.kwiksGreen.cgColor
                cell.iconImageView.tintColor = UIColor.kwiksGreen
                cell.iconImageView.layer.borderWidth = 1
            }
            
            self.progressLabel.alpha = 1
            self.progressSlider.alpha = 1
            self.progressSlider.isUserInteractionEnabled = true
            
            let beautyItem = indexPath.item
            
            switch beautyItem {
            case 0:
                self.beautify.type = .smooth
                self.progressSlider.value = Float(self.beautify.smoothValue)
                self.progressLabel.text = "\(self.beautify.smoothValue)"
                return
                
            case 1:
                self.beautify.type = .contrast
                self.progressSlider.value = Float(self.beautify.contrastValue)
                self.progressLabel.text = "\(self.beautify.contrastValue)"
                return
                
            case 2:
                self.beautify.type = .lips
                self.progressSlider.value = Float(self.beautify.lipsValue)
                self.progressLabel.text = "\(self.beautify.lipsValue)"
                return
                
            case 3:
                self.beautify.type = .teeth
                self.progressSlider.value = Float(self.beautify.teethValue)
                self.progressLabel.text = "\(self.beautify.teethValue)"
                return
                
            case 4:
                self.beautify.type = .lipstick
                self.progressSlider.value = Float(self.beautify.lipstickValue)
                self.progressLabel.text = "\(self.beautify.lipstickValue)"
                return
                
            case 5:
                self.beautify.type = .contour
                self.progressSlider.value = Float(self.beautify.contourValue)
                self.progressLabel.text = "\(self.beautify.contourValue)"
                return
                
            default:
                return
            }
            
        case 2:
            //Sticker CollectionView
            _ = self.stickerExamples[indexPath.item]
            //TODO: Drag and drop selected sticker onto video
            return
            
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? BeautifyCollectionViewCell {
            cell.iconImageView.layer.borderColor = UIColor.clear.cgColor
            cell.iconImageView.tintColor = UIColor.white
            cell.iconImageView.layer.borderWidth = 1
        }
    }
}
