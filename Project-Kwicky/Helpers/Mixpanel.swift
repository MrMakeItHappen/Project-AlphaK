//
//  Mixpanel.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/30/23.

//Token: c0ef9a6d40f11836eed4e8f27fbe678f
//API SECRET: 008089d61e1ba60fd8597650284ce8c4
//Access URL: https://mixpanel.com/project/2978384
//Project ID: 2978384

import Foundation
import Mixpanel

class MixpanelManager: NSObject {

  static let shared = MixpanelManager()

  func updateKey(key: String) {
    Mixpanel.mainInstance().track(event:key)
  }

  func updateCounts(key: String, counts: Double) {
    Mixpanel.mainInstance().people.increment(property: key, by: counts)
  }
}
