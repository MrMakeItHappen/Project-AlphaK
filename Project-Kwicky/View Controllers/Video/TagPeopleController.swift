//
//  TagPeopleController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/17/23.
//

import UIKit

final class TagPeopleController: UIViewController {
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tag People"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
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
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.modifySearchbarIcon()
    }
}
//MARK: - Configure Controller
extension TagPeopleController {
    private func configure() {
        self.view.backgroundColor = .white
    }
}

//MARK: - Layout UI
extension TagPeopleController {
    private func layoutUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerY(to: self.customBackButton, offset: -2)
        self.titleLabel.leftToRight(of: self.customBackButton, offset: 18)
        
        self.view.addSubview(self.searchBar)
        self.searchBar.topToBottom(of: self.titleLabel, offset: 20)
        self.searchBar.leftToSuperview(offset: 30)
        self.searchBar.rightToSuperview(offset: -30)
    }
}

//MARK: - Helpers
extension TagPeopleController {
    private func modifySearchbarIcon() {
        if let searchIconImageView = self.searchBar.searchTextField.leftView as? UIImageView {
            searchIconImageView.image = searchIconImageView.image?.withRenderingMode(.alwaysTemplate)
            searchIconImageView.tintColor = UIColor.black
        }
    }
}

//MARK: - @objc
extension TagPeopleController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - TableView DataSource & Delegate
extension TagPeopleController {
    
}

//MARK: - UISearchBar Delegate
extension TagPeopleController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
//        if searchText != "" {
//            self.filteredSongs = (_allAvailableVideoMusic.filter { song in
//
//                let songTitle = song.songTitle ?? ""
//                let artistName = song.artistName ?? ""
//
//                self.searchCategories = songTitle + " " + artistName
//                return searchCategories!.contains(searchText)
//            })
//
//            self.availableMusicTableView.reloadData()
//
//        } else {
//            self.filteredSongs = _allAvailableVideoMusic
//            self.availableMusicTableView.reloadData()
//        }
    }
}
