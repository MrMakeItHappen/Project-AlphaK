//
//  GlobalVariables.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/26/23.
//

import Foundation

//MARK: - Global Variables for user created video.

///Set only on VideoFileSave Controller
var _userCreatedVideo: KwiksVideo?

///Set only on VideoFileSave Controller
var _userDidEnabledComments: Bool? = true

///Set only on AddMusicToVideo Controller
var _userAddedMusic: String?

///Set only on VideoTaggedPeople Controller
var _userTaggedPeople: [String]?

///Set only on AddProductToVideo Controller
var _userAddedProduct: KwiksSaleItem?

///Never set this value. Retrieve only.
var _allAvailableVideoMusic: [Music] = []

//set on app load
var globalDeviceWidth : CGFloat = 0.0,
    globalDeviceHeight : CGFloat = 0.0

///Kwiks Podfile Pop Up Alert Example
//self.popUpAlert = KwiksSystemPopups(presentingViewController: self, popupType: .updateKwiks)
//self.popUpAlert.engagePopup()
