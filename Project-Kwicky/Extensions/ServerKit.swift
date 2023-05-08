//
//  ServerKit.swift
//  Project-Kwicky
//
//  Created by Charlie Arcodia on 5/3/23.
//

import Foundation
import UIKit

//HTTPS wrapper
final class ServerKit {
    
    static let shared = ServerKit() //one instance only
  
    //removes the JWT token and presents decision controller on completion
    func logout(completion:@escaping(_ isComplete:Bool)->()) {
        //remove token and present decision
        let key = UserPrefStatics.USER_HAS_AUTHENTICATION
        Preferences.shared.removeKey(key: key)
        completion(true)
    }
    
    func onUserModelInitialFill(completion:@escaping(_ isComplete:Bool)->()) {
        
        ServiceProvider.shared.serviceRequest(typeOfRequest: .GET, passedParameters: nil, endpoint: Statics.currentUserEndpoint, requiresAuth: true) { JSON, error in
            
            if error != nil {
                if let error = error {
                    print("🔴 -1 \(error.localizedDescription as Any)")
                    completion(false)
                }
                return
            }
            
            if let JSON = JSON {
                let errors = JSON["errors"] as? [String] ?? ["nil"]
                
                if errors != [] {
                    guard let _ = errors.first else {
                        print("🔴 -2 \(errors)")
                        completion(false)
                        return
                    }
                }
                
                //data object
                if let data = JSON["data"] as? [String : Any] {
                
                //user object - use data
                let phone = data["phone"] as? String ?? "nil"
                let email = data["email"] as? String ?? "nil"
                let username = data["username"] as? String ?? "nil"
                let uid = data["uid"] as? String ?? "nil"
                let avatar = data["avatar"] as? String ?? "nil"
                let name = data["name"] as? String ?? "nil"
                let bio = data["bio"] as? String ?? "nil"
                let link = data["link"] as? String ?? "nil"
                let pronouns = data["pronouns"] as? String ?? "nil"
                let location = data["location"] as? String ?? "nil"
                let languages = data["languages"] as? [String] ?? ["nil"]
                let birthdate = data["birthdate"] as? String ?? "nil"
                let accountType = data["accountType"] as? String ?? "nil"
                let signUpMethod = data["signUpMethod"] as? String ?? "nil"
                let notifications = data["notifications"] as? [String:Bool] ?? ["nil":false] //deep nest
                   
                    //notifications all booleans - use notifications
                    let profileViews = notifications["profileViews"] ?? false
                    let reposts = notifications["reposts"] ?? false
                    let newFollowers = notifications["newFollowers"] ?? false
                    let comments = notifications["comments"] ?? false
                    let directMessages = notifications["directMessages"] ?? false
                    let directMessagesPreview = notifications["directMessagesPreview"] ?? false
                    let mentionsTags = notifications["mentionsTags"] ?? false
                    let likes = notifications["likes"] ?? false
                    
                        userProfileStruct.phone = phone
                        userProfileStruct.email = email
                        userProfileStruct.username = username
                        userProfileStruct.uid = uid
                        userProfileStruct.avatar = avatar
                        userProfileStruct.name = name
                        userProfileStruct.bio = bio
                        userProfileStruct.link = link
                        userProfileStruct.pronouns = pronouns
                        userProfileStruct.location = location
                        userProfileStruct.languages = languages
                        userProfileStruct.birthdate = birthdate
                        userProfileStruct.accountType = accountType
                        userProfileStruct.notifications = notifications
                        userProfileStruct.profileViews = profileViews
                        userProfileStruct.reposts = reposts
                        userProfileStruct.newFollowers = newFollowers
                        userProfileStruct.comments = comments
                        userProfileStruct.directMessages = directMessages
                        userProfileStruct.directMessagesPreview = directMessagesPreview
                        userProfileStruct.mentionsTags = mentionsTags
                        userProfileStruct.likes = likes
                        userProfileStruct.signUpMethod = signUpMethod

                //success below
                print("🟢 USER OBJECT UPDATED")
                completion(true)
                
                }
            } else {
                completion(false)
            }
        }
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
    
    //registration
    func onLogin(values:[String:Any], completion : @escaping(_ onSuccess : Bool, _ object : [String : Any])->()) { //server register user
        
        ServiceProvider.shared.serviceRequest(typeOfRequest: .POST, passedParameters: values, endpoint: Statics.signInEndpoint, requiresAuth: false) { JSON, error in
            
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
