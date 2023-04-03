//
//  SoloVideoCallController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/1/23.
//

import UIKit

final class SoloVideoCallController: UIViewController {
    private var timer: Timer = Timer()
    private var timerCount: Int = 0
    private var isShowingMoreOptions = false

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
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 18
        stackView.height(50)
        return stackView
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
        
        self.buttonStackView.addArrangedSubview(self.effectsButton)
        self.buttonStackView.addArrangedSubview(self.volumeButton)
        self.buttonStackView.addArrangedSubview(self.videoButton)
        self.buttonStackView.addArrangedSubview(self.endCallButton)
        self.buttonStackView.addArrangedSubview(self.moreOptionsButton)
        
        self.view.addSubview(self.buttonStackView)
        self.buttonStackView.bottomToSuperview(usingSafeArea: true)
        self.buttonStackView.leftToSuperview(offset: 30)
        self.buttonStackView.rightToSuperview(offset: -30)
        
        self.view.addSubview(self.sendMessageButton)
        self.sendMessageButton.right(to: self.buttonStackView)
        self.sendMessageButton.bottomToTop(of: self.buttonStackView, offset: -15)
        
        self.view.addSubview(self.giftButton)
        self.giftButton.right(to: self.sendMessageButton)
        self.giftButton.bottomToTop(of: self.sendMessageButton, offset: -10)
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
        print(#function)
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
        print(#function)
        
        if !isShowingMoreOptions {
            UIView.animate(withDuration: 0.50) {
                self.moreOptionsButton.transform = self.moreOptionsButton.transform.rotated(by: CGFloat(Double(180) * .pi / 180))
                
                self.sendMessageButton.alpha = 1
                self.giftButton.alpha = 1
            }
            
            self.isShowingMoreOptions = true
            
        } else {
            UIView.animate(withDuration: 0.50) {
                self.moreOptionsButton.transform = self.moreOptionsButton.transform.rotated(by: CGFloat(Double(180) * .pi / 180))
                
                self.sendMessageButton.alpha = 0
                self.giftButton.alpha = 0
            }
            
            self.isShowingMoreOptions = false
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
