//
//  UploadImageController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/26/23.
//

import UIKit

final class UploadImageController: UIViewController {
    var presentingController: ProfileController?
    
    private let backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        return view
    }()
    
    private lazy var hiddenButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .clear
        button.tintColor = .clear
        button.addTarget(self, action: #selector(tapGesture), for: .touchUpInside)
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.roundCorners(corners: [.topLeft, .topRight], radius: 25)
        view.height(320)
        return view
    }()
    
    private lazy var takePictureImageView = self.createIcon(with: "TakePictureIcon")
    private lazy var takePictureLabel = self.createLabel(with: "Take Picture")
    private lazy var pictureChevronImageView = self.createChevron()
    private lazy var hiddenPictureButton = self.createHiddenButton(with: #selector(didTapPicture))
    
    private lazy var libraryImageView = self.createIcon(with: "LibraryIcon")
    private lazy var libraryLabel = self.createLabel(with: "Photo & Video Library")
    private lazy var libraryChevronImageView = self.createChevron()
    private lazy var hiddenLibraryButton = self.createHiddenButton(with: #selector(didTapPhoto))
    
    private lazy var avatarImageView = self.createIcon(with: "AvatarIcon")
    private lazy var avatarLabel = self.createLabel(with: "Choose Avatar")
    private lazy var avatarChevronImageView = self.createChevron()
    private lazy var hiddenAvatarButton = self.createHiddenButton(with: #selector(didTapAvatar))
    
    private lazy var removeImageView = self.createIcon(with: "RemovePhotoIcon")
    private lazy var removeLabel = self.createLabel(with: "Remove Photo")
    private lazy var removeChevronImageView = self.createChevron()
    private lazy var hiddenRemoveButton = self.createHiddenButton(with: #selector(didTapRemove))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Configure View Controller
extension UploadImageController {
    private func configure() {
        self.view.backgroundColor = .clear
    }
}
//MARK: - Layout UI
extension UploadImageController {
    func layoutUI() {
        let offset: CGFloat = 10
        
        self.view.addSubview(self.backgroundView)
        self.backgroundView.edgesToSuperview()
        
        self.backgroundView.addSubview(self.containerView)
        self.containerView.bottomToSuperview()
        self.containerView.leftToSuperview()
        self.containerView.rightToSuperview()
        
        self.backgroundView.addSubview(self.hiddenButton)
        self.hiddenButton.topToSuperview()
        self.hiddenButton.rightToSuperview()
        self.hiddenButton.leftToSuperview()
        self.hiddenButton.bottomToTop(of: self.containerView)
        
        self.containerView.addSubview(self.takePictureImageView)
        self.takePictureImageView.leftToSuperview(offset: 48)
        self.takePictureImageView.topToSuperview(offset: 30)
        
        self.containerView.addSubview(self.takePictureLabel)
        self.takePictureLabel.leftToRight(of: self.takePictureImageView, offset: 22)
        self.takePictureLabel.centerY(to: self.takePictureImageView)
        
        self.containerView.addSubview(self.pictureChevronImageView)
        self.pictureChevronImageView.rightToSuperview(offset: -48)
        self.pictureChevronImageView.centerY(to: self.takePictureImageView)
        
        self.containerView.addSubview(self.hiddenPictureButton)
        self.hiddenPictureButton.left(to: self.takePictureImageView, offset: -offset)
        self.hiddenPictureButton.right(to: self.pictureChevronImageView, offset: offset)
        self.hiddenPictureButton.top(to: self.takePictureImageView, offset: -offset)
        self.hiddenPictureButton.bottom(to: self.takePictureImageView, offset: offset)
        
        self.containerView.addSubview(self.libraryImageView)
        self.libraryImageView.topToBottom(of: self.takePictureImageView, offset: 48)
        self.libraryImageView.left(to: self.takePictureImageView)
        
        self.containerView.addSubview(self.libraryLabel)
        self.libraryLabel.left(to: self.takePictureLabel)
        self.libraryLabel.centerY(to: self.libraryImageView)
        
        self.containerView.addSubview(self.libraryChevronImageView)
        self.libraryChevronImageView.right(to: self.pictureChevronImageView)
        self.libraryChevronImageView.centerY(to: self.libraryImageView)
        
        self.containerView.addSubview(self.hiddenLibraryButton)
        self.hiddenLibraryButton.left(to: self.libraryImageView, offset: -offset)
        self.hiddenLibraryButton.right(to: self.libraryChevronImageView, offset: offset)
        self.hiddenLibraryButton.top(to: self.libraryImageView, offset: -offset)
        self.hiddenLibraryButton.bottom(to: self.libraryImageView, offset: offset)
        
        self.containerView.addSubview(self.avatarImageView)
        self.avatarImageView.topToBottom(of: self.libraryImageView, offset: 48)
        self.avatarImageView.left(to: self.takePictureImageView)
        
        self.containerView.addSubview(self.avatarLabel)
        self.avatarLabel.left(to: self.takePictureLabel)
        self.avatarLabel.centerY(to: self.avatarImageView)
        
        self.containerView.addSubview(self.avatarChevronImageView)
        self.avatarChevronImageView.right(to: self.pictureChevronImageView)
        self.avatarChevronImageView.centerY(to: self.avatarImageView)
        
        self.containerView.addSubview(self.hiddenAvatarButton)
        self.hiddenAvatarButton.left(to: self.avatarImageView, offset: -offset)
        self.hiddenAvatarButton.right(to: self.avatarChevronImageView, offset: offset)
        self.hiddenAvatarButton.top(to: self.avatarImageView, offset: -offset)
        self.hiddenAvatarButton.bottom(to: self.avatarImageView, offset: offset)
        
        self.containerView.addSubview(self.removeImageView)
        self.removeImageView.topToBottom(of: self.avatarImageView, offset: 48)
        self.removeImageView.left(to: self.takePictureImageView)
        
        self.containerView.addSubview(self.removeLabel)
        self.removeLabel.left(to: self.takePictureLabel)
        self.removeLabel.centerY(to: self.removeImageView)
        
        self.containerView.addSubview(self.removeChevronImageView)
        self.removeChevronImageView.right(to: self.pictureChevronImageView)
        self.removeChevronImageView.centerY(to: self.removeImageView)
        
        self.containerView.addSubview(self.hiddenRemoveButton)
        self.hiddenRemoveButton.left(to: self.removeImageView, offset: -offset)
        self.hiddenRemoveButton.right(to: self.removeChevronImageView, offset: offset)
        self.hiddenRemoveButton.top(to: self.removeImageView, offset: -offset)
        self.hiddenRemoveButton.bottom(to: self.removeImageView, offset: offset)
    }
}
//MARK: - Helpers
extension UploadImageController {
    private func createIcon(with name: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(25)
        imageView.width(25)
        
        let image = UIImage(named: name)
        imageView.image = image
        return imageView
    }
    
    private func createLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksBlack
        return label
    }
    
    private func createChevron() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(16)
        imageView.width(16)
        
        let image = UIImage(named: "GreyNextIcon")
        imageView.image = image
        return imageView
    }
    
    private func createHiddenButton(with selector: Selector) -> UIButton {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .clear
        button.tintColor = .clear
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
}
//MARK: - @objc
extension UploadImageController {
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    @objc func didTapPicture() {
        print(#function)
    }
    
    @objc func didTapPhoto() {
        print(#function)
    }
    
    @objc func didTapAvatar() {
        print(#function)
    }
    
    @objc func didTapRemove() {
        print(#function)
    }
}
