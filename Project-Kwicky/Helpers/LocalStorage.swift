//
//  LocalStorage.swift
//  Project-Kwicky
//
//  Created by Charlie Arcodia on 5/7/23.
//

import Foundation

struct UserPrefStatics {
    static let USER_HAS_AUTHENTICATION = "USER_HAS_AUTHENTICATION"
}

class Preferences : NSObject {
    
    static let shared = Preferences()
    
    ////add the key if nil
    func addJwtToken(jwtToken:String, key : String) {
        UserDefaults.standard.setValue(jwtToken, forKey: key)
    }
    
    ///check if the key exists and set the token to be user in request headers
    func checkIfTokenExists(key : String, completion : @escaping (_ isComplete : Bool)->()) {
        if let token = UserDefaults.standard.object(forKey: key) as? String {
            _jwtToken = token
            completion(true)
        } else {
            _jwtToken = nil
            completion(false)
        }
    }
}
