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
    public let unitPrice: Price
    public let valuePrice: Price
    public let unitDisplayPriceWithTax: DisplayPrice?
    public let totalDisplayPriceWithTax: DisplayPrice?
    public let unitDisplayPriceWithoutTax: DisplayPrice?
    public let totalDisplayPriceWithoutTax: DisplayPrice?
    public let json: JSON
}

extension CartItem: JSONAPIDecodable {
    init?(json: JSON, includedJSON: [String : JSON]?) {
        guard let id: String = "id" <~~ json,
            let productID: String = "product_id" <~~ json,
            let name: String = "name" <~~ json,
            let sku: String = "sku" <~~ json,
            let quantity: Int = "quantity" <~~ json,
            let unitPriceJSON: JSON = "unit_price" <~~ json,
            let unitPrice = Price(json: unitPriceJSON, includedJSON: nil),
            let valuePriceJSON: JSON = "value" <~~ json,
            let valuePrice = Price(json: valuePriceJSON, includedJSON: nil) else {
                return nil
        }
        
        self.id = id
        self.productID = productID
        self.name = name
        self.sku = sku
        self.quantity = quantity
        self.unitPrice = unitPrice
        self.valuePrice = valuePrice
        
        if let priceJSON: JSON = "meta.display_price.with_tax.unit" <~~ json {
            unitDisplayPriceWithTax = DisplayPrice(json: priceJSON, includedJSON: nil)
        } else {
            unitDisplayPriceWithTax = nil
        }
        
        if let priceJSON: JSON = "meta.display_price.without_tax.unit" <~~ json {
            unitDisplayPriceWithoutTax = DisplayPrice(json: priceJSON, includedJSON: nil)
        } else {
            unitDisplayPriceWithoutTax = nil
        }
        
        if let priceJSON: JSON = "meta.display_price.with_tax.value" <~~ json {
            totalDisplayPriceWithTax = DisplayPrice(json: priceJSON, includedJSON: nil)
        } else {
            totalDisplayPriceWithTax = nil
        }
        
        if let priceJSON: JSON = "meta.display_price.without_tax.value" <~~ json {
            totalDisplayPriceWithoutTax = DisplayPrice(json: priceJSON, includedJSON: nil)
        } else {
            totalDisplayPriceWithoutTax = nil
        }
        
        self.json = json
    }
}
