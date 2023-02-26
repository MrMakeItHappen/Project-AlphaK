//
//  AlertController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/26/23.
//

import UIKit

final class UploadImageController: UIViewController {
    private let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.roundCorners(corners: [.topLeft, .topRight], radius: 25)
        view.height(320)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layoutUI()
    }
}
//MARK: - Configure View Controller
extension UploadImageController {
    private func configure() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)
    }
}
//MARK: - Helpers
extension UploadImageController {
    func layoutUI() {
        self.view.addSubview(self.containerView)
        self.containerView.bottomToSuperview()
        self.containerView.leftToSuperview()
        self.containerView.rightToSuperview()
    }
}
//MARK: - @objc
extension UploadImageController {
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
}
