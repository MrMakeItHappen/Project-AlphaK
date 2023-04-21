//
//  AvailableMusic.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/26/23.
//

import UIKit

struct Music: Equatable {
    var uuid: String?
    var songURL: String?
    var songTitle: String?
    var artistName: String?
    var duration: String?
    var imageURL: String?
    var tempImage: UIImage?
    
    static let tempSongOne = Music(uuid: "1", songTitle: "Top de Shikari", artistName: "Surjit Khan", duration: "1:00")
    static let tempSongTwo = Music(uuid: "2", songTitle: "Blazers And Backpacks", artistName: "Little Cabin", duration: "3:00")
    static let tempSongThree = Music(uuid: "3", songTitle: "Money Machine", artistName: "Blank Check", duration: "1:30")
    static let tempSongFour = Music(uuid: "4", songTitle: "Secret Sunshine", artistName: "Unique", duration: "2:00")
    static let tempSongFive = Music(uuid: "5", songTitle: "Mi Casa", artistName: "Hector & Juan", duration: "2:30")
    
    static let allTempSongs: [Music] = [tempSongOne, tempSongTwo, tempSongThree, tempSongFour, tempSongFive]
    
    //Temp Featured Music
    static let featureOne = Music(songTitle: "Action Jackson", artistName: "Tido", duration: "1:00", tempImage: UIImage(named: "MalePlaceholder02"))
    static let featureTwo = Music(songTitle: "Whisper", artistName: "Lana Rides", duration: "1:30", tempImage: UIImage(named: "VideoSoundPlaceholderImage"))
    static let featureThree = Music(songTitle: "Te Llama", artistName: "Bad Bunny", duration: "2:00", tempImage: UIImage(named: "MalePlaceholder03"))
    
    static let allTempFeatured: [Music] = [featureOne, featureTwo, featureThree]
}
