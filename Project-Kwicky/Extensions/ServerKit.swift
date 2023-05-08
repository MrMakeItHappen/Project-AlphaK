//
//  ServerKit.swift
//  Project-Kwicky
//
//  Created by Charlie Arcodia on 5/5/23.
//

import Foundation
import UIKit

//HTTPS wrapper
final class ServerKit {
    
    static let shared = ServerKit() //one instance only
    
    //server connect
    func connect() { //server boot
        
        
    }
    
    //server close
    func disconect() { //server close
        
        
    }
    
    func logout(completion:@escaping(_ isComplete:Bool)->()) {
        //remove token and present decision
        let key = UserPrefStatics.USER_HAS_AUTHENTICATION
        Preferences.shared.removeKey(key: key)
        completion(true)
    }
    
    
    //key is set in checkIfTokenExists
    func onAuth(completion:@escaping(_ hasAuth:Bool)->()) { //check JWT tokjen match and store on frontend
        
        let key = UserPrefStatics.USER_HAS_AUTHENTICATION//stored token
        
        Preferences.shared.checkIfTokenExists(key: key) { hasAuth in
            if  hasAuth {
                Printer().print(message: "🟢 USER HAS AUTH")
                completion(true)
            } else {
                Printer().print(message: "🟡 USER DOES NOT HAVE AUTH")
                completion(false)
            }
        }
    }
    
    //registration
    func onRegister(values:[String:Any], completion : @escaping(_ onSuccess : Bool, _ object : [String : Any])->()) { //server register user
        
        ServiceProvider.shared.serviceRequest(typeOfRequest: .POST, passedParameters: values, endpoint: Statics.signUpEndpoint, requiresAuth: false) { JSON, error in
            
            if error != nil {
                if let error = error {
                    print("🔴 -1 \(error.localizedDescription as Any)")
                    completion(false, [:])
                }
                return
            }
            
            if let JSON = JSON {
                let errors = JSON["errors"] as? [String] ?? ["nil"]
                
                if errors != [] {
                    guard let _ = errors.first else {
                        print("🔴 -2 \(errors)")
                        completion(false, [:])
                        return
                    }
                }
                //success below
                completion(true, JSON)
            } else {
                completion(false, [:])
            }
        }
    }
    
    //verify pin number - takes email/phone and code parameters
    func onVerify(values:[String:Any], completion : @escaping(_ onSuccess : Bool, _ object : [String : Any])->()) { //server register user
        
        ServiceProvider.shared.serviceRequest(typeOfRequest: .POST, passedParameters: values, endpoint: Statics.verifyEndpoint, requiresAuth: false) { JSON, error in
            
            if error != nil {
                if let error = error {
                    print("🔴 -1 \(error.localizedDescription as Any)")
                    completion(false, [:])
                }
                return
            }
            
            if let JSON = JSON {
                let errors = JSON["errors"] as? [String] ?? ["nil"]
                
                if errors != [] {
                    guard let _ = errors.first else {
                        print("🔴 -2 \(errors)")
                        completion(false, [:])
                        return
                    }
                }
                //success below
                completion(true, JSON)
            } else {
                completion(false, [:])
            }
        }
    }
    
    //verify pin number - takes email/phone and code parameters
    func onUsernameVerify(passedUserName:String, completion : @escaping(_ onSuccess : Bool, _ object : [String : Any])->()) { //server register user
        let url = "\(Statics.userNameAvailability)\(passedUserName)"
        print("URL: \(url)")
        ServiceProvider.shared.serviceRequest(typeOfRequest: .GET, passedParameters: nil, endpoint: "\(Statics.userNameAvailability)\(passedUserName)", requiresAuth: true) { JSON, error in
            
            if error != nil {
                if let error = error {
                    print("🔴 -1 \(error.localizedDescription as Any)")
                    completion(false, [:])
                }
                return
            }
            
            if let JSON = JSON {
                let errors = JSON["errors"] as? [String] ?? ["nil"]
                
                if errors != [] {
                    guard let _ = errors.first else {
                        print("🔴 -2 \(errors)")
                        completion(false, [:])
                        return
                    }
                }
                //success below
                completion(true, JSON)
            } else {
                completion(false, [:])
            }
        }
    }
    
    
    //registration
    func onUserObjectUpdate(values:[String:Any], completion : @escaping(_ onSuccess : Bool, _ object : [String : Any])->()) { //requires auth
        
        ServiceProvider.shared.serviceRequest(typeOfRequest: .POST, passedParameters: values, endpoint: Statics.currentUserEndpoint, requiresAuth: true) { JSON, error in
            
            if error != nil {
                if let error = error {
                    print("🔴 -1 \(error.localizedDescription as Any)")
                    completion(false, [:])
                }
                return
            }
            
            if let JSON = JSON {
                let errors = JSON["errors"] as? [String] ?? ["nil"]
                
                if errors != [] {
                    guard let _ = errors.first else {
                        print("🔴 -2 \(errors)")
                        completion(false, [:])
                        return
                    }
                }
                //success below
                completion(true, JSON)
            } else {
                completion(false, [:])
            }
        }
    }
    
}
