//
//  Mixpanel.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/30/23.
//

import Foundation
//import Mixpanel

//class MixpanelManager: NSObject {
//
//  static let shared = MixpanelManager()
//
//  func updateKey(key: String) {
//    Mixpanel.mainInstance().track(event:key)
//  }
//
//  func updateCounts(key: String, counts: Double) {
//    Mixpanel.mainInstance().people.increment(property: key, by: counts)
//  }
//}

///mixpanel integration - only track for production
//if EnvironemntModeHelper.isCurrentEnvironmentDebug() {
//    Mixpanel.initialize(token: "")
//} else {
//    Mixpanel.initialize(token: K.MIXPANEL_TOKEN)
//    Mixpanel.mainInstance().loggingEnabled = false
//}
//
//class EnvironemntModeHelper: NSObject {
//
//    static func isCurrentEnvironmentDebug() -> Bool {
//
//#if DEBUG
//        return true
//#else
//        return false
//#endif
//    }
//}
