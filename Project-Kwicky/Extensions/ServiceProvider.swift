//
//  ServiceProvider.swift

import Foundation

public enum TypeOfRequest {
    case POST, GET
}

final class ServiceProvider: NSObject {
    
    static let shared = ServiceProvider()
    
    func serviceRequest(typeOfRequest: TypeOfRequest, passedParameters : [String : Any]?, endpoint: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        
        var parameters : [String : Any] = [:]
        
        if passedParameters != nil {
            parameters = passedParameters!
        } else {
            print(Statics.invalidParameters)
            return
        }
        
        var url : URL = URL(string: "nil")!
        url = URL(string: "\(Statics.productionDomain)\(endpoint)")!
        //        print("ENDPOINT URL - ", url)
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        
        if typeOfRequest == .POST {
            request.httpMethod = "POST"
            
        } else if typeOfRequest == .GET {
            request.httpMethod = "GET"
        }
        
        if typeOfRequest == .POST {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
            } catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                    completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                    return
                }
                
                completion(json, nil)
                
            } catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        })
        task.resume()
    }
}

//Do not call. Examples only.
extension ServiceProvider {
    func serverSignUp(with values: [String : Any]) {
        
        //        Key/Value Example
        //        ["email" : "me@cryptobyte.com"]
        
        ServiceProvider.shared.serviceRequest(typeOfRequest: .POST, passedParameters: values, endpoint: Statics.signUpEndpoint) { JSON, error in
            
            if error != nil {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }
            
            if let JSON = JSON {
                let errors = JSON["errors"] as? [String] ?? ["nil"]
                let returnedData = JSON["data"] as? String ?? "This is a hard NULL from the server"
                
                if errors != [] {
                    guard let error = errors.first else { return }
                    print("ERROR - ", error)
                    return
                }
                
                print("SUCCESSFUL SIGN UP!")
                print("JSON Response - ", returnedData)
                
            } else {
                print(Statics.JSONFailedToLoad)
            }
        }
    }
    
    func serverSignIn(with values: [String : Any]) {
        
        //        Key/Value Example
        //        ["email" : "me@cryptobyte.dev"]
        
        ServiceProvider.shared.serviceRequest(typeOfRequest: .POST, passedParameters: values, endpoint: Statics.signInEndpoint) { JSON, error in
            
            if error != nil {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }
            
            if let JSON = JSON {
                let errors = JSON["errors"] as? [String] ?? ["nil"]
                let returnedData = JSON["data"] as? String ?? "This is a hard NULL from the server"
                
                if errors != [] {
                    guard let error = errors.first else { return }
                    print("ERROR - ", error)
                    return
                }
                
                print(returnedData)
                
                
            } else {
                print(Statics.JSONFailedToLoad)
            }
        }
    }
    
    func checkUsernameAvailability(for values: [String : Any]) {
        
        //        Key/Value Example
        //        ["username" : "Cryptobyte"]
        
        ServiceProvider.shared.serviceRequest(typeOfRequest: .GET, passedParameters: values, endpoint: Statics.userNameAvailability) { JSON, error in
            
            if error != nil {
                if let error = error {
                    print(error.localizedDescription)
                }
                
                return
            }
            
            if let JSON = JSON {
                let errors = JSON["errors"] as? [String] ?? ["nil"]
                let isAvailable = JSON["data"] as? Bool ?? false
                
                if errors != [] {
                    guard let error = errors.first else { return }
                    print("ERROR - ", error)
                    return
                }
                
                if isAvailable == true {
                    print("Username is available")
                } else {
                    print("Username is unavailable")
                }
                
            } else {
                print(Statics.JSONFailedToLoad)
            }
        }
    }
    
    func verifyUser(for values: [String : Any]) {
        //        POST
        //        ["email" : "<user email",
        //         "phone" : "<user phone number>",
        //         "code" : "<verification code>"]
        
        ServiceProvider.shared.serviceRequest(typeOfRequest: .GET, passedParameters: values, endpoint: Statics.verifyEndpoint) { JSON, error in
            
            if error != nil {
                if let error = error {
                    print(error.localizedDescription)
                }
                
                return
            }
            
            if let JSON = JSON {
                let errors = JSON["errors"] as? [String] ?? ["nil"]
                let jwtToken = JSON["data"] as? String ?? "This is a hard NULL from the server"
                
                if errors != [] {
                    guard let error = errors.first else { return }
                    print("ERROR - ", error)
                    return
                }
                
                //TODO: Store this token
                print("JWT TOKEN - ", jwtToken)
                
            } else {
                print(Statics.JSONFailedToLoad)
            }
        }
    }
}
