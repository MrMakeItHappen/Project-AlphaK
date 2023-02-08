//
//  UIFont+Ext.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/8/23.
//

import UIKit

//Segoe UI
extension UIFont {
    static func segoeUIBold(size fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Segoe-UI-Bold", size: fontSize)!
    }
    
    static func segoeUIRegular(size fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Segoe-UI", size: fontSize)!
    }
}

//Inter
extension UIFont {
    static func interBold(size fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Bold", size: fontSize)!
    }
    
    static func interRegular(size fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Regular", size: fontSize)!
    }
    
    static func interLight(size fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Light", size: fontSize)!
    }
    
    static func interMedium(size fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Medium", size: fontSize)!
    }
    
    static func interSemiBold(size fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Inter-SemiBold", size: fontSize)!
    }
    
    static func interThin(size fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Thin", size: fontSize)!
    }
}
