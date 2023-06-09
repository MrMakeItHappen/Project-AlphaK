//
//  User.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/1/23.
//

import Foundation

struct User {
    var uuid: UUID?
    var firsName: String?
    var lastName: String?
    var profileImage: String?
    var phoneNumber: String?
    var signUpDate: String?
    var emailAddress: String?
    var dateOfBirth: String?
    var biography: String?
    var location: String?
    var userName: String?
    var analytics: KwiksUserAnalytics?
    var uploadedVideos: [KwiksVideo]?
    var savedVideos: [KwiksVideo]?
    var wallet: KwiksWallet?
    var followers: [User]?
    var following: [User]?
    var notification: KwiksNotification?
    var socialMediaLinks: SocialMedia?
    
    static let exampleUserOne = User(userName: "Design With Poppie")
    static let exampleUserTwo = User(userName: "5 Minute Crafts")
    static let exampleUserThree = User(userName: "@Stephanie00")
    static let exampleUserFour = User(userName: "@BigFootIsReel")
    static let exampleUserFive = User(userName: "Official Playstation")
}
