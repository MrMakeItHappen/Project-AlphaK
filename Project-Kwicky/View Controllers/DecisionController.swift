//
//  ViewController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/8/23.
//

import UIKit

final class DecisionController: UIViewController {
    private let background: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Easy Way To Earn Cash"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.segoeUISemiBold(size: 46)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addGradientBackground()
        self.layoutUI()
    }
    
    
}

//Layout UI
extension DecisionController {
    private func addGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.568, green: 0.875, blue: 0.372, alpha: 1).cgColor,
            UIColor(red: 0.444, green: 0.733, blue: 0.26, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        gradientLayer.position = view.center
        self.background.layer.addSublayer(gradientLayer)
        
        self.view.addSubview(self.background)
        self.background.edgesToSuperview()
    }
    
    private func layoutUI() {
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerInSuperview()
        self.titleLabel.leftToSuperview(offset: 50)
        self.titleLabel.rightToSuperview(offset: -50)
    }
}
