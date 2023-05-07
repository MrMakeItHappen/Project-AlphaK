//
//  ProductHeaderCollectionReusableView.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/21/23.
//

import UIKit

final class ProductHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProductHeaderCollectionReusableView"
    
    var featuredItems: [KwiksSaleItem] = []
    weak var homeController: KwikSaleSelectProductController?
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 20
        view.height(185)
        return view
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        
        let image = UIImage(named: "FeaturedItemsContainer")
        imageView.image = image
        return imageView
    }()
    
    private let featureLabel: UILabel = {
        let label = UILabel()
        label.text = "Featured Items"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .segoeUISemiBold(size: 16)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private lazy var productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 110, height: 130)
        layout.minimumInteritemSpacing = 2
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.register(ProductHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProductHeaderCollectionReusableView.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layoutUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        self.addSubview(self.containerView)
        self.containerView.leftToSuperview()
        self.containerView.rightToSuperview()
        
        self.containerView.addSubview(self.backgroundImageView)
        self.backgroundImageView.edgesToSuperview()
        
        self.containerView.addSubview(self.featureLabel)
        self.featureLabel.topToSuperview(offset: 10)
        self.featureLabel.leftToSuperview(offset: 17)
        
        self.containerView.addSubview(self.productCollectionView)
        self.productCollectionView.topToBottom(of: self.featureLabel, offset: 10)
        self.productCollectionView.bottomToSuperview(offset: 12)
        self.productCollectionView.leftToSuperview(offset: 6)
        self.productCollectionView.rightToSuperview(offset: -6)
    }
}
//MARK: UICollectionView DataSource & Delegate
extension ProductHeaderCollectionReusableView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        let featuredItem = self.featuredItems[indexPath.item]
        cell.configure(with: featuredItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let featuredItem = self.featuredItems[indexPath.item]
        self.homeController?.presentReview(for: featuredItem)
    }
}
