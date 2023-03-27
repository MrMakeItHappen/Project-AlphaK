//
//  AvailableMusic.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/26/23.
//

import Foundation

struct AvailableMusic {
    var uuid: UUID?
    var songURL: String?
    var songTitle: String?
    var artistName: String?
    var duration: String?
    var numberOfVideosFeaturingSong: String?
    
    static let tempSongOne = AvailableMusic(songTitle: "Top de Shikari", artistName: "Surjit Khan", duration: "01:00", numberOfVideosFeaturingSong: "999 M")
    static let tempSongTwo = AvailableMusic(songTitle: "Blazers And Backpacks", artistName: "Little Cabin", duration: "01:00", numberOfVideosFeaturingSong: "9 M")
    static let tempSongThree = AvailableMusic(songTitle: "Money Machine", artistName: "Blank Check", duration: "01:00", numberOfVideosFeaturingSong: "99 M")
    static let tempSongFour = AvailableMusic(songTitle: "Secret Sunshine", artistName: "Unique", duration: "01:00", numberOfVideosFeaturingSong: "2")
    static let tempSongFive = AvailableMusic(songTitle: "Mi Casa", artistName: "Hector & Juan", duration: "01:00", numberOfVideosFeaturingSong: "0")
    
    static let allTempSongs: [AvailableMusic] = [tempSongOne, tempSongTwo, tempSongThree, tempSongFour, tempSongFive, tempSongOne, tempSongTwo, tempSongThree, tempSongFour, tempSongFive]
}
