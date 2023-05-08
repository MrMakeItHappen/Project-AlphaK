//
//  OnboardingModel.swift
//  Project-Kwicky
//
//  Created by Charlie Arcodia on 5/7/23.
//

import Foundation
import UIKit

//omboarding model onlu
struct UserOnboardingStruct {
    
    var full_name:String?,
        email:String?,
        birthdate:String?,
        password:String?,
        user_name:String?
}

//general user model, fill on login, registration or return through decision controller
struct UserProfileStruct {
    
    //normal user object
    var phone:String?,
        email:String?,
        username:String?,
        uid:String?,
        avatar:String?,
        name:String?,
        bio:String?,
        link : String?,
        signUpMethod : String?,

        pronouns : String?,
        location : String?,
        languages : [String]?,
        birthdate : String?,
        accountType : String?,
        notifications : [String:Bool]?,
    
        //for settings notifications
        profileViews : Bool?,
        reposts : Bool?,
        newFollowers : Bool?,
        comments : Bool?,
        directMessages : Bool?,
        directMessagesPreview : Bool?,
        mentionsTags : Bool?,
        likes : Bool?

}

