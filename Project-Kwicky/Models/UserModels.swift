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
        dob:String?,
        email:String?,
        date:String?,
        password:String?,
        user_name:String?
}


//general user model, fill on login, registration or return through decision controller
struct UserProfileStruct {
    
    var full_name:String?,
        dob:String?,
        email:String?,
        date:String?,
        password:String?,
        user_name:String?
}
