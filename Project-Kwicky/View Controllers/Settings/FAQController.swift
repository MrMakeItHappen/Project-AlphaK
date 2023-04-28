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
        label.font = UIFont.segoeUIBold(size: 19)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
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
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerY(to: self.customBackButton)
        self.titleLabel.centerXToSuperview()
        
        self.view.addSubview(self.searchBar)
        self.searchBar.topToBottom(of: self.titleLabel, offset: 40)
        self.searchBar.leftToSuperview(offset: 30)
        self.searchBar.rightToSuperview(offset: -30)
        
        self.view.addSubview(self.questionTableView)
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
