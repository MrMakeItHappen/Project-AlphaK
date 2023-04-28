//
//  KwikSaleSelectProductController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/21/23.
//

import UIKit

final class KwikSaleSelectProductController: UIViewController {
    var selectedCategory: String!
    
    private var allProducts: [KwiksSaleItem] = KwiksSaleItem.allTempItems
    private var filteredProducts: [KwiksSaleItem] = []
    private var searchCategories: String?
    private var featuredItems: [KwiksSaleItem] = KwiksSaleItem.tempFeaturedItems
    
    private lazy var customBackButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.kwiksTextBlack
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        button.height(23)
        button.width(33)
        button.setImage(UIImage(named: "KwiksBackArrow"), for: .normal)
        return button
    }()
    
    private let kwikLabel: UILabel = {
        let label = UILabel()
        label.text = "Kwik"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 20)
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
        label.font = UIFont.segoeUIBold(size: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksGreen
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .segoeUISemiBold(size: 15)
        
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .capsule
        configuration.attributedTitle = AttributedString("Next", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapNext()
        }))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.backgroundColor = .kwiksGreen
        button.tintColor = .white
        button.height(50)
        return button
    }()
    
    private let chooseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 36)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.85
        label.attributedText = NSMutableAttributedString(string: "Choose your product", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        return label
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.barStyle = .default
        searchBar.isTranslucent = true
        searchBar.delegate = self
        searchBar.backgroundColor = UIColor.clear
        searchBar.barTintColor = .black
        searchBar.backgroundImage = UIImage()
        searchBar.height(50)
        searchBar.searchTextField.font = .segoeUIRegular(size: 15)
        searchBar.searchTextField.backgroundColor = UIColor(hexString: "#E4E4E4")
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [.foregroundColor : UIColor.black])
        searchBar.returnKeyType = .done
        return searchBar
    }()
    
    private lazy var productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 116, height: 136)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 3
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.register(ProductHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProductHeaderCollectionReusableView.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Configure Controller
extension KwikSaleSelectProductController {
    private func configure() {
        self.view.backgroundColor = .white
        self.filteredProducts = self.allProducts
    }
}

//MARK: - Layout UI
extension KwikSaleSelectProductController {
    private func layoutUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.kwikLabel)
        self.kwikLabel.centerY(to: self.customBackButton, offset: -2)
        self.kwikLabel.leftToRight(of: self.customBackButton, offset: 18)
        
        self.view.addSubview(self.saleLabel)
        self.saleLabel.leftToRight(of: self.kwikLabel)
        self.saleLabel.centerY(to: self.kwikLabel)
        
        self.view.addSubview(self.nextButton)
        self.nextButton.bottomToSuperview(offset: -10, usingSafeArea: true)
        self.nextButton.leftToSuperview(offset: 30)
        self.nextButton.rightToSuperview(offset: -30)
        
        self.view.addSubview(self.chooseLabel)
        self.chooseLabel.topToBottom(of: self.kwikLabel, offset: 21)
        self.chooseLabel.leftToSuperview(offset: 30)
        self.chooseLabel.rightToSuperview(offset: -30)
        
        self.view.addSubview(self.searchBar)
        self.searchBar.topToBottom(of: self.chooseLabel, offset: 20)
        self.searchBar.left(to: self.chooseLabel)
        self.searchBar.right(to: self.chooseLabel)
        
        self.view.addSubview(self.productCollectionView)
        self.productCollectionView.topToBottom(of: self.searchBar, offset: 10)
        self.productCollectionView.leftToSuperview(offset: 15)
        self.productCollectionView.rightToSuperview(offset: -15)
        self.productCollectionView.bottomToTop(of: self.nextButton, offset: -10)
    }
}

//MARK: - Helpers
extension KwikSaleSelectProductController {
    func presentReview(for item: KwiksSaleItem) {
        let reviewProductVC = KwiksSaleReviewSelectedProductViewController()
        reviewProductVC.selectedItem = item
        self.navigationController?.pushViewController(reviewProductVC, animated: true)
    }
}

//MARK: - @objc
extension KwikSaleSelectProductController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapNext() {
        print(#function)
    }
}

//MARK: - CollectionView DataSource & Delegate
extension KwikSaleSelectProductController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        let item = self.filteredProducts[indexPath.item]
        cell.configure(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProductHeaderCollectionReusableView.identifier, for: indexPath) as! ProductHeaderCollectionReusableView
            view.featuredItems = self.featuredItems
            view.homeController = self
            return view
        }
        
        return UICollectionReusableView()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        let width = self.productCollectionView.frame.size.width
//        return CGSize(width: width, height: 195)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let reviewProductVC = KwiksSaleReviewSelectedProductViewController()
        let selectedItem = self.filteredProducts[indexPath.item]
        
        reviewProductVC.selectedItem = selectedItem
        self.navigationController?.pushViewController(reviewProductVC, animated: true)
    }
}

//MARK: - UISearchBar Delegate
extension KwikSaleSelectProductController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            self.filteredProducts = (allProducts.filter { item in
                
                self.searchCategories = item.productName?.lowercased()
                return searchCategories!.contains(searchText.lowercased())
            })
            
            self.productCollectionView.reloadData()
            
        } else {
            self.filteredProducts = self.allProducts
            self.productCollectionView.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}
