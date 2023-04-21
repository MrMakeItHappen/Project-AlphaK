//
//  KwiksSaleItem.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/26/23.
//

import UIKit

struct KwiksSaleItem {
    var uuid: UUID?
    var imageURL: String?
    var productName: String?
    var productDescription: String?
    var productURL: String?
    var starRating: String?
    var coinValue: String?
    
    //Temp Featured Items
    static let featuredItemOne = KwiksSaleItem(productName: "AirPods Pro", starRating: "5", coinValue: "999")
    static let featuredItemTwo = KwiksSaleItem(productName: "AirPods Pro 2", starRating: "5", coinValue: "999")
    static let featuredItemThree = KwiksSaleItem(productName: "AirPods Pro Max", starRating: "5", coinValue: "999")
    
    static let tempFeaturedItems: [KwiksSaleItem] = [featuredItemOne, featuredItemTwo, featuredItemThree]
}
