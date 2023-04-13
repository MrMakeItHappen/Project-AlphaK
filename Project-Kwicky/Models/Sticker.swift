//
//  Sticker.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/13/23.
//

import UIKit

struct Sticker {
    var name: String
    var image: UIImage
    
    //Temp Stickers
    static let stickerOne = Sticker(name: "S1", image: UIImage(named: "Sticker01")!)
    static let stickerTwo = Sticker(name: "S2", image: UIImage(named: "Sticker02")!)
    static let stickerThree = Sticker(name: "S3", image: UIImage(named: "Sticker03")!)
    static let stickerFour = Sticker(name: "S4", image: UIImage(named: "Sticker04")!)
    static let stickerFive = Sticker(name: "S5", image: UIImage(named: "Sticker05")!)
    static let stickerSix = Sticker(name: "S6", image: UIImage(named: "Sticker06")!)
    
    static let allTempStickers: [Sticker] = [stickerOne, stickerTwo, stickerThree, stickerFour, stickerFive, stickerSix, stickerOne, stickerTwo, stickerThree, stickerFour, stickerFive, stickerSix, stickerOne, stickerTwo, stickerThree, stickerFour, stickerFive, stickerSix]
}
