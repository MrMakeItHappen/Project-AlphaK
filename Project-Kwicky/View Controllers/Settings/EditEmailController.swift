//
//  EditEmailController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 5/1/23.
//

import UIKit

final class EditEmailController: UIViewController {
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
        label.text = "Email"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Configure Controller
extension EditEmailController {
    private func configure() {
        self.view.backgroundColor = .white
    }
}

//MARK: - Layout UI
extension EditEmailController {
    private func layoutUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerY(to: self.customBackButton)
        self.titleLabel.centerXToSuperview()
    }
}

//MARK: - Helpers
extension EditEmailController {
    
}

//MARK: - @objc
extension EditEmailController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
