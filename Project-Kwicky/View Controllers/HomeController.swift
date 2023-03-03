//
//  HomeController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/19/23.
//

import UIKit

final class HomeController: UIViewController {
    private let exampleVideos: [KwiksVideo] = KwiksVideo.allExampleVideos
    
    private let tabBarExtension: UIView = {
        let view = UIView(frame: .zero)
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor(red: 0.090, green: 0.090, blue: 0.090, alpha: 1)
        view.height(6)
        return view
    }()
    
    private let placeholderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        
        let image = UIImage(named: "PlaceholderVideoImage05")
        imageView.image = image
        return imageView
    }()
    
    private let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        let imageSize: CGFloat = 50
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.height(imageSize)
        imageView.width(imageSize)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize / 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1.5
        
        let image = UIImage(named: "FemalePlaceholder")
        imageView.image = image
        return imageView
    }()
    
    private lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        return button
    }()
    
    private let earnedAmountView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(hexString: "#0E0D0D")
        view.layer.cornerRadius = 0
        view.layer.cornerRadius = 12
        view.height(25)
        view.width(92)
        return view
    }()
    
    private let moneySignImageView: UIImageView = {
        let imageView = UIImageView()
        let imageSize: CGFloat = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.height(imageSize)
        imageView.width(imageSize)
        imageView.layer.masksToBounds = true
        
        let image = UIImage(named: "KwiksMoneySymbol")
        imageView.image = image
        return imageView
    }()
    
    private let earnedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "999999"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let chervonImageView: UIImageView = {
        let imageView = UIImageView()
        let imageSize: CGFloat = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.height(imageSize)
        imageView.width(imageSize)
        imageView.layer.masksToBounds = true
        
        let image = UIImage(named: "GreyNextIcon")?.withTintColor(.white)
        imageView.image = image
        return imageView
    }()
    
    private lazy var hiddenEarnedAmountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.clear
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(didTapEarnedAmount), for: .touchUpInside)
        return button
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.barStyle = .default
        searchBar.isTranslucent = true
        searchBar.backgroundColor = .clear
        searchBar.barTintColor = .white
        searchBar.backgroundImage = UIImage()
        searchBar.height(50)
        searchBar.searchTextField.backgroundColor = UIColor.kwiksGrey.withAlphaComponent(0.5)
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [.foregroundColor : UIColor.white])
        return searchBar
    }()
    
    private lazy var forYouCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 165, height: 231)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ForYouCollectionViewCell.self, forCellWithReuseIdentifier: ForYouCollectionViewCell.identifier)
        collectionView.height(272)
        
        return collectionView
    }()
    
    private let seperatorLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .black
        view.height(1.5)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.layoutTopSectionUI()
        self.layoutBottomSectionUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.modifySearchbarIcon()
    }
}
//MARK: - Layout UI
extension HomeController {
    private func layoutTopSectionUI() {
        self.view.addSubview(self.placeholderImageView)
        self.placeholderImageView.edgesToSuperview(usingSafeArea: false)
        
        self.view.addSubview(self.tabBarExtension)
        self.tabBarExtension.bottomToSuperview(usingSafeArea: true)
        self.tabBarExtension.leftToSuperview()
        self.tabBarExtension.rightToSuperview()
        
        self.view.addSubview(self.userProfileImageView)
        self.userProfileImageView.topToSuperview(offset: 20, usingSafeArea: true)
        self.userProfileImageView.rightToSuperview(offset: -20)
        
        self.view.addSubview(self.searchBar)
        self.searchBar.topToSuperview(offset: 20, usingSafeArea: true)
        self.searchBar.leftToSuperview(offset: 20)
        self.searchBar.rightToLeft(of: self.userProfileImageView, offset: -10)
        
        self.view.addSubview(self.earnedAmountView)
        self.earnedAmountView.topToBottom(of: self.searchBar, offset: 12)
        self.earnedAmountView.leftToSuperview(offset: 28)
        
        self.earnedAmountView.addSubview(self.moneySignImageView)
        self.moneySignImageView.leftToSuperview(offset: 9)
        self.moneySignImageView.centerYToSuperview()
        
        self.earnedAmountView.addSubview(self.chervonImageView)
        self.chervonImageView.rightToSuperview(offset: -7)
        self.chervonImageView.centerYToSuperview()
        
        self.earnedAmountView.addSubview(self.earnedAmountLabel)
        self.earnedAmountLabel.leftToRight(of: self.moneySignImageView, offset: 2)
        self.earnedAmountLabel.rightToLeft(of: self.chervonImageView, offset: -2)
        self.earnedAmountLabel.centerYToSuperview(offset: -1)
        
        self.view.addSubview(self.hiddenEarnedAmountButton)
        self.hiddenEarnedAmountButton.top(to: self.earnedAmountView, offset: -2)
        self.hiddenEarnedAmountButton.right(to: self.earnedAmountView, offset: 2)
        self.hiddenEarnedAmountButton.left(to: self.earnedAmountView, offset: -2)
        self.hiddenEarnedAmountButton.bottom(to: self.earnedAmountView, offset: 2)
        
        self.view.addSubview(self.profileButton)
        self.profileButton.top(to: self.userProfileImageView)
        self.profileButton.left(to: self.userProfileImageView)
        self.profileButton.right(to: self.userProfileImageView)
        self.profileButton.bottom(to: self.userProfileImageView)
    }
    
    private func layoutBottomSectionUI() {
        self.view.addSubview(self.forYouCollectionView)
        self.forYouCollectionView.bottomToSuperview(usingSafeArea: true)
        self.forYouCollectionView.leftToSuperview(offset: 20)
        self.forYouCollectionView.rightToSuperview()
        
        self.view.addSubview(self.seperatorLineView)
        self.seperatorLineView.leftToSuperview(offset: 26)
        self.seperatorLineView.rightToSuperview(offset: -24)
        self.seperatorLineView.bottomToTop(of: self.forYouCollectionView)
    }
}
//MARK: - Helpers
extension HomeController {
    private func modifySearchbarIcon() {
        if let searchIconImageView = self.searchBar.searchTextField.leftView as? UIImageView {
            searchIconImageView.image = searchIconImageView.image?.withRenderingMode(.alwaysTemplate)
            searchIconImageView.tintColor = UIColor.white
        }
    }
}
//MARK: - @objc
extension HomeController {
    @objc func didTapProfile() {
        print(#function)
        
        let profileVC = ProfileController()
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @objc func didTapEarnedAmount() {
        print(#function)
    }
}
//MARK: - CollectionView DataSource & Delegate
extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.exampleVideos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForYouCollectionViewCell.identifier, for: indexPath) as! ForYouCollectionViewCell
        let video = self.exampleVideos[indexPath.item]
        cell.configure(with: video)
        return cell
    }
    
    
}
