//
//  KwiksVideoPlayerController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/8/23.
//

import UIKit

final class KwiksVideoPlayerController: UIViewController {
    var kwiksVideo: KwiksVideo!
    
    private lazy var customBackButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor.black
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        button.height(16)
        button.width(16)
        button.setImage(UIImage(named: "LeftChervon"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.layoutUI()
    }

}
//MARK: - Layout UI
extension KwiksVideoPlayerController {
    private func layoutUI() {
        self.view.addSubview(self.customBackButton)
        self.customBackButton.topToSuperview(offset: 22, usingSafeArea: true)
        self.customBackButton.leftToSuperview(offset: 22)
    }
}
//MARK: - @objc
extension KwiksVideoPlayerController {
    @objc func didTapBack() {
        self.dismiss(animated: true)
    }
}
