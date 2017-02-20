//
//  Auth.swift
//  Moltin
//
//  Created by Oliver Foggin on 14/02/2017.
//  Copyright © 2017 Oliver Foggin. All rights reserved.
//

import Foundation
import Alamofire
import Gloss

class Auth {
    var token: String? {
        didSet {
            UserDefaults.standard.set(token, forKey: "Moltin.auth.token")
            UserDefaults.standard.synchronize()
        }
    }
    
    private var expires: Date? {
        didSet {
            UserDefaults.standard.set(expires, forKey: "Moltin.auth.expires")
            UserDefaults.standard.synchronize()
        }
    }
    
    init() {
        token = UserDefaults.standard.value(forKey: "Moltin.auth.token") as? String
        expires = UserDefaults.standard.value(forKey: "Moltin.auth.expires") as? Date
    }
    
    private var requiresRefresh: Bool {
        guard let expires = expires,
            token != nil else {
                return true
        }
        
        return expires <= Date()
    }
    
    func authenticate(completion: @escaping () -> ()) {
        guard requiresRefresh else {
            completion()
            return
        }
        
        Alamofire.upload(multipartFormData: appendFormData, with: Router.authenticate) {
            result in
            
            switch result {
            case .failure(let error):
                print(error)
            case .success(let request, let streamingFromDisk, let streamFileURL):
                self.processAuthenticationRequest(request: request, completion: completion)
            }
        }
    }
    
    private func appendFormData(data: MultipartFormData) {
        guard let clientID = Moltin.clientID else {
            fatalError("Please set the Moltin.clientID before making a request")
            return
        }
        
        data.append(clientID.data(using: .utf8)!, withName: "client_id")
        data.append("implicit".data(using: .utf8)!, withName: "grant_type")
    }
    
    private func processAuthenticationRequest(request: UploadRequest, completion: @escaping () -> ()) {
        request.responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let json):
                print("\(json)")
                
                guard let json = json as? JSON,
                    let authToken: String = "access_token" <~~ json,
                    let expiresEpoch: Int = "expires" <~~ json else {
                        return
                }
                
                self.token = authToken
                self.expires = Date(timeIntervalSince1970: TimeInterval(expiresEpoch))
            }
            
            completion()
        }
    }
}
