//
//  Effect.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/11/23.
//

import UIKit

struct Effect {
    var name: String
    var image: UIImage?
    
    //Temp
    static let testEffectOne = Effect(name: "One", image: UIImage(named: "RemoveEffectIcon"))
    static let testEffectTwo = Effect(name: "Two", image: UIImage(named: "UploadImageIconV2"))
    static let testEffectThree = Effect(name: "Three", image: UIImage(named: "UnknownEffectIcon"))
    
    static let effectExamples: [Effect] = [testEffectOne, testEffectTwo, testEffectThree, testEffectThree, testEffectThree, testEffectThree, testEffectThree, testEffectThree, testEffectThree]
    
    //Temp for Video Calling Effects
    static let effectOne = Effect(name: "nil", image: UIImage(named: "TimerIcon"))
    static let effectTwo = Effect(name: "nil", image: UIImage(named: "BeautifyIcon"))
    static let effectThree = Effect(name: "nil", image: UIImage(named: "CommentTextFieldIcon"))
    static let effectFour = Effect(name: "nil", image: UIImage(named: "OffCameraLightIcon"))
    static let effectFive = Effect(name: "nil", image: UIImage(named: "StatsIcon"))
    static let effectSix = Effect(name: "nil", image: UIImage(named: "UploadImageIconV2"))
    
    static let effectsExamples = [effectOne, effectTwo, effectThree, effectFour, effectFive, effectSix]
    static let backgroundExamples = [effectSix, effectFive, effectFour, effectThree, effectTwo, effectOne]
    static let lightingsExamples = [effectFour, effectThree, effectTwo, effectOne, effectSix, effectFive]
    static let activeExamples = [effectThree, effectSix, effectOne, effectFive, effectTwo, effectFour]
    
    //Beautify Options
    static let smooth = Effect(name: "Smooth", image: UIImage(named: "SmoothIcon"))
    static let contrast = Effect(name: "Contrast", image: UIImage(named: "ContrastIcon"))
    static let lips = Effect(name: "Lips", image: UIImage(named: "LipsIcon"))
    static let teeth = Effect(name: "Teeth", image: UIImage(named: "TeethIcon"))
    static let lipstick = Effect(name: "Lipstick", image: UIImage(named: "LipstickIcon"))
    static let contour = Effect(name: "Contour", image: UIImage(named: "ContourIcon"))
    
    static let beautifyExamples: [Effect] = [smooth, contrast, lips, teeth, lipstick, contour]
}
