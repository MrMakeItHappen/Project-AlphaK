//
//  ServerKit.swift
//  Project-Kwicky
//
//  Created by Charlie Arcodia on 5/5/23.
//
/*
 
 /user/signup
 
 "phone":"8455581855"
 ||
 "email":"charliearcodia@gmail.com"
 
 //wait for pin then hit
 /user/verify
 
 "phone":"8455581855"
 ||
 "email":"charliearcodia@gmail.com"
 "code": "123456"
 
 
 
 
 
 
 
 */



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
    
    func hasAuth() { //check JWT tokjen match and store on frontend
        
        
    }
    
    //registration
    func onRegister(values:[String:Any], completion : @escaping(_ onSuccess : Bool, _ object : [String : Any])->()) { //server register user
        
        ServiceProvider.shared.serviceRequest(typeOfRequest: .POST, passedParameters: values, endpoint: Statics.signUpEndpoint) { JSON, error in
            
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
        
        ServiceProvider.shared.serviceRequest(typeOfRequest: .POST, passedParameters: values, endpoint: Statics.verifyEndpoint) { JSON, error in
            
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
    func onLogin() { //server login user
        
        
    }
    
}
