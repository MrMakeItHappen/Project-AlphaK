//
//  VideoController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/19/23.
//

import UIKit

final class VideoController: UIViewController {
    private let tabBarExtension: UIView = {
        let view = UIView(frame: .zero)
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor(red: 0.090, green: 0.090, blue: 0.090, alpha: 1)
        view.height(6)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.layoutUI()
    }
}
//MARK: - Layout UI
extension VideoController {
    private func layoutUI() {
        self.view.addSubview(self.tabBarExtension)
        self.tabBarExtension.bottomToSuperview(usingSafeArea: true)
        self.tabBarExtension.leftToSuperview()
        self.tabBarExtension.rightToSuperview()
    }
}
