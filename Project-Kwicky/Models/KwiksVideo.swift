//
//  KwiksVideo.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/1/23.
//

import Foundation
import UIKit

struct KwiksVideo {
    var uuid: UUID?
    var title: String?
    var uploadDate: String?
    var viewCount: Int?
    var earnedAmount: Int?
    var likesCount: Int?
    var commentCount: Int?
    var uploadedFrom: User
    var songTitle: String?
    var duration: Int?
    var isLive: Bool?
    var isLikedByCurrentUser: Bool?
    var viewers: Int?
    var hashtags: [String]?
    var analytics: KwiksVideoAnalytics?
    var deleteLaterImage: UIImage?
    
    static let videoExampleOne = KwiksVideo(title: "YouTube Web Redesign Challenge Contest", uploadedFrom: User.exampleUserOne, viewers: 9999, deleteLaterImage: UIImage(named: "PlaceholderVideoImage01"))
    static let videoExampleTwo = KwiksVideo(title: "Living Room Transformation. Unbeleivable!!!", uploadedFrom: User.exampleUserTwo, viewers: 9999, deleteLaterImage: UIImage(named: "PlaceholderVideoImage02"))
    static let videoExampleThree = KwiksVideo(title: "Crazy Cat Videos. Cat Lovers Only. Meow.", uploadedFrom: User.exampleUserThree, viewers: 9999, deleteLaterImage: UIImage(named: "PlaceholderVideoImage03"))
    static let videoExampleFour = KwiksVideo(title: "Destiny 2 Lightfall Secret Missions. Heavy Spoilers!", uploadedFrom: User.exampleUserFour, viewers: 9999, deleteLaterImage: UIImage(named: "PlaceholderVideoImage06"))
    static let videoExampleFive = KwiksVideo(title: "Inside The Last of Us - Season Finale Discussion", uploadedFrom: User.exampleUserFive, viewers: 9999, deleteLaterImage: UIImage(named: "PlaceholderVideoImage07"))
    
    static let liveExampleOne = KwiksVideo(title: "YouTube Web Redesign Challenge Contest", uploadedFrom: User.exampleUserOne, isLive: true, viewers: 9999, deleteLaterImage: UIImage(named: "PlaceholderVideoImage01"))
    static let liveExampleTwo = KwiksVideo(title: "Living Room Transformation. Unbeleivable!!!", uploadedFrom: User.exampleUserTwo, isLive: true, viewers: 9999, deleteLaterImage: UIImage(named: "PlaceholderVideoImage02"))
    static let liveExampleThree = KwiksVideo(title: "Crazy Cat Videos. Cat Lovers Only. Meow.", uploadedFrom: User.exampleUserThree, isLive: true, viewers: 9999, deleteLaterImage: UIImage(named: "PlaceholderVideoImage03"))
    static let liveExampleFour = KwiksVideo(title: "Destiny 2 Lightfall Secret Missions. Heavy Spoilers!", uploadedFrom: User.exampleUserFour, isLive: true, viewers: 9999, deleteLaterImage: UIImage(named: "PlaceholderVideoImage06"))
    static let liveExampleFive = KwiksVideo(title: "Inside The Last of Us - Season Finale Discussion", uploadedFrom: User.exampleUserFive, isLive: true, viewers: 9999, deleteLaterImage: UIImage(named: "PlaceholderVideoImage07"))
    
    static let forYouExampleVideos = [videoExampleOne, videoExampleTwo, videoExampleThree, videoExampleFour, videoExampleFive]
    static let friendsExampleVideos = [videoExampleFive, videoExampleFour, videoExampleThree, videoExampleTwo, videoExampleOne]
    static let popularExampleVideos = [videoExampleThree, videoExampleTwo, videoExampleOne, videoExampleFive, videoExampleFour]
    static let liveExampleVideos = [liveExampleFour, liveExampleThree, liveExampleOne, liveExampleFive, liveExampleTwo]
}
