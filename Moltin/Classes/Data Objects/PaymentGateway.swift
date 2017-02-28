//
//  PaymentGateway.swift
//  Pods
//
//  Created by Oliver Foggin on 24/02/2017.
//
//

import Foundation

import Gloss

public struct PaymentGateway: JSONAPIDecodable {
    public let name: String
    public let slug: String
    let json: JSON
    
    init?(json: JSON, includedJSON: [String : JSON]?) {
        guard let name: String = "name" <~~ json,
            let slug: String = "slug" <~~ json else {
                return nil
        }
        
        self.name = name
        self.slug = slug
        self.json = json
    }
}
