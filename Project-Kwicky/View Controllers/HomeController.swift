//
//  HomeController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/19/23.
//

import UIKit

final class HomeController: UIViewController {
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
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.barStyle = .default
        searchBar.placeholder = "Search"
        searchBar.isTranslucent = true
        searchBar.backgroundColor = .clear
        searchBar.barTintColor = .kwiksGrey
        searchBar.backgroundImage = UIImage()
        searchBar.height(50)
        searchBar.layer.cornerRadius = 25
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.layoutUI()
    }
}
//MARK: - Layout UI
extension HomeController {
    private func layoutUI() {
        self.view.addSubview(self.userProfileImageView)
        self.userProfileImageView.topToSuperview(offset: 20, usingSafeArea: true)
        self.userProfileImageView.rightToSuperview(offset: -20)
        
        self.view.addSubview(self.searchBar)
        self.searchBar.topToSuperview(offset: 20, usingSafeArea: true)
        self.searchBar.leftToSuperview(offset: 20)
        self.searchBar.rightToLeft(of: self.userProfileImageView, offset: -10)
        
        self.view.addSubview(self.profileButton)
        self.profileButton.top(to: self.userProfileImageView)
        self.profileButton.left(to: self.userProfileImageView)
        self.profileButton.right(to: self.userProfileImageView)
        self.profileButton.bottom(to: self.userProfileImageView)
    }
}
//MARK: - @objc
extension HomeController {
    @objc func didTapProfile() {
        print(#function)
        
        let profileVC = ProfileController()
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
}
