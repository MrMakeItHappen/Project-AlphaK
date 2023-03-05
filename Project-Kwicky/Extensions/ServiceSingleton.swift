//
//  ServiceProvider.swift

import Foundation

public enum TypeOfRequest {
    case POST, GET
}

final class ServiceProvider: NSObject {
    
    //MARK: - SINGLETON FOR SHARED SERVICES
    static let shared = ServiceProvider()
    
    func serviceRequest(typeOfRequest: TypeOfRequest, passedParameters : [String : Any]?, endpoint: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        
        var parameters : [String : Any] = [:]
        
        if passedParameters != nil {
            parameters = passedParameters!
        }
        
        var url : URL = URL(string: "nil")!
        
        ///Create global url variable for changes.
        //        url = URL(string: "\(globalBackendDomain)/\(endpoint)")!
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        
        if typeOfRequest == .POST {
            request.httpMethod = "POST"
            
        } else if typeOfRequest == .GET {
            request.httpMethod = "GET"
        }
        
        //Only for POST requests.
        if typeOfRequest == .POST {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
            } catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
        
        ///Heroku Headers
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
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                    return
                }
                
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print("Response is: ", responseJSON)
                }
                
                print("success on the return")
                
                //Success completion for a level 200 status code.
                completion(json, nil)
                
            } catch let error {
                print("error - 4: \(error)")
                print(error.localizedDescription)
                completion(nil, error)
            }
        })
        task.resume()
    }
}
