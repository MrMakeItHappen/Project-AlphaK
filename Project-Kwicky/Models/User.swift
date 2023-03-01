//
//  User.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/1/23.
//

import Foundation

struct User {
    var firsName: String
    var lastName: String
    var phoneNumber: String
    var signUpDate: String
    var emailAddress: String
    var dateOfBirth: String
    var biography: String
    var location: String
    var userName: String
    var analytics: KwiksUserAnalytics
    var uploadedVideos: [KwiksVideo]
    var savedVideos: [KwiksVideo]
    var wallet: KwiksWallet
    var followers: [User]
    var following: [User]
    var notification: KwiksNotification
    var socialMediaLinks: SocialMedia
}
