//
//  Application+Ext.swift
//  Project-Kwicky
//
//  Created by Charlie Arcodia on 5/1/23.
//

import Foundation
import UIKit

//haptic feedback
extension UIDevice {
    static func vibrateLight() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    static func vibrateMedium() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    static func vibrateHeavy() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
}

//sandbox vs. production
class EnvironemntModeHelper : NSObject {
    
    static func isCurrentEnvironmentDebug() -> Bool {
        
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
