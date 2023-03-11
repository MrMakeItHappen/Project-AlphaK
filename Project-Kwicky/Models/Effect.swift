//
//  Effect.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/11/23.
//

import UIKit

struct Effect {
    var name: String?
    var image: UIImage?
    
    static let testEffectOne = Effect(name: "One", image: UIImage(named: "RemoveEffectIcon"))
    static let testEffectTwo = Effect(name: "Two", image: UIImage(named: "UploadImageIconV2"))
    static let testEffectThree = Effect(name: "Three", image: UIImage(named: "UnknownEffectIcon"))
    
    static let effectExamples: [Effect] = [testEffectOne, testEffectTwo, testEffectThree, testEffectThree, testEffectThree, testEffectThree, testEffectThree, testEffectThree, testEffectThree]
}
