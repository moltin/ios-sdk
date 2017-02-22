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
    public let json: JSON
}

extension CartItem: JSONAPIDecodable {
    init?(json: JSON, includedJSON: JSON?) {
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
        self.json = json
    }
}
