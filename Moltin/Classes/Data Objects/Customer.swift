//
//  Customer.swift
//  Pods
//
//  Created by Oliver Foggin on 22/02/2017.
//
//

import Foundation

import Gloss

public struct Customer {
    public let name: String
    public let email: String
    
    var dictionaryRepresentation: [String : Any] {
        return [
            "name" : name,
            "email" : email
        ]
    }
}

extension Customer: JSONAPIDecodable {
    init?(json: JSON, includedJSON: JSON?) {
        guard let name: String = "name" <~~ json,
            let email: String = "email" <~~ json else {
                return nil
        }
        
        self.name = name
        self.email = email
    }
}
