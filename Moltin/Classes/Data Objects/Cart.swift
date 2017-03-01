//
//  Cart.swift
//  Pods
//
//  Created by Oliver Foggin on 20/02/2017.
//
//

import Foundation
import Gloss

public struct CartMeta: JSONAPIDecodable {
    public let displayPriceWithTax: DisplayPrice?
    public let displayPriceWithoutTax: DisplayPrice?
    public let json: JSON
    
    init?(json: JSON, includedJSON includes: [String : JSON]?) {
        if let priceJSON: JSON = "display_price.with_tax" <~~ json {
            displayPriceWithTax = DisplayPrice(json: priceJSON, includedJSON: nil)
        } else {
            displayPriceWithTax = nil
        }
        
        if let priceJSON: JSON = "display_price.without_tax" <~~ json {
            displayPriceWithoutTax = DisplayPrice(json: priceJSON, includedJSON: nil)
        } else {
            displayPriceWithoutTax = nil
        }
        
        self.json = json
    }
}

public struct Cart {
    public let id: String
    public let meta: CartMeta?
    public let json: JSON
}

extension Cart : JSONAPIDecodable {
    public init?(json: JSON, includedJSON: [String : JSON]?) {
        guard let id: String = "id" <~~ json else {
                return nil
        }
        
        self.id = id
        
        if let metaJSON: JSON = "meta" <~~ json {
            meta = CartMeta(json: metaJSON, includedJSON: nil)
        } else {
            meta = nil
        }
        
        self.json = json
    }
}
