//
//  StickerCollectionViewCell.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/13/23.
//

import UIKit

final class StickerCollectionViewCell: UICollectionViewCell {
    static let identifier = "StickerCollectionViewCell"
    
    let stickerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        self.addSubview(self.stickerImageView)
        self.stickerImageView.edgesToSuperview()
    }
    
    func configure(with sticker: Sticker) {
        self.stickerImageView.image = sticker.image
    }
}
