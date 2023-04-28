//
//  QuestionTableViewCell.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/28/23.
//

import UIKit

final class QuestionTableViewCell: UITableViewCell {
    static let identifier = "QuestionTableViewCell"
    
    private let containerView = UIView.createSettingsContainer()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .segoeUISemiBold(size: 18)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private let answerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .segoeUIRegular(size: 18)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        self.layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        self.addSubview(self.containerView)
        self.containerView.topToSuperview()
        self.containerView.rightToSuperview()
        self.containerView.leftToSuperview()
        self.containerView.bottomToSuperview(offset: -20)
        
        self.containerView.addSubview(self.questionLabel)
        self.questionLabel.topToSuperview(offset: 20)
        self.questionLabel.leftToSuperview(offset: 40)
        self.questionLabel.rightToSuperview(offset: -40)
        
        self.containerView.addSubview(self.answerLabel)
        self.answerLabel.topToBottom(of: self.questionLabel, offset: 10)
        self.answerLabel.leftToSuperview(offset: 40)
        self.answerLabel.rightToSuperview(offset: -40)
        self.answerLabel.bottomToSuperview(offset: -20)
    }
    
    func configure(with item: FAQ) {
        self.questionLabel.text = item.question
        self.answerLabel.text = item.answer
    }
}
