//
//  AddMusicToVideoViewController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/26/23.
//

import UIKit

final class AddMusicToVideoController: UIViewController {
    private var filteredSongs: [Music] = []
    private var savedSongs: [Music] = []
    private var featuredMusic: [Music] = Music.allTempFeatured
    private var songIDs: [String] = []
    private var searchCategories: String?
    private var isShowingSaved = false

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
    
    //TODO: Open in another controller
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
    
    private let videoVolumeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.height(50)
        imageView.width(50)
        
        let image = UIImage(named: "VideoVolumeIcon")
        imageView.image = image
        return imageView
    }()
    
    private let videoVolumeCenterLine: UIView = {
        let view = UIView(frame: .zero)
        view.isUserInteractionEnabled = false
        view.height(1)
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var videoVolumeSlider: UISlider = {
        let slider = UISlider()
        let configuration = UIImage.SymbolConfiguration(pointSize: 18)
        let image = UIImage(systemName: "circle.fill", withConfiguration: configuration)?.withTintColor(.kwiksGreen, renderingMode: .alwaysOriginal)
        slider.setThumbImage(image, for: .normal)
        slider.setThumbImage(image, for: .highlighted)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.backgroundColor = .clear
        slider.layer.masksToBounds = true
        slider.minimumTrackTintColor = UIColor.kwiksGreen
        slider.maximumTrackTintColor = UIColor.kwiksGrey
        slider.value = 75
        slider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
        slider.tag = 0
        return slider
    }()
    
    private let videoSliderLabel: UILabel = {
        let label = UILabel()
        label.text = "75%"
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 15)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .center
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let videoAudioLabel: UILabel = {
        let label = UILabel()
        label.text = "Video Audio"
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 10)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let musicVolumeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.height(50)
        imageView.width(50)
        
        let image = UIImage(named: "MusicVolumeIcon")
        imageView.image = image
        return imageView
    }()
    
    private let musicVolumeCenterLine: UIView = {
        let view = UIView(frame: .zero)
        view.isUserInteractionEnabled = false
        view.height(1)
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var musicVolumeSlider: UISlider = {
        let slider = UISlider()
        let configuration = UIImage.SymbolConfiguration(pointSize: 18)
        let image = UIImage(systemName: "circle.fill", withConfiguration: configuration)?.withTintColor(.kwiksGreen, renderingMode: .alwaysOriginal)
        slider.setThumbImage(image, for: .normal)
        slider.setThumbImage(image, for: .highlighted)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.backgroundColor = .clear
        slider.layer.masksToBounds = true
        slider.minimumTrackTintColor = UIColor.kwiksGreen
        slider.maximumTrackTintColor = UIColor.kwiksGrey
        slider.value = 25
        slider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
        slider.tag = 1
        return slider
    }()
    
    private let musicSliderLabel: UILabel = {
        let label = UILabel()
        label.text = "25%"
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIRegular(size: 15)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .center
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let musicAudioLabel: UILabel = {
        let label = UILabel()
        label.text = "Music Audio"
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 10)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = UIColor.kwiksTextBlack
        return label
    }()
    
    private let featuredLabel: UILabel = {
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
    
    private lazy var forYouButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .segoeUISemiBold(size: 16)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("For you", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapForYou()
        }))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = .clear
        button.titleLabel?.textAlignment = .left
        button.tintColor = .kwiksTextBlack
        button.sizeToFit()
        return button
    }()
    
    private lazy var savedButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .segoeUISemiBold(size: 16)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("Saved", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapSaved()
        }))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.titleLabel?.textAlignment = .left
        button.backgroundColor = .clear
        button.tintColor = .kwiksGrey
        button.height(50)
        return button
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
        tableView.height(240)
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
    
    private lazy var featuredMusicCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 166, height: 72)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(FeaturedMusicCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedMusicCollectionViewCell.identifier)
        collectionView.height(74)
        return collectionView
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
        
        self.view.addSubview(self.videoVolumeImageView)
        self.videoVolumeImageView.topToBottom(of: self.searchBar, offset: 20)
        self.videoVolumeImageView.leftToSuperview(offset: 46)
        
        self.view.addSubview(self.videoVolumeCenterLine)
        self.videoVolumeCenterLine.centerY(to: self.videoVolumeImageView)
        self.videoVolumeCenterLine.leftToRight(of: self.videoVolumeImageView, offset: 12)
        self.videoVolumeCenterLine.rightToSuperview(offset: -46)
        
        self.view.addSubview(self.videoAudioLabel)
        self.videoAudioLabel.left(to: self.videoVolumeCenterLine, offset: 2)
        self.videoAudioLabel.topToBottom(of: self.videoVolumeCenterLine)
        
        self.view.addSubview(self.videoVolumeSlider)
        self.videoVolumeSlider.bottomToTop(of: self.videoVolumeCenterLine, offset: 2)
        self.videoVolumeSlider.left(to: self.videoVolumeCenterLine)
        
        self.view.addSubview(self.videoSliderLabel)
        self.videoSliderLabel.right(to: self.videoVolumeCenterLine)
        self.videoSliderLabel.centerY(to: self.videoVolumeSlider, offset: -2)
        
        self.videoVolumeSlider.rightToLeft(of: self.videoSliderLabel, offset: -10)
        
        self.view.addSubview(self.musicVolumeImageView)
        self.musicVolumeImageView.topToBottom(of: self.videoVolumeImageView, offset: 10)
        self.musicVolumeImageView.left(to: self.videoVolumeImageView)
        
        self.view.addSubview(self.musicVolumeCenterLine)
        self.musicVolumeCenterLine.centerY(to: self.musicVolumeImageView)
        self.musicVolumeCenterLine.leftToRight(of: self.musicVolumeImageView, offset: 12)
        self.musicVolumeCenterLine.rightToSuperview(offset: -46)
        
        self.view.addSubview(self.musicAudioLabel)
        self.musicAudioLabel.left(to: self.musicVolumeCenterLine, offset: 2)
        self.musicAudioLabel.topToBottom(of: self.musicVolumeCenterLine)
        
        self.view.addSubview(self.musicVolumeSlider)
        self.musicVolumeSlider.bottomToTop(of: self.musicVolumeCenterLine, offset: 2)
        self.musicVolumeSlider.left(to: self.musicVolumeCenterLine)
        
        self.view.addSubview(self.musicSliderLabel)
        self.musicSliderLabel.right(to: self.musicVolumeCenterLine)
        self.musicSliderLabel.centerY(to: self.musicVolumeSlider, offset: -2)
        
        self.musicVolumeSlider.rightToLeft(of: self.musicSliderLabel, offset: -10)
        
        self.view.addSubview(self.saveButton)
        self.saveButton.bottomToSuperview(offset: -10, usingSafeArea: true)
        self.saveButton.leftToSuperview(offset: 30)
        self.saveButton.rightToSuperview(offset: -30)
        
        self.view.addSubview(self.availableMusicTableView)
        self.availableMusicTableView.bottomToTop(of: self.saveButton, offset: -10)
        self.availableMusicTableView.left(to: self.saveButton)
        self.availableMusicTableView.right(to: self.saveButton)
        
        self.view.addSubview(self.forYouButton)
        self.forYouButton.bottomToTop(of: self.availableMusicTableView, offset: -10)
        self.forYouButton.left(to: self.saveButton)
        
        self.view.addSubview(self.savedButton)
        self.savedButton.leftToRight(of: self.forYouButton, offset: 2)
        self.savedButton.centerY(to: self.forYouButton)
        
        self.view.addSubview(self.featuredMusicCollectionView)
        self.featuredMusicCollectionView.bottomToTop(of: self.forYouButton, offset: -20)
        self.featuredMusicCollectionView.left(to: self.saveButton)
        self.featuredMusicCollectionView.rightToSuperview()
        
        self.view.addSubview(self.featuredLabel)
        self.featuredLabel.bottomToTop(of: self.featuredMusicCollectionView, offset: -13)
        self.featuredLabel.left(to: self.saveButton)
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
        _allAvailableVideoMusic = Music.allTempSongs
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
    
    @objc func didTapForYou() {
        self.isShowingSaved = false
        self.forYouButton.tintColor = .kwiksTextBlack
        self.savedButton.tintColor = .kwiksGrey
        self.availableMusicTableView.reloadData()
    }
    
    @objc func didTapSaved() {
        self.isShowingSaved = true
        self.forYouButton.tintColor = .kwiksGrey
        self.savedButton.tintColor = .kwiksTextBlack
        self.availableMusicTableView.reloadData()
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider) {
        let roundedValue = Int(sender.value)
        
        switch sender.tag {
        case 0:
            self.videoSliderLabel.text = "\(roundedValue)%"
            return
            
        case 1:
            self.musicSliderLabel.text = "\(roundedValue)%"
            return
            
        default:
            return
        }
    }
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        self.searchBar.resignFirstResponder()
        self.view.endEditing(true)
    }
}
//MARK: - UITableView DataSource & Delegate
extension AddMusicToVideoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isShowingSaved {
            return self.savedSongs.count
        } else {
            return self.filteredSongs.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AvailableMusicTableViewCell.identifier, for: indexPath) as! AvailableMusicTableViewCell
        let selectedSong = self.filteredSongs[indexPath.item]
        
        cell.configure(with: selectedSong)
        
        cell.cellCallback = {
            print("Play This Song - ", selectedSong.songTitle ?? "Song Error")
            cell.nowPlayingImageView.isHidden.toggle()
        }
        
        cell.bookmarkCallback = {
            print("Bookmark This Song - ", selectedSong.songTitle ?? "Song Error")
            
            if self.songIDs.contains(selectedSong.uuid!) {
                //Remove
                if let index = self.songIDs.firstIndex(of: selectedSong.uuid!) {
                    self.songIDs.remove(at: index)
                    tableView.reloadData()
                }
            } else {
                //Add
                self.songIDs.append(selectedSong.uuid!)
                self.savedSongs.append(selectedSong)
                tableView.reloadData()
            }
        }
        
        cell.trashCallback = {
            //TODO: Remove song and remove bookmark
            print("Delete This Song - ", selectedSong.songTitle ?? "Song Error")
            
            if let index = self.songIDs.firstIndex(of: selectedSong.uuid!) {
                self.songIDs.remove(at: index)
            }
            
            self.savedSongs.remove(at: indexPath.item)
            tableView.reloadData()
        }
        
        if self.songIDs.contains(selectedSong.uuid!) {
            cell.bookmarkButton.setImage(UIImage(named: "BookmarkSelectedIcon"), for: .normal)
        } else {
            cell.bookmarkButton.setImage(UIImage(named: "BookmarkIcon"), for: .normal)
        }
        
        if isShowingSaved {
            cell.showTrashCan()
            
            let selectedSong = self.savedSongs[indexPath.item]
            cell.configure(with: selectedSong)
            
        } else {
            cell.hideTrashCan()
            
            let selectedSong = self.filteredSongs[indexPath.item]
            cell.configure(with: selectedSong)
        }
        
        return cell
    }
    
    //TODO: Show music playing icon on cell tap.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: indexPath) as? AddParticipantsCell {
//            let selectedSong = self.filteredSongs[indexPath.item]
//            let songTitle = selectedSong.songTitle
//            print(songTitle ?? "Error")
//        }
        
//        let selectedButtonCell = sender.superview as! UITableViewCell
//        guard let indexPath = tableView.indexPath(for: selectedButtonCell) else {return}
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
//MARK: UICollectionView Delegate & DataSource
extension AddMusicToVideoController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.featuredMusic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedMusicCollectionViewCell.identifier, for: indexPath) as! FeaturedMusicCollectionViewCell
        let featuredMusic = self.featuredMusic[indexPath.item]
        cell.configure(with: featuredMusic)
        return cell
    }
    
    
}
