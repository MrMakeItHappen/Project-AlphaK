//
//  TagPeopleController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/17/23.
//

import UIKit

final class TagPeopleController: UIViewController {
    var tempUsers: [TempUser] = TempUser.tempUsers
    
    private var filteredUsers: [TempUser] = []
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
        searchBar.returnKeyType = .done
        return searchBar
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
    
    private lazy var addParticipantsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .interactive
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(AddParticipantsCell.self, forCellReuseIdentifier: AddParticipantsCell.identifier)
        tableView.height(310)
        return tableView
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
        self.filteredUsers = self.tempUsers
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
        
        self.view.addSubview(self.saveButton)
        self.saveButton.bottomToSuperview(offset: -10, usingSafeArea: true)
        self.saveButton.leftToSuperview(offset: 30)
        self.saveButton.rightToSuperview(offset: -30)
        
        self.view.addSubview(self.addParticipantsTableView)
        self.addParticipantsTableView.topToBottom(of: self.searchBar, offset: 20)
        self.addParticipantsTableView.leftToSuperview(offset: 30)
        self.addParticipantsTableView.rightToSuperview(offset: -30)
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
    
    @objc func didTapSave() {
        print(#function)
    }
}

//MARK: - TableView DataSource & Delegate
extension TagPeopleController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddParticipantsCell.identifier, for: indexPath) as! AddParticipantsCell
        let user = self.filteredUsers[indexPath.item]
        cell.configure(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AddParticipantsCell {
            cell.toggle()
        }
    }
    
}

//MARK: - UISearchBar Delegate
extension TagPeopleController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            self.filteredUsers = (tempUsers.filter { person in
                
                self.searchCategories = person.name.lowercased()
                return searchCategories!.contains(searchText.lowercased())
            })

            self.addParticipantsTableView.reloadData()

        } else {
            self.filteredUsers = self.tempUsers
            self.addParticipantsTableView.reloadData()
        }
    }
}
