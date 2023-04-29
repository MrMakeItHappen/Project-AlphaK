//
//  UIButton+Ext.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/18/23.
//

import Foundation
import UIKit

extension UIButton {
    static func createCloseButton() -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.tintColor = .kwiksGreen
        button.setImage(UIImage(named: "CloseIcon"), for: .normal)
        button.width(16)
        button.height(16)
        return button
    }
    
    static func createSettingsToggleButton(with selector: Selector, for controller: UIViewController) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.isSelected = false
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "IsOnIcon"), for: .selected)
        button.setImage(UIImage(named: "IsOffIcon"), for: .normal)
        button.addTarget(controller, action: selector, for: .touchUpInside)
        button.height(26)
        button.width(48)
        return button
    }
    
    static func createHiddenButton(with selector: Selector, for controller: UIViewController) -> UIButton {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .clear
        button.tintColor = .clear
        button.addTarget(controller, action: selector, for: .touchUpInside)
        return button
    }
}

final class AnimatedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customize()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        customize()
    }
    
    func customize() {
        // confine the subviews to the bounds of this view
        self.clipsToBounds = true
        
        // create a CABasicAnimation for the x-position animation
        let buttonAnimation = CABasicAnimation(keyPath: "position.x")
        
        // begin the animation straight away
        buttonAnimation.beginTime = 1.0
        
        // this animation will last 1.5 seconds
        buttonAnimation.duration = 10.0
        
        // a property representing the x value where the titleLabel will scroll from
//        let buttonRHS: Double = Double(((self.titleLabel?.frame.maxX)! + (self.titleLabel?.frame.width)!))
        let buttonRHS: Double = Double(((self.titleLabel?.frame.maxX)! + 100))
        
        // a property representing the x value where the titleLabel will scroll to
//        let buttonLHS: Double = Double(((self.titleLabel?.frame.minX)! - ((self.titleLabel?.frame.width)!)))
        let buttonLHS: Double = Double(((self.titleLabel?.frame.minX)! - 100))
        
        // set the from value of the animation
        buttonAnimation.fromValue = NSNumber(value: buttonRHS)
        
        // set the to value of the animation
        buttonAnimation.toValue = NSNumber(value: buttonLHS)
        
        // repeat the animation forever
        buttonAnimation.repeatCount = .infinity
        
        // add the animation to the UIButton's titleLabel
        self.titleLabel!.layer.add(buttonAnimation, forKey: "basic")
    }
}
