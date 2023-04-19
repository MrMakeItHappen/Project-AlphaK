//
//  VideoFileSaveController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/16/23.
//

import UIKit

final class VideoShareController: UIViewController {
    
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
        label.text = "Your New Video"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
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
    
    private let shareNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.kwiksGreen
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
        textView.textColor = .kwiksGrey
        textView.textAlignment = .center
        textView.delegate = self
        return textView
    }()
    
    private let editPrivacyLabel: UILabel = {
        let label = UILabel()
        label.text = "Edit Privacy"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let editPrivacyChevronImageView = UIImageView.createChevron()
    private lazy var editPrivacyHiddenButton = self.createHiddenButton(with: #selector(didTapEditPrivacy))
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.text = "Tag People"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
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
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let commentSwitch: UISwitch = {
        let uiswitch = UISwitch(frame: .zero)
        uiswitch.isOn = true
        uiswitch.onTintColor = .kwiksGreen
        uiswitch.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        return uiswitch
    }()
    
    private lazy var commentHiddenButton = self.createHiddenButton(with: #selector(didChangeUISwitch))
    
    private let addMusicLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Music"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let addMusicChevronImageView = UIImageView.createChevron()
    private lazy var addMusicHiddenButton = self.createHiddenButton(with: #selector(didTapAddMusic))
    
    private let kwikLabel: UILabel = {
        let label = UILabel()
        label.text = "Kwik"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 18)
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
        label.font = UIFont.segoeUIRegular(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksGreen
        return label
    }()
    
    private let saleChevronImageView = UIImageView.createChevron()
    private lazy var saleHiddenButton = self.createHiddenButton(with: #selector(didTapSale))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Configure View Controller
extension VideoShareController {
    private func configure() {
        self.view.backgroundColor = UIColor.white
        
        self.commentSwitch.addTarget(self, action: #selector(didChangeUISwitch), for: .valueChanged)
        self.shareNowButton.addTarget(self, action: #selector(didTapShareNow), for: .touchDown)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)
    }
}
//MARK: - Layout UI
extension VideoShareController {
    private func layoutUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerY(to: self.customBackButton, offset: -2)
        self.titleLabel.leftToRight(of: self.customBackButton, offset: 18)
        
        self.view.addSubview(self.coverImageView)
        self.coverImageView.topToBottom(of: self.titleLabel, offset: 48)
        self.coverImageView.centerXToSuperview()
        
        self.view.addSubview(self.shareNowButton)
        self.shareNowButton.bottomToSuperview(usingSafeArea: true)
        self.shareNowButton.leftToSuperview(offset: 30)
        self.shareNowButton.rightToSuperview(offset: -30)
        
        self.view.addSubview(self.kwikLabel)
        self.kwikLabel.leftToSuperview(offset: 30)
        self.kwikLabel.bottomToTop(of: self.shareNowButton, offset: -30)
        
        self.view.addSubview(self.saleLabel)
        self.saleLabel.leftToRight(of: self.kwikLabel)
        self.saleLabel.centerY(to: self.kwikLabel)

        self.view.addSubview(self.saleChevronImageView)
        self.saleChevronImageView.centerY(to: self.kwikLabel)
        self.saleChevronImageView.rightToSuperview(offset: -30)

        self.view.addSubview(self.saleHiddenButton)
        self.saleHiddenButton.top(to: self.kwikLabel, offset: 2)
        self.saleHiddenButton.left(to: self.kwikLabel)
        self.saleHiddenButton.right(to: self.saleChevronImageView)
        self.saleHiddenButton.bottom(to: self.kwikLabel, offset: -2)
        
        self.view.addSubview(self.editPrivacyLabel)
        self.editPrivacyLabel.bottomToTop(of: self.saleLabel, offset: -20)
        self.editPrivacyLabel.left(to: self.kwikLabel)

        self.view.addSubview(self.editPrivacyChevronImageView)
        self.editPrivacyChevronImageView.centerY(to: self.editPrivacyLabel)
        self.editPrivacyChevronImageView.right(to: self.saleChevronImageView)

        self.view.addSubview(self.editPrivacyHiddenButton)
        self.editPrivacyHiddenButton.top(to: self.editPrivacyLabel, offset: 2)
        self.editPrivacyHiddenButton.left(to: self.editPrivacyLabel)
        self.editPrivacyHiddenButton.right(to: self.editPrivacyChevronImageView)
        self.editPrivacyHiddenButton.bottom(to: self.editPrivacyLabel, offset: -2)
        
        self.view.addSubview(self.addMusicLabel)
        self.addMusicLabel.bottomToTop(of: self.editPrivacyLabel, offset: -20)
        self.addMusicLabel.left(to: self.kwikLabel)

        self.view.addSubview(self.addMusicChevronImageView)
        self.addMusicChevronImageView.centerY(to: self.addMusicLabel)
        self.addMusicChevronImageView.right(to: self.saleChevronImageView)

        self.view.addSubview(self.addMusicHiddenButton)
        self.addMusicHiddenButton.top(to: self.addMusicLabel, offset: 2)
        self.addMusicHiddenButton.left(to: self.addMusicLabel)
        self.addMusicHiddenButton.right(to: self.addMusicChevronImageView)
        self.addMusicHiddenButton.bottom(to: self.addMusicLabel, offset: -2)
        
        self.view.addSubview(self.commentsLabel)
        self.commentsLabel.bottomToTop(of: self.addMusicLabel, offset: -20)
        self.commentsLabel.left(to: self.kwikLabel)

        self.view.addSubview(self.commentSwitch)
        self.commentSwitch.centerY(to: self.commentsLabel)
        self.commentSwitch.right(to: self.saleChevronImageView, offset: 6)
        
        self.view.addSubview(self.commentHiddenButton)
        self.commentHiddenButton.top(to: self.commentsLabel, offset: 2)
        self.commentHiddenButton.left(to: self.commentsLabel)
        self.commentHiddenButton.right(to: self.commentsLabel)
        self.commentHiddenButton.bottom(to: self.commentsLabel, offset: -2)

        self.view.addSubview(self.tagLabel)
        self.tagLabel.bottomToTop(of: self.commentsLabel, offset: -20)
        self.tagLabel.left(to: self.kwikLabel)

        self.view.addSubview(self.tagChevronImageView)
        self.tagChevronImageView.centerY(to: self.tagLabel)
        self.tagChevronImageView.right(to: self.saleChevronImageView)

        self.view.addSubview(self.tagHiddenButton)
        self.tagHiddenButton.top(to: self.tagLabel, offset: 2)
        self.tagHiddenButton.left(to: self.tagLabel)
        self.tagHiddenButton.right(to: self.tagChevronImageView)
        self.tagHiddenButton.bottom(to: self.tagLabel, offset: -2)
        
        self.view.addSubview(self.captionTextView)
        self.captionTextView.topToBottom(of: self.coverImageView, offset: 30)
        self.captionTextView.leftToSuperview(offset: 20)
        self.captionTextView.rightToSuperview(offset: -20)
        self.captionTextView.bottomToTop(of: self.tagLabel, offset: -20)
    }
}
//MARK: - Helpers
extension VideoShareController {
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
extension VideoShareController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        self.captionTextView.resignFirstResponder()
    }
    
    @objc func didTapEditPrivacy() {
        print(#function)
    }
    
    @objc func didTapTag() {
        let tagPeopleVC = TagPeopleController()
        self.navigationController?.pushViewController(tagPeopleVC, animated: true)
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
        let addMusicVC = AddMusicToVideoController()
        self.navigationController?.pushViewController(addMusicVC, animated: true)
    }
    
    @objc func didTapSale() {
        print(#function)
    }
    
    @objc func didTapShareNow() {
        print(#function)
    }
}
//MARK: - UITextField Delegate
extension VideoShareController: UITextViewDelegate {
    //Limit to 100 characters
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 100
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        DispatchQueue.main.async {
            self.captionTextView.textColor = .kwiksTextBlack
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.endOfDocument)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let currentText = textView.text ?? ""
        print("Input = ", currentText)
    }
}
