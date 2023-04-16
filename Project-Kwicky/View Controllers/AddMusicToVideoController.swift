//
//  AddMusicToVideoViewController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/26/23.
//

import UIKit

final class AddMusicToVideoController: UIViewController {
    private var filteredSongs: [AvailableMusic] = []
    private var searchCategories: String?

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
        label.text = "Add Music"
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
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search Music", attributes: [.foregroundColor : UIColor.black])
        return searchBar
    }()
    
    private let musicLabel: UILabel = {
        let label = UILabel()
        label.text = "Featured Music"
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 16)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private lazy var availableMusicTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .interactive
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(AvailableMusicTableViewCell.self, forCellReuseIdentifier: AvailableMusicTableViewCell.identifier)
        tableView.height(300)
        return tableView
    }()
    
    private lazy var saveButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .segoeUISemiBold(size: 15)
        
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .capsule
        configuration.attributedTitle = AttributedString("Save", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapSave()
        }))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.backgroundColor = .kwiksGreen
        button.tintColor = .white
        button.height(50)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
        self.downloadAvailableMusic() //Should be on the Video Upload/Edit Screen
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.modifySearchbarIcon()
    }
}
//MARK: - Configure View Controller
extension AddMusicToVideoController {
    private func configure() {
        self.view.backgroundColor = UIColor.white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)
    }
}
//MARK: - Layout UI
extension AddMusicToVideoController {
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
        
        self.view.addSubview(self.musicLabel)
        self.musicLabel.topToBottom(of: self.searchBar, offset: 30)
        self.musicLabel.left(to: self.searchBar)
        
        self.view.addSubview(self.saveButton)
        self.saveButton.bottomToSuperview(offset: -10, usingSafeArea: true)
        self.saveButton.leftToSuperview(offset: 30)
        self.saveButton.rightToSuperview(offset: -30)
        
        self.view.addSubview(self.availableMusicTableView)
        self.availableMusicTableView.bottomToTop(of: self.saveButton, offset: -10)
        self.availableMusicTableView.left(to: self.saveButton)
        self.availableMusicTableView.right(to: self.saveButton)
        
        
    }
}
//MARK: - Helpers
extension AddMusicToVideoController {
    private func modifySearchbarIcon() {
        if let searchIconImageView = self.searchBar.searchTextField.leftView as? UIImageView {
            searchIconImageView.image = searchIconImageView.image?.withRenderingMode(.alwaysTemplate)
            searchIconImageView.tintColor = UIColor.black
        }
    }
    
    private func downloadAvailableMusic() {
        _allAvailableVideoMusic = AvailableMusic.allTempSongs
        self.filteredSongs = _allAvailableVideoMusic
        self.availableMusicTableView.reloadData()
    }
}
//MARK: - @objc
extension AddMusicToVideoController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapSave() {
        print(#function)
    }
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        self.searchBar.resignFirstResponder()
        self.view.endEditing(true)
    }
}
//MARK: - UITableView DataSource & Delegate
extension AddMusicToVideoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredSongs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AvailableMusicTableViewCell.identifier, for: indexPath) as! AvailableMusicTableViewCell
        let selectedSong = self.filteredSongs[indexPath.item]
        cell.configure(with: selectedSong)
        
        cell.bookmarkCallback = {
            print("Bookmark This Song - ", selectedSong.songTitle ?? "Error")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSong = self.filteredSongs[indexPath.item]
        let songTitle = selectedSong.songTitle
        print(songTitle ?? "Error")
    }
}
//MARK: - UISearchBar Delegate
extension AddMusicToVideoController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            self.filteredSongs = (_allAvailableVideoMusic.filter { song in
                
                let songTitle = song.songTitle ?? ""
                let artistName = song.artistName ?? ""
                
                self.searchCategories = songTitle + " " + artistName
                return searchCategories!.contains(searchText)
            })
            
            self.availableMusicTableView.reloadData()
            
        } else {
            self.filteredSongs = _allAvailableVideoMusic
            self.availableMusicTableView.reloadData()
        }
    }
}
