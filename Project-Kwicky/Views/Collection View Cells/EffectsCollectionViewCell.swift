//
//  EffectsCollectionViewCell.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/11/23.
//

import UIKit

final class EffectsCollectionViewCell: UICollectionViewCell {
    static let identifier = "EffectsCollectionViewCell"
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.height(22)
        imageView.width(22)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hexString: "#1A1A1A")
        self.layer.cornerRadius = 17
        self.layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with effect: Effect) {
        self.iconImageView.image = effect.image
    }
    
    private func layoutUI() {
        self.addSubview(self.iconImageView)
        self.iconImageView.centerInSuperview()
    }
}
