//
//  Value.swift
//  Pods
//
//  Created by Oliver Foggin on 24/02/2017.
//
//

import Foundation

import Gloss

public struct Value: JSONAPIDecodable {
    public let amount: Int
    public let currency: String
    public let formatted: String
    let json: JSON
    
    init?(json: JSON, includedJSON: [String : JSON]?) {
        guard let amount: Int = "amount" <~~ json,
            let currency: String = "currency" <~~ json,
            let formatted: String = "formatted" <~~ json else {
                return nil
        }
        
        self.amount = amount
        self.currency = currency
        self.formatted = formatted
        self.json = json
    }
}
