//
//  KwiksSaleSelectCategoryController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/19/23.
//

import UIKit

final class KwiksSaleSelectCategoryController: UIViewController {
    private let tempCategories: [String] = ["Electronics", "Health & Beauty", "Home Appliances", "Home Decor", "Audio", "Kitchen Items", "Toys", "Sports", "Gadgets", "Girls Fashion", "Boys Fashion", "Watches", "Bags", "Jewelery", "Motorbike", "Gaming", "Phone", "Tablet", "Camera", "Air Condition", "Fans", "Lifestyles"]
    private var filteredCategories: [String] = []
    private var searchCategories: String?
    private var selectedCategory: String = ""
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.tintColor = .kwiksTextBlack
        button.setImage(UIImage(named: "CloseIcon"), for: .normal)
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        button.width(16)
        button.height(16)
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
        button.tintColor = .kwiksTextBlack
        button.height(50)
        return button
    }()
    
    private let addLabel: UILabel = {
        let label = UILabel()
        label.text = "Add a product to your video"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 25)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksGrey
        return label
    }()
    
    private let chooseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 34)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.85
        label.attributedText = NSMutableAttributedString(string: "Choose your \ncategories", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
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
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Configure
extension KwiksSaleSelectCategoryController {
    private func configure() {
        self.view.backgroundColor = .white
        self.filteredCategories = self.tempCategories
    }
}

//MARK: - Layout UI
extension KwiksSaleSelectCategoryController {
    private func layoutUI() {
        self.view.addSubview(self.kwikLabel)
        self.kwikLabel.topToSuperview(offset: 22, usingSafeArea: true)
        self.kwikLabel.leftToSuperview(offset: 30)
        
        self.view.addSubview(self.saleLabel)
        self.saleLabel.leftToRight(of: self.kwikLabel)
        self.saleLabel.centerY(to: self.kwikLabel)
        
        self.view.addSubview(self.closeButton)
        self.closeButton.centerY(to: self.kwikLabel)
        self.closeButton.rightToSuperview(offset: -30)
        
        self.view.addSubview(self.nextButton)
        self.nextButton.bottomToSuperview(offset: -10, usingSafeArea: true)
        self.nextButton.leftToSuperview(offset: 30)
        self.nextButton.rightToSuperview(offset: -30)
        
        self.view.addSubview(self.addLabel)
        self.addLabel.topToBottom(of: self.kwikLabel, offset: 28)
        self.addLabel.leftToSuperview(offset: 30)
        self.addLabel.rightToSuperview(offset: -30)
        
        self.view.addSubview(self.chooseLabel)
        self.chooseLabel.topToBottom(of: self.addLabel, offset: 14)
        self.chooseLabel.left(to: self.addLabel)
        self.chooseLabel.right(to: self.addLabel)
        
        self.view.addSubview(self.searchBar)
        self.searchBar.topToBottom(of: self.chooseLabel, offset: 24)
        self.searchBar.left(to: self.addLabel)
        self.searchBar.right(to: self.addLabel)
        
        self.view.addSubview(self.categoryCollectionView)
        self.categoryCollectionView.topToBottom(of: self.searchBar, offset: 10)
        self.categoryCollectionView.left(to: self.addLabel)
        self.categoryCollectionView.right(to: self.addLabel)
        self.categoryCollectionView.bottomToTop(of: self.nextButton, offset: -30)
    }
}

//MARK: - @objc
extension KwiksSaleSelectCategoryController {
    @objc func didTapClose() {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapNext() {
        let selectProductVC = KwikSaleSelectProductController()
        selectProductVC.selectedCategory = self.selectedCategory
        self.navigationController?.pushViewController(selectProductVC, animated: true)
    }
}

//MARK: - CollectionView DataSource & Delegate
extension KwiksSaleSelectCategoryController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        let category = self.filteredCategories[indexPath.item]
        cell.configure(with: category)
        return cell
    }
    
    //TODO: Bug fix. If cell is selected then search is selected, cell remains selected. Need to clear cell background instead.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
            let category = self.filteredCategories[indexPath.item]
            self.selectedCategory = category
            cell.layer.borderColor = UIColor.kwiksGreen.cgColor
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
            cell.layer.borderColor = UIColor.clear.cgColor
        }
    }
}

//MARK: - UISearchBar Delegate
extension KwiksSaleSelectCategoryController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            self.filteredCategories = (tempCategories.filter { category in
                
                self.searchCategories = category.lowercased()
                return searchCategories!.contains(searchText.lowercased())
            })
            
            self.categoryCollectionView.reloadData()
            
        } else {
            self.filteredCategories = self.tempCategories
            self.categoryCollectionView.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}
