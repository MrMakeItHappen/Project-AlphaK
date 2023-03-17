//
//  Statics.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/9/23.
//

import Foundation

struct Statics {
    static let sandboxDomain = "http://staging.eba-2sjjggtm.us-east-2.elasticbeanstalk.com"
    static let productionDomain = "http://staging.eba-2sjjggtm.us-east-2.elasticbeanstalk.com"
    
    static let signUpEndpoint = "/user/signup"
    static let signInEndpoint = "/user/signin"
    static let currentUserEndpoint = "/user"
    
    static let userNameAvailability = "/user/available/:username"
    
    static let JSONFailedToLoad = "JSON FETCHING FAILED!"
    static let unknownError = "Something Went Wrong!"
    static let invalidParameters = "Check the parameters. Something is incorrect!"
}
