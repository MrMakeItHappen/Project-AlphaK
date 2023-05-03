//
//  FAQController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/27/23.
//

import UIKit

final class FAQController: UIViewController {
    private let tempQuestions: [FAQ] = FAQ.allExampleQuestions
    private var filterQuestions: [FAQ] = []
    private var searchCategories: String?
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 30
        
        let image = UIImage(named: "SettingsBackground")
        imageView.image = image
        return imageView
    }()
    
    private lazy var customBackButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.black
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        button.height(23)
        button.width(33)
        button.setImage(UIImage(named: "KwiksBackArrow"), for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "FAQs"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUIBold(size: 40)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        let size: CGFloat = 40
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.height(size)
        imageView.width(size)
        imageView.layer.cornerRadius = size / 2
        
        let image = UIImage(named: "settings_icon_personal_no_shadow")
        imageView.image = image
        return imageView
    }()
    
    private let contentContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.barStyle = .default
        searchBar.placeholder = "Search"
        searchBar.isTranslucent = true
        searchBar.backgroundColor = .white
        searchBar.barTintColor = .white
        searchBar.backgroundImage = UIImage()
        searchBar.height(50)
        searchBar.layer.cornerRadius = 25
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var questionTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.backgroundColor = .white
        tableView.keyboardDismissMode = .interactive
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(QuestionTableViewCell.self, forCellReuseIdentifier: QuestionTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Configure Controller
extension FAQController {
    private func configure() {
        self.view.backgroundColor = .white
        self.filterQuestions = self.tempQuestions
    }
}

//MARK: - Layout UI
extension FAQController {
    private func layoutUI() {
        self.view.addSubview(self.backgroundImageView)
        self.backgroundImageView.topToSuperview(usingSafeArea: true)
        self.backgroundImageView.leftToSuperview()
        self.backgroundImageView.rightToSuperview()
        
        self.view.addSubview(self.customBackButton)
        self.customBackButton.top(to: self.backgroundImageView, offset: 35)
        self.customBackButton.leftToSuperview(offset: 17)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.leftToRight(of: self.customBackButton, offset: 18)
        self.titleLabel.centerY(to: self.customBackButton, offset: -3)
        
        self.view.addSubview(self.iconImageView)
        self.iconImageView.right(to: self.backgroundImageView, offset: -30)
        self.iconImageView.centerY(to: self.customBackButton)
        
        self.view.addSubview(self.contentContainerView)
        self.contentContainerView.topToBottom(of: self.titleLabel, offset: 28)
        self.contentContainerView.leftToSuperview()
        self.contentContainerView.rightToSuperview()
        self.contentContainerView.bottomToSuperview(usingSafeArea: false)
        
        self.contentContainerView.addSubview(self.searchBar)
        self.searchBar.topToSuperview(offset: 22)
        self.searchBar.leftToSuperview(offset: 25)
        self.searchBar.rightToSuperview(offset: -25)
        
        self.contentContainerView.addSubview(self.questionTableView)
        self.questionTableView.topToBottom(of: self.searchBar, offset: 20)
        self.questionTableView.leftToSuperview()
        self.questionTableView.rightToSuperview()
        self.questionTableView.bottomToSuperview(usingSafeArea: true)
    }
}

//MARK: - @objc
extension FAQController {
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - UISearchBar Delegate
extension FAQController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            self.filterQuestions = (tempQuestions.filter { faq in
                
                let question = faq.question.lowercased()
                let answer = faq.answer.lowercased()
                
                self.searchCategories = question + " " + answer
                return searchCategories!.contains(searchText.lowercased())
            })
            
            self.questionTableView.reloadData()
            
        } else {
            self.filterQuestions = tempQuestions
            self.questionTableView.reloadData()
        }
    }
}
//MARK: - UITableView DataSource & Delegate
extension FAQController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as! QuestionTableViewCell
        let question = self.filterQuestions[indexPath.item]

        cell.configure(with: question)
        return cell
    }
}
