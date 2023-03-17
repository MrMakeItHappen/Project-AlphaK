//
//  VideoFileSaveController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/16/23.
//

import UIKit

final class VideoFileSaveController: UIViewController {
    var userCreatedVideo: KwiksVideo?
    
    private lazy var customBackButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        button.height(23)
        button.width(33)
        button.setImage(UIImage(named: "KwiksBackArrow"), for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your New Video"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    private let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.systemBlue
        button.backgroundColor = UIColor.clear
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.font = .segoeUIRegular(size: 20)
        return button
    }()
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(201)
        imageView.width(140)
        
        let image = UIImage(named: "CoverPlaceholder")
        imageView.image = image
        return imageView
    }()
    
    private let adjustmentContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor.black.withAlphaComponent(0.80)
        view.roundCorners(corners: [.topLeft, .topRight], radius: 30)
        view.height(350)
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.delaysContentTouches = false
        scrollView.clipsToBounds = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let scrollViewContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 0
        view.clipsToBounds = true
        return view
    }()
    
    private let shareNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor(hexString: "#2D2D2D", alpha: 1)
        button.setTitle("Share Now", for: .normal)
        button.titleLabel?.font = .segoeUISemiBold(size: 15)
        button.layer.cornerRadius = 25
        button.height(50)
        return button
    }()
    
    private lazy var captionTextView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.backgroundColor = .clear
        textView.font = .segoeUIRegular(size: 18)
        textView.text = "Write a caption that describes your videos..."
        textView.textColor = .white
        textView.textAlignment = .center
        textView.delegate = self
        return textView
    }()
    
    private let adjustLabel: UILabel = {
        let label = UILabel()
        label.text = "Adjust Thumbnails"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let adjustChevronImageView = UIImageView.createChevron()
    private lazy var adjustHiddenButton = self.createHiddenButton(with: #selector(didTapAdjust))
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.text = "Tag People"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let tagChevronImageView = UIImageView.createChevron()
    private lazy var tagHiddenButton = self.createHiddenButton(with: #selector(didTapTag))
    
    private let commentsLabel: UILabel = {
        let label = UILabel()
        label.text = "Enable Comments"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let commentSwitch: UISwitch = {
        let uiswitch = UISwitch(frame: .zero)
        uiswitch.isOn = true
        uiswitch.onTintColor = .kwiksGreen
        uiswitch.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        return uiswitch
    }()
    
    private let addMusicLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Music"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let addMusicChevronImageView = UIImageView.createChevron()
    private lazy var addMusicHiddenButton = self.createHiddenButton(with: #selector(didTapAddMusic))
    
    private let advancedLabel: UILabel = {
        let label = UILabel()
        label.text = "Advanced Settings"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let advancedChevronImageView = UIImageView.createChevron()
    private lazy var advancedHiddenButton = self.createHiddenButton(with: #selector(didTapAdvanced))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Configure View Controller
extension VideoFileSaveController {
    private func configure() {
        self.view.backgroundColor = UIColor(hexString: "#202020")
        
        self.editButton.addTarget(self, action: #selector(didTapEdit), for: .touchUpInside)
        self.commentSwitch.addTarget(self, action: #selector(didChangeUISwitch), for: .valueChanged)
        self.shareNowButton.addTarget(self, action: #selector(didTapShareNow), for: .touchDown)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)
    }
}
//MARK: - Layout UI
extension VideoFileSaveController {
    private func layoutUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerY(to: self.customBackButton, offset: -2)
        self.titleLabel.leftToRight(of: self.customBackButton, offset: 18)
        
        self.view.addSubview(self.editButton)
        self.editButton.rightToSuperview(offset: -22)
        self.editButton.centerY(to: self.customBackButton)
        
        self.view.addSubview(self.coverImageView)
        self.coverImageView.topToBottom(of: self.titleLabel, offset: 48)
        self.coverImageView.centerXToSuperview()
        
        self.view.addSubview(self.adjustmentContainerView)
        self.adjustmentContainerView.bottomToSuperview()
        self.adjustmentContainerView.rightToSuperview()
        self.adjustmentContainerView.leftToSuperview()
        
        self.view.addSubview(self.captionTextView)
        self.captionTextView.topToBottom(of: self.coverImageView, offset: 41)
        self.captionTextView.leftToSuperview(offset: 20)
        self.captionTextView.rightToSuperview(offset: -20)
        self.captionTextView.bottomToTop(of: self.adjustmentContainerView, offset: -40)
        
        self.adjustmentContainerView.addSubview(self.shareNowButton)
        self.shareNowButton.bottomToSuperview(usingSafeArea: true)
        self.shareNowButton.leftToSuperview(offset: 30)
        self.shareNowButton.rightToSuperview(offset: -30)
        
        self.adjustmentContainerView.addSubview(self.scrollView)
        self.scrollView.topToSuperview(offset: 41)
        self.scrollView.leftToSuperview(offset: 40)
        self.scrollView.rightToSuperview(offset: -46)
        self.scrollView.bottomToTop(of: self.shareNowButton, offset: -20)
        
        self.scrollView.addSubview(self.scrollViewContentView)
        self.scrollViewContentView.edgesToSuperview()
        self.scrollViewContentView.width(to: self.scrollView)
        self.scrollViewContentView.addSubview(self.adjustLabel)
        self.adjustLabel.topToSuperview()
        self.adjustLabel.leftToSuperview()

        self.scrollViewContentView.addSubview(self.adjustChevronImageView)
        self.adjustChevronImageView.centerY(to: self.adjustLabel)
        self.adjustChevronImageView.rightToSuperview()

        self.scrollViewContentView.addSubview(self.adjustHiddenButton)
        self.adjustHiddenButton.top(to: self.adjustLabel, offset: 6)
        self.adjustHiddenButton.left(to: self.adjustLabel)
        self.adjustHiddenButton.right(to: self.adjustChevronImageView)
        self.adjustHiddenButton.bottom(to: self.adjustLabel, offset: -6)

        self.scrollViewContentView.addSubview(self.tagLabel)
        self.tagLabel.topToBottom(of: self.adjustLabel, offset: 15)
        self.tagLabel.left(to: self.adjustLabel)

        self.scrollViewContentView.addSubview(self.tagChevronImageView)
        self.tagChevronImageView.centerY(to: self.tagLabel)
        self.tagChevronImageView.right(to: self.adjustChevronImageView)

        self.scrollViewContentView.addSubview(self.tagHiddenButton)
        self.tagHiddenButton.top(to: self.tagLabel, offset: 6)
        self.tagHiddenButton.left(to: self.tagLabel)
        self.tagHiddenButton.right(to: self.tagChevronImageView)
        self.tagHiddenButton.bottom(to: self.tagLabel, offset: -6)
        
        self.scrollViewContentView.addSubview(self.commentsLabel)
        self.commentsLabel.topToBottom(of: self.tagLabel, offset: 15)
        self.commentsLabel.left(to: self.adjustLabel)

        self.scrollViewContentView.addSubview(self.commentSwitch)
        self.commentSwitch.centerY(to: self.commentsLabel)
        self.commentSwitch.right(to: self.adjustChevronImageView, offset: 6)
        
        self.scrollViewContentView.addSubview(self.addMusicLabel)
        self.addMusicLabel.topToBottom(of: self.commentsLabel, offset: 15)
        self.addMusicLabel.left(to: self.adjustLabel)

        self.scrollViewContentView.addSubview(self.addMusicChevronImageView)
        self.addMusicChevronImageView.centerY(to: self.addMusicLabel)
        self.addMusicChevronImageView.right(to: self.adjustChevronImageView)

        self.scrollViewContentView.addSubview(self.addMusicHiddenButton)
        self.addMusicHiddenButton.top(to: self.addMusicLabel, offset: 6)
        self.addMusicHiddenButton.left(to: self.addMusicLabel)
        self.addMusicHiddenButton.right(to: self.addMusicChevronImageView)
        self.addMusicHiddenButton.bottom(to: self.addMusicLabel, offset: -6)
        
        self.scrollViewContentView.addSubview(self.advancedLabel)
        self.advancedLabel.topToBottom(of: self.addMusicLabel, offset: 15)
        self.advancedLabel.left(to: self.adjustLabel)

        self.scrollViewContentView.addSubview(self.advancedChevronImageView)
        self.advancedChevronImageView.centerY(to: self.advancedLabel)
        self.advancedChevronImageView.right(to: self.adjustChevronImageView)

        self.scrollViewContentView.addSubview(self.advancedHiddenButton)
        self.advancedHiddenButton.top(to: self.advancedLabel, offset: 6)
        self.advancedHiddenButton.left(to: self.advancedLabel)
        self.advancedHiddenButton.right(to: self.advancedChevronImageView)
        self.advancedHiddenButton.bottom(to: self.advancedLabel, offset: -6)
        
        self.scrollViewContentView.bottom(to: self.advancedHiddenButton, offset: 20)
    }
}
//MARK: - Helpers
extension VideoFileSaveController {
    private func createHiddenButton(with selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
}
//MARK: - @objc
extension VideoFileSaveController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        self.captionTextView.resignFirstResponder()
    }
    
    @objc func didTapEdit() {
        print(#function)
    }
    
    @objc func didTapAdjust() {
        print(#function)
    }
    
    @objc func didTapTag() {
        print(#function)
    }
    
    @objc func didChangeUISwitch() {
        if self.commentSwitch.isOn {
            //User opted to enable comments
            print("SWITCH TURNED ON")
        } else {
            //User opted to not enable comments
            print("SWITCH TURNED OFF")
        }
    }
    
    @objc func didTapAddMusic() {
        print(#function)
    }
    
    @objc func didTapAdvanced() {
        print(#function)
    }
    
    @objc func didTapShareNow() {
        print(#function)
    }
}
//MARK: - UITextField Delegate
extension VideoFileSaveController: UITextViewDelegate {
    //Limit to 100 characters
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 100
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        DispatchQueue.main.async {
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.endOfDocument)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let currentText = textView.text ?? ""
        print("Input = ", currentText)
    }
}
