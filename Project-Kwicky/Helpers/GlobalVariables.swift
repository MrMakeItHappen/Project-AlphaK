//
//  GlobalVariables.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/26/23.
//

import Foundation

//MARK: - Global Variables for User.

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

///Set only on Edit Phone Number Controller
var _userPhoneNumber: String? = "(999) 123-8800"

///Set only on Edit Email Controller
var _userEmailAddress: String? = "kwiks@kwiky.com"

var _loginTrajectory = LoginTrajectory.fromEmail

var _onboardingTrajectory = OnboardingTrajectory.fromLogin

///onboarding only
var userOnboardingStruct = UserOnboardingStruct()
///everytime a user enters the app with auth
var userProfileStruct = UserProfileStruct()

var _jwtToken : String?




//MARK: - Globals

///Set on app load
var _globalDeviceWidth: CGFloat = 0.0
var _globalDeviceHeight: CGFloat = 0.0

var _authType = PathType.email //decision for auth whether email / phone

///Kwiks Podfile Pop Up Alert Example
//self.popUpAlert = KwiksSystemPopups(presentingViewController: self, popupType: .updateKwiks)
//self.popUpAlert.engagePopup()
