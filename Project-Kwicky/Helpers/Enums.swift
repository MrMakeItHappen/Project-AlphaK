//
//  Enums.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/10/23.


import Foundation

enum SelectionType {
    case effects
    case beautify
    case stickers
    case none
}

enum BeautifyType {
    case smooth
    case contrast
    case lips
    case teeth
    case lipstick
    case contour
    case none
}

enum PrivacyType {
    case everyone
    case friends
    case onlyMe
}

enum PrivacyPath {
    case posts
    case comments
    case mentions
    case directMessages
}

enum VerifyType {
    case sms
    case email
    case none
}

enum PathType {
    case phone
    case email
    case password
    case deactivate
    case delete
    case none
}

enum DownloadType {
    case profile
    case activity
    case none
}
