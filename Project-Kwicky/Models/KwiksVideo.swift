//
//  KwiksVideo.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/1/23.
//

import Foundation

struct KwiksVideo {
    var title: String
    var uploadDate: String
    var viewCount: Int
    var earnedAmount: Int
    var likesCount: Int
    var commentCount: Int
    var uploadedFrom: User
    var songTitle: String
    var duration: Int
    var isLive: Bool
    var viewers: Int
    var hashtags: [String]
    var analytics: KwiksVideoAnalytics
}
