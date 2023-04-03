//
//  AddParticipantsController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/2/23.
//

import UIKit

struct TempUser {
    var name: String
    var profileImage: UIImage
    
    static let tempUserOne = TempUser(name: "Kenny Rogers", profileImage: UIImage(named: "MalePlaceholder")!)
    static let tempUserTwo = TempUser(name: "Jill Valentine", profileImage: UIImage(named: "FemalePlaceholder")!)
    static let tempUserThree = TempUser(name: "Romona Childs", profileImage: UIImage(named: "FemalePlaceholder02")!)
    static let tempUserFour = TempUser(name: "Robert Roundtree", profileImage: UIImage(named: "MalePlaceholder02")!)
    static let tempUserFive = TempUser(name: "Clinton Sparks", profileImage: UIImage(named: "MalePlaceholder03")!)
    static let tempUserSix = TempUser(name: "April Bishop", profileImage: UIImage(named: "FemalePlaceholder03")!)
    static let tempUserSeven = TempUser(name: "Bobby Digital", profileImage: UIImage(named: "MalePlaceholder04")!)
    static let tempUserEight = TempUser(name: "Dakota Fayre", profileImage: UIImage(named: "FemalePlaceholder04")!)
    
    static let tempUsers = [tempUserOne, tempUserTwo, tempUserThree, tempUserFour, tempUserFive, tempUserSix, tempUserSeven, tempUserEight]
}

final class AddParticipantsController: UIViewController {
    var presentingController: SoloVideoCallController?
    var tempUsers: [TempUser] = TempUser.tempUsers
    
    private var filteredUsers: [TempUser] = []
    private var searchCategories: String?
    
    private let backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.roundCorners(corners: [.topLeft, .topRight], radius: 25)
        view.height(600)
        return view
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
    
    private let callButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.tintColor = UIColor.black
        button.backgroundColor = UIColor.kwiksGreen
        button.setTitle("Call", for: .normal)
        button.titleLabel?.font = .segoeUISemiBold(size: 18)
        button.height(60)
        button.width(145)
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
        return tableView
    }()
    
    private let gestureContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.clear
        view.clipsToBounds = true
        return view
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
extension AddParticipantsController {
    private func configure() {
        self.view.backgroundColor = .clear
        self.filteredUsers = self.tempUsers
        self.callButton.addTarget(self, action: #selector(didTapCall), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.gestureContainerView.isUserInteractionEnabled = true
        self.gestureContainerView.addGestureRecognizer(tapGesture)
    }
}

//MARK: - Layout UI
extension AddParticipantsController {
    private func layoutUI() {
        self.view.addSubview(self.backgroundView)
        self.backgroundView.edgesToSuperview()
        
        self.backgroundView.addSubview(self.containerView)
        self.containerView.bottomToSuperview()
        self.containerView.leftToSuperview()
        self.containerView.rightToSuperview()
        
        self.containerView.addSubview(self.searchBar)
        self.searchBar.topToSuperview(offset: 37)
        self.searchBar.rightToSuperview(offset: -30)
        self.searchBar.leftToSuperview(offset: 30)
        
        self.containerView.addSubview(self.callButton)
        self.callButton.bottomToSuperview(offset: -30, usingSafeArea: true)
        self.callButton.rightToSuperview(offset: -30)
        
        self.containerView.addSubview(self.addParticipantsTableView)
        self.addParticipantsTableView.topToBottom(of: self.searchBar, offset: 20)
        self.addParticipantsTableView.bottomToTop(of: self.callButton, offset: -60)
        self.addParticipantsTableView.left(to: self.searchBar)
        self.addParticipantsTableView.right(to: self.searchBar)
        
        self.backgroundView.addSubview(self.gestureContainerView)
        self.gestureContainerView.leftToSuperview()
        self.gestureContainerView.rightToSuperview()
        self.gestureContainerView.bottomToTop(of: self.containerView)
        self.gestureContainerView.topToSuperview()
    }
}

//MARK: - Helpers
extension AddParticipantsController {
    private func modifySearchbarIcon() {
        if let searchIconImageView = self.searchBar.searchTextField.leftView as? UIImageView {
            searchIconImageView.image = searchIconImageView.image?.withRenderingMode(.alwaysTemplate)
            searchIconImageView.tintColor = UIColor.black
        }
    }
}

//MARK: - @objc
extension AddParticipantsController {
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapCall() {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - TableView DataSource & Delegate
extension AddParticipantsController: UITableViewDelegate, UITableViewDataSource {
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

//MARK: - UISearchbar
extension AddParticipantsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            self.filteredUsers = (self.tempUsers.filter { user in
                
                let username = user.name
                
                self.searchCategories = username
                return searchCategories!.contains(searchText)
            })
            
            self.addParticipantsTableView.reloadData()
            
        } else {
            self.filteredUsers = self.tempUsers
            self.addParticipantsTableView.reloadData()
        }
    }
}
