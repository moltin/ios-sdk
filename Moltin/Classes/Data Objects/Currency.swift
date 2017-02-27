//
//  Currency.swift
//  Pods
//
//  Created by Oliver Foggin on 14/02/2017.
//
//

import Foundation
import Gloss

public struct Currency {
    public let id: String
    public let code: String
    public let exchangeRate: Double
    public let format: String
    public let json: JSON
}

extension Currency: JSONAPIDecodable {
    public init?(json: JSON, includedJSON: [String : JSON]?) {
        guard let id: String = "id" <~~ json,
            let code: String = "code" <~~ json,
            let exchangeRate: Double = "exchange_rate" <~~ json,
            let format: String = "format" <~~ json else {
                return nil
        }
        
        self.id = id
        self.code = code
        self.exchangeRate = exchangeRate
        self.format = format
        self.json = json
    }
}
