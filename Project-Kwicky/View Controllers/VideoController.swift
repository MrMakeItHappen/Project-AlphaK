//
//  VideoController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/19/23.
//

import UIKit

final class VideoController: UIViewController {
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
    
    private let unknownShapeLabel: UILabel = {
        let label = UILabel()
        label.text = "Shapes"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let unknownShapeIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(28)
        imageView.width(28)
        
        let image = UIImage(named: "UnknownIcon")
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
    
    private let shapeLabel: UILabel = {
        let label = UILabel()
        label.text = "Shapes"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let shapeIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(28)
        imageView.width(28)
        
        let image = UIImage(named: "ShapesIcon")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutTopUI()
        self.layoutBottomUI()
        self.layoutLeadingUI()
    }
}
//MARK: - Configure View Controller
extension VideoController {
    private func configure() {
        self.view.backgroundColor = .black
        self.closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        self.cameraLightButton.addTarget(self, action: #selector(didTapCameraLight), for: .touchDown)
        
        self.hiddenAddMusicButton.addTarget(self, action: #selector(didTapAddMusic), for: .touchDown)
        self.hiddenRecordButton.addTarget(self, action: #selector(didTapRecord), for: .touchDown)
        
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
        self.view.addSubview(self.addMusicContainerView)
        self.addMusicContainerView.topToSuperview(usingSafeArea: true)
        self.addMusicContainerView.centerXToSuperview()
        
        self.addMusicContainerView.addSubview(self.addMusicIconImageView)
        self.addMusicIconImageView.centerYToSuperview()
        self.addMusicIconImageView.leftToSuperview(offset: 15)
        
        self.addMusicContainerView.addSubview(self.addMusicLabel)
        self.addMusicLabel.centerYToSuperview()
        self.addMusicLabel.leftToRight(of: self.addMusicIconImageView, offset: 12)
        
        self.view.addSubview(self.hiddenAddMusicButton)
        self.hiddenAddMusicButton.top(to: self.addMusicContainerView)
        self.hiddenAddMusicButton.bottom(to: self.addMusicContainerView)
        self.hiddenAddMusicButton.left(to: self.addMusicContainerView)
        self.hiddenAddMusicButton.right(to: self.addMusicContainerView)
        
        self.view.addSubview(self.closeButton)
        self.closeButton.centerY(to: self.addMusicContainerView)
        self.closeButton.rightToLeft(of: self.addMusicContainerView, offset: -80)
        
        self.view.addSubview(self.cameraLightButton)
        self.cameraLightButton.centerY(to: self.addMusicContainerView)
        self.cameraLightButton.leftToRight(of: self.addMusicContainerView, offset: 80)
    }
    
    private func layoutBottomUI() {
        self.view.addSubview(self.cameraSelectionView)
        self.cameraSelectionView.bottomToSuperview(usingSafeArea: true)
        self.cameraSelectionView.centerXToSuperview()
        
        self.view.addSubview(self.cameraLabel)
        self.cameraLabel.centerXToSuperview()
        self.cameraLabel.bottomToTop(of: self.cameraSelectionView, offset: -10)
        
        self.view.addSubview(self.templatesLabel)
        self.templatesLabel.leftToRight(of: self.cameraLabel, offset: 22)
        self.templatesLabel.centerY(to: self.cameraLabel)
        
        self.view.addSubview(self.recordIconImageView)
        self.recordIconImageView.centerXToSuperview()
        self.recordIconImageView.bottomToTop(of: self.cameraLabel, offset: -20)
        
        self.view.addSubview(self.hiddenRecordButton)
        self.hiddenRecordButton.top(to: self.recordIconImageView, offset: -2)
        self.hiddenRecordButton.right(to: self.recordIconImageView, offset: 2)
        self.hiddenRecordButton.left(to: self.recordIconImageView, offset: -2)
        self.hiddenRecordButton.bottom(to: self.recordIconImageView, offset: 2)
        
        self.view.addSubview(self.effectsIconImageView)
        self.effectsIconImageView.centerY(to: self.recordIconImageView)
        self.effectsIconImageView.rightToLeft(of: self.recordIconImageView, offset: -50)
        
        self.view.addSubview(self.effectsButton)
        self.effectsButton.top(to: self.effectsIconImageView, offset: -15)
        self.effectsButton.right(to: self.effectsIconImageView, offset: 15)
        self.effectsButton.left(to: self.effectsIconImageView, offset: -15)
        self.effectsButton.bottom(to: self.effectsIconImageView, offset: 15)
        
        self.view.addSubview(self.effectsLabel)
        self.effectsLabel.centerX(to: self.effectsIconImageView)
        self.effectsLabel.topToBottom(of: self.effectsButton, offset: 5)
        
        self.view.addSubview(self.uploadIconImageView)
        self.uploadIconImageView.centerY(to: self.recordIconImageView)
        self.uploadIconImageView.leftToRight(of: self.recordIconImageView, offset: 50)
        
        self.view.addSubview(self.uploadVideoButton)
        self.uploadVideoButton.top(to: self.uploadIconImageView, offset: -15)
        self.uploadVideoButton.right(to: self.uploadIconImageView, offset: 15)
        self.uploadVideoButton.left(to: self.uploadIconImageView, offset: -15)
        self.uploadVideoButton.bottom(to: self.uploadIconImageView, offset: 15)
        
        self.view.addSubview(self.uploadLabel)
        self.uploadLabel.centerX(to: self.uploadIconImageView)
        self.uploadLabel.topToBottom(of: self.uploadVideoButton, offset: 5)
    }
    
    private func layoutLeadingUI() {
        self.view.addSubview(self.unknownShapeLabel)
        self.unknownShapeLabel.leftToSuperview(offset: 23)
        self.unknownShapeLabel.bottomToTop(of: self.hiddenRecordButton, offset: -55)
        
        self.view.addSubview(self.unknownShapeIconImageView)
        self.unknownShapeIconImageView.bottomToTop(of: self.unknownShapeLabel, offset: -8)
        self.unknownShapeIconImageView.centerX(to: self.unknownShapeLabel)
        
        self.view.addSubview(self.hiddenUnknownShapeButton)
        self.hiddenUnknownShapeButton.top(to: self.unknownShapeIconImageView, offset: -2)
        self.hiddenUnknownShapeButton.right(to: self.unknownShapeLabel, offset: 2)
        self.hiddenUnknownShapeButton.left(to: self.unknownShapeLabel, offset: -2)
        self.hiddenUnknownShapeButton.bottom(to: self.unknownShapeLabel, offset: 2)
        
        self.view.addSubview(self.shapeLabel)
        self.shapeLabel.left(to: self.unknownShapeLabel)
        self.shapeLabel.bottomToTop(of: self.unknownShapeIconImageView, offset: -28)
        
        self.view.addSubview(self.shapeIconImageView)
        self.shapeIconImageView.bottomToTop(of: self.shapeLabel, offset: -8)
        self.shapeIconImageView.centerX(to: self.unknownShapeLabel)
        
        self.view.addSubview(self.hiddenShapeButton)
        self.hiddenShapeButton.top(to: self.shapeIconImageView, offset: -2)
        self.hiddenShapeButton.right(to: self.shapeLabel, offset: 2)
        self.hiddenShapeButton.left(to: self.shapeLabel, offset: -2)
        self.hiddenShapeButton.bottom(to: self.shapeLabel, offset: 2)
        
        self.view.addSubview(self.beautifyLabel)
        self.beautifyLabel.centerX(to: self.unknownShapeLabel)
        self.beautifyLabel.bottomToTop(of: self.shapeIconImageView, offset: -28)
        
        self.view.addSubview(self.beautifyIconImageView)
        self.beautifyIconImageView.bottomToTop(of: self.beautifyLabel, offset: -8)
        self.beautifyIconImageView.centerX(to: self.unknownShapeLabel)
        
        self.view.addSubview(self.hiddenBeautifyButton)
        self.hiddenBeautifyButton.top(to: self.beautifyIconImageView, offset: -2)
        self.hiddenBeautifyButton.right(to: self.beautifyLabel, offset: 2)
        self.hiddenBeautifyButton.left(to: self.beautifyLabel, offset: -2)
        self.hiddenBeautifyButton.bottom(to: self.beautifyLabel, offset: 2)
        
        self.view.addSubview(self.timerLabel)
        self.timerLabel.centerX(to: self.unknownShapeLabel)
        self.timerLabel.bottomToTop(of: self.beautifyIconImageView, offset: -28)
        
        self.view.addSubview(self.timerIconImageView)
        self.timerIconImageView.bottomToTop(of: self.timerLabel, offset: -8)
        self.timerIconImageView.centerX(to: self.unknownShapeLabel)
        
        self.view.addSubview(self.hiddenTimerButton)
        self.hiddenTimerButton.top(to: self.timerIconImageView, offset: -2)
        self.hiddenTimerButton.right(to: self.timerLabel, offset: 2)
        self.hiddenTimerButton.left(to: self.timerLabel, offset: -2)
        self.hiddenTimerButton.bottom(to: self.timerLabel, offset: 2)
        
        self.view.addSubview(self.flipLabel)
        self.flipLabel.centerX(to: self.unknownShapeLabel)
        self.flipLabel.bottomToTop(of: self.timerIconImageView, offset: -28)
        
        self.view.addSubview(self.flipIconImageView)
        self.flipIconImageView.bottomToTop(of: self.flipLabel, offset: -8)
        self.flipIconImageView.centerX(to: self.unknownShapeLabel)
        
        self.view.addSubview(self.hiddenFlipButton)
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
        print(#function)
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
        print(#function)
    }
    
    @objc func didTapUpload() {
        print(#function)
    }
    
    @objc func didTapRecord() {
        print(#function)
    }
    
    @objc func didTapCamera() {
        print(#function)
    }
    
    @objc func didTapTemplates() {
        print(#function)
    }
}
