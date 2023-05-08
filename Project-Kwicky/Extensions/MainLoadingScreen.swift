//
//  MainLoadingScreen.swift
//  Project-Kwicky
//
//  Created by Charlie Arcodia on 5/7/23.
//

import Foundation
import Lottie
import UIKit

class MainLoadingScreen : NSObject {
    
    var keyWindow : UIWindow = UIWindow()
    
    var smokeView : UIView = UIView()
    
    var loadingAnimation : LottieAnimationView = LottieAnimationView()
    
    ///dynamic loader - if centered -- false, it throws it 150 points from the header
    func callMainLoadingScreen(lottiAnimationName : String, isCentered: Bool) {
        
        self.keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }!
        
        self.loadingAnimation.animation = LottieAnimation.named(lottiAnimationName)
        self.loadingAnimation.loopMode = .loop
        self.loadingAnimation.backgroundBehavior = .pauseAndRestore
        self.loadingAnimation.animationSpeed = 1
        self.loadingAnimation.backgroundColor = .clear
        self.loadingAnimation.layer.masksToBounds = true
        self.loadingAnimation.translatesAutoresizingMaskIntoConstraints = false
        
        self.smokeView.translatesAutoresizingMaskIntoConstraints = true
        self.smokeView.frame = UIScreen.main.bounds
        self.smokeView.isUserInteractionEnabled = true
        self.smokeView.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        self.smokeView.alpha = 1
        self.loadingAnimation.alpha = 1
        
        self.keyWindow.addSubview(self.smokeView)
        self.keyWindow.addSubview(self.loadingAnimation)
        
        if isCentered == false {
            self.loadingAnimation.topAnchor.constraint(equalTo: self.smokeView.topAnchor, constant: 150).isActive = true
        } else {
            self.loadingAnimation.centerYAnchor.constraint(equalTo: self.smokeView.centerYAnchor).isActive = true
        }
        self.loadingAnimation.centerXAnchor.constraint(equalTo: self.smokeView.centerXAnchor, constant: 0).isActive = true
        self.loadingAnimation.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.5).isActive = true
        self.loadingAnimation.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.5).isActive = true
        
        self.loadingAnimation.play()
        
    }
    
    func cancelMainLoadingScreen() {
        
        DispatchQueue.main.async {
        
        UIView.animate(withDuration: 0.5) {
            
            self.smokeView.alpha = 0
            self.loadingAnimation.alpha = 0
            
        } completion: { (isComplete) in
            
            self.loadingAnimation.stop()

            self.smokeView.removeFromSuperview()
            self.keyWindow.removeFromSuperview()
            self.loadingAnimation.removeFromSuperview()
            
            }
        }
    }
}
