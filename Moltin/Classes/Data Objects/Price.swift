//
//  Price.swift
//  Pods
//
//  Created by Oliver Foggin on 28/02/2017.
//
//

import Foundation

import Gloss

public struct Price: JSONAPIDecodable {
    public let amount: Int
    public let currency: String
    public let includesTax: Bool
    public let json: JSON
    
    init?(json: JSON, includedJSON includes: [String : JSON]?) {
        guard let amount: Int = "amount" <~~ json,
            let currency: String = "currency" <~~ json,
            let includesTax: Bool = "includes_tax" <~~ json else {
                return nil
        }
        
        self.amount = amount
        self.currency = currency
        self.includesTax = includesTax
        self.json = json
    }
}

public struct DisplayPrice {
    public let amount: Int
    public let currency: String
    public let formatted: String
    public let json: JSON
    
    init?(json: JSON, includedJSON includes: [String : JSON]?) {
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
