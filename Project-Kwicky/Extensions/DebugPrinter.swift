//
//  DebugPrinter.swift
//  Project-Kwicky
//
//  Created by Charlie Arcodia on 5/7/23.
//

import Foundation
import UIKit

//only execute print statements on debug mode - no reason in production
class Printer {
    func print(message:String) {
        if EnvironemntModeHelper.isCurrentEnvironmentDebug() {
            debugPrint(message)//normal debug expression print
        }
    }
}
