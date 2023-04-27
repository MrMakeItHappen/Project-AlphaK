//
//  SettingsItem.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/19/23.
//

import UIKit

struct SettingsItem {
    var title: String
    var icon: UIImage!
    
    static let followSection = SettingsItem(title: "Follow And Invite Friends", icon: UIImage(named: "FollowSettingsIcon"))
    static let notificationSection = SettingsItem(title: "Notifications", icon: UIImage(named: "NotificationsSettingsIcon"))
    static let privacySection = SettingsItem(title: "Privacy", icon: UIImage(named: "PrivacySettingsIcon"))
    static let securitySection = SettingsItem(title: "Security", icon: UIImage(named: "SecuritySettingsIcon"))
    static let accountSection = SettingsItem(title: "Account", icon: UIImage(named: "AccountSettingsIcon"))
    static let helpSection = SettingsItem(title: "Help", icon: UIImage(named: "HelpSettingsIcon"))
    static let aboutSection = SettingsItem(title: "About", icon: UIImage(named: "AboutSettingsIcon"))
    
    static let allItems = [followSection, notificationSection, privacySection, securitySection, accountSection, helpSection, aboutSection]
}
