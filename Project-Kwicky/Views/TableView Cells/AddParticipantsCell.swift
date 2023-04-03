//
//  AddParticipantsCell.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/2/23.
//

import UIKit

final class AddParticipantsCell: UITableViewCell {
    static let identifier = "AddParticipantsCell"
    var buttonCallback: () -> () = {}
    private var isChecked = false
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        let size: CGFloat = 50
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = size / 2
        imageView.height(size)
        imageView.width(size)
        return imageView
    }()
    
    private let participantNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 16)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    let participantSelectedButton: UIButton = {
        let button = UIButton(type: .custom)
        let size: CGFloat = 25
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.white
        button.height(size)
        button.width(size)
        button.layer.cornerRadius = size / 2
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.borderGrey.cgColor
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
        self.layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.selectionStyle = .none
        self.clipsToBounds = true
        self.backgroundColor = .clear
        
        self.participantSelectedButton.addTarget(self, action: #selector(didTapParticipant), for: .touchUpInside)
    }
    
    private func layoutUI() {
        self.addSubview(self.profileImageView)
        self.profileImageView.leftToSuperview()
        self.profileImageView.centerYToSuperview()
        
        self.addSubview(self.participantSelectedButton)
        self.participantSelectedButton.rightToSuperview()
        self.participantSelectedButton.centerYToSuperview()
        
        self.addSubview(self.participantNameLabel)
        self.participantNameLabel.centerYToSuperview(offset: -2)
        self.participantNameLabel.leftToRight(of: self.profileImageView, offset: 12)
        self.participantNameLabel.rightToLeft(of: self.participantSelectedButton, offset: -12)
    }
    
    func configure(with user: TempUser) {
        self.profileImageView.image = user.profileImage
        self.participantNameLabel.text = user.name
    }
    
    func toggle() {
        self.isChecked = !self.isChecked
        
        if isChecked {
            self.participantSelectedButton.backgroundColor = .kwiksGreen
            self.participantSelectedButton.layer.borderColor = UIColor.kwiksGreen.cgColor
            self.participantSelectedButton.setImage(UIImage(named: "Checkmark"), for: .normal)
            
        } else {
            self.participantSelectedButton.backgroundColor = .white
            self.participantSelectedButton.layer.borderColor = UIColor.borderGrey.cgColor
            self.participantSelectedButton.setImage(nil, for: .normal)
        }
    }
    
    @objc private func didTapParticipant() {
        buttonCallback()
    }
}
