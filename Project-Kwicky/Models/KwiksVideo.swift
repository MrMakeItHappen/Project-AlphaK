//
//  KwiksVideo.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/1/23.
//

import Foundation
import UIKit

struct KwiksVideo {
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
    var viewers: Int?
    var hashtags: [String]?
    var analytics: KwiksVideoAnalytics?
    var deleteLaterImage: UIImage?
    
    static let videoExampleOne = KwiksVideo(title: "YouTube Web Redesign Challenge Contest", uploadedFrom: User.exampleUserOne, viewers: 999, deleteLaterImage: UIImage(named: "PlaceholderVideoImage01"))
    static let videoExampleTwo = KwiksVideo(title: "Living Room Transformation. Unbeleivable!!!", uploadedFrom: User.exampleUserTwo, viewers: 999, deleteLaterImage: UIImage(named: "PlaceholderVideoImage02"))
    static let videoExampleThree = KwiksVideo(title: "Crazy Cat Videos. Cat Lovers Only. Meow.", uploadedFrom: User.exampleUserThree, viewers: 999, deleteLaterImage: UIImage(named: "PlaceholderVideoImage03"))
    static let videoExampleFour = KwiksVideo(title: "Destiny 2 Lightfall Secret Missions. Heavy Spoilers!", uploadedFrom: User.exampleUserFour, viewers: 999, deleteLaterImage: UIImage(named: "PlaceholderVideoImage06"))
    static let videoExampleFive = KwiksVideo(title: "Inside The Last of Us - Season Finale Discussion", uploadedFrom: User.exampleUserFive, viewers: 999, deleteLaterImage: UIImage(named: "PlaceholderVideoImage07"))
    
    static let allExampleVideos = [videoExampleOne, videoExampleTwo, videoExampleThree, videoExampleFour, videoExampleFive]
}
