//
//  Statics.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/9/23.
//

import Foundation

//TODO: Create Environment Variables for these.

struct Statics {
    static let sandboxDomain = "http://staging.eba-2sjjggtm.us-east-2.elasticbeanstalk.com"
    static let productionDomain = "http://staging.eba-2sjjggtm.us-east-2.elasticbeanstalk.com"
    
    /// Fields can be:
    /// ["email" : "<user email>"]
    /// ["phone" : "<user phone number>"]
    static let signUpEndpoint = "/user/signup"
    
    /// Fields can be:
    /// ["email" : "<user email>"]
    /// ["phone" : "<user phone number>"]
    static let signInEndpoint = "/user/signin"
    
    static let currentUserEndpoint = "/user"
    
    /// Fields will be:
    /// ["email" : "<user email>",
    /// "phone" : "<user phone number>",
    /// "code" : "<sent verification code>"]
    static let verifyEndpoint = "/user/verify"
    
    /// GET Request. Returns
    /// ["data" : "<boolean>",
    /// "errors" : [] ]
    static let userNameAvailability = "/user/available/:username"
    
    static let JSONFailedToLoad = "JSON FETCHING FAILED!"
    static let unknownError = "Something Went Wrong!"
    static let invalidParameters = "Check the parameters. Something is incorrect!"

    static let mixpanelAuthToken = "c0ef9a6d40f11836eed4e8f27fbe678f"
}
