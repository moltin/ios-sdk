//
//  CartItem.swift
//  Pods
//
//  Created by Oliver Foggin on 22/02/2017.
//
//

import Foundation

import Gloss

public struct CustomItem {
    let name: String
    let sku: String
    let description: String
    let quantity: UInt
    let price: UInt
}

public struct CartItem {
    public let id: String
    public let productID: String
    public let name: String
    public let sku: String
    public let quantity: Int
    public let unitPriceWithTax: DisplayPrice?
    public let totalPriceWithTax: DisplayPrice?
    public let unitPriceWithoutTax: DisplayPrice?
    public let totalPriceWithoutTax: DisplayPrice?
    public let json: JSON
}

extension CartItem: JSONAPIDecodable {
    init?(json: JSON, includedJSON: [String : JSON]?) {
        guard let id: String = "id" <~~ json,
            let productID: String = "product_id" <~~ json,
            let name: String = "name" <~~ json,
            let sku: String = "sku" <~~ json,
            let quantity: Int = "quantity" <~~ json else {
                return nil
        }
        
        self.id = id
        self.productID = productID
        self.name = name
        self.sku = sku
        self.quantity = quantity
        
        if let priceJSON: JSON = "meta.display_price.with_tax.unit" <~~ json {
            unitPriceWithTax = DisplayPrice(json: priceJSON, includedJSON: nil)
        } else {
            unitPriceWithTax = nil
        }
        
        if let priceJSON: JSON = "meta.display_price.without_tax.unit" <~~ json {
            unitPriceWithoutTax = DisplayPrice(json: priceJSON, includedJSON: nil)
        } else {
            unitPriceWithoutTax = nil
        }
        
        if let priceJSON: JSON = "meta.display_price.with_tax.value" <~~ json {
            totalPriceWithTax = DisplayPrice(json: priceJSON, includedJSON: nil)
        } else {
            totalPriceWithTax = nil
        }
        
        if let priceJSON: JSON = "meta.display_price.without_tax.value" <~~ json {
            totalPriceWithoutTax = DisplayPrice(json: priceJSON, includedJSON: nil)
        } else {
            totalPriceWithoutTax = nil
        }
        
        self.json = json
    }
}
